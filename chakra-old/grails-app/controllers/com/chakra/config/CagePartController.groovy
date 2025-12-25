package com.chakra.config


import org.springframework.dao.DataIntegrityViolationException
import java.awt.image.BufferedImage
import javax.imageio.ImageIO
import org.imgscalr.Scalr

import com.chakra.notifications.Notification
import com.chakra.service.NotificationService

class CagePartController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService
	NotificationService notificationService = new NotificationService()
	//def users = User.findByUsername("admin")
	//log.debug users.username
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cagePartInstanceList: CagePart.list(params), cagePartInstanceTotal: CagePart.count()]
    }

    def create() {
        [cagePartInstance: new CagePart(params)]
    }

    def save() {
        def cagePartInstance = new CagePart(params)
		def reqImage = request.getFile("cagePartImage")
		
		InputStream image = reqImage.inputStream
		
		def imageIn = ImageIO.read(image)
		BufferedImage scaledImage = Scalr.resize(imageIn, 50)
		BufferedImage scaledImage_1 = Scalr.resize(imageIn, 150)
		println "After: Width:"+scaledImage.getWidth()+" Height:"+scaledImage.getHeight()
		
		def thumbnail = new java.io.File("D:\\sample.jpeg")
		def thumbnail_1 = new java.io.File("D:\\sample_1.jpeg")
		
		ImageIO.write(scaledImage, "jpeg", thumbnail)
		ImageIO.write(scaledImage_1, "jpeg", thumbnail_1)
		
		cagePartInstance.cagePartThumbnail = thumbnail.getBytes()
		cagePartInstance.cagePartImage = thumbnail_1.getBytes()
		if (!cagePartInstance.save(flush: true)) {
            render(view: "create", model: [cagePartInstance: cagePartInstance])
            return
        }
		
		notificationService.addNotification(springSecurityService.currentUser.toString(), Notification.NOTIFMSG_NEW_CAGEPART, true, ""+g.link(action:"show", controller:"cagePart", id: cagePartInstance.id) { cagePartInstance.cagePart }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.created.message', args: [message(code: 'cagePart.label', default: 'CagePart'), cagePartInstance.id])
        redirect(action: "show", id: cagePartInstance.id)
    }

    def show() {
        def cagePartInstance = CagePart.get(params.id)
        if (!cagePartInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePart.label', default: 'CagePart'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartInstance: cagePartInstance]
    }

    def edit() {
		def cagePartInstance = CagePart.get(params.id)
		if (!cagePartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePart.label', default: 'CagePart'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartInstance: cagePartInstance]
    }

    def update() {
        def cagePartInstance = CagePart.get(params.id)
        if (!cagePartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePart.label', default: 'CagePart'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cagePartInstance.version > version) {
                cagePartInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cagePart.label', default: 'CagePart')] as Object[],
                          "Another user has updated this CagePart while you were editing")
                render(view: "edit", model: [cagePartInstance: cagePartInstance])
                return
            }
        }

        cagePartInstance.properties = params
		
		def uploadedImage = request.getFile("cagePartImage")
		def name = uploadedImage.getOriginalFilename()
		println'name '+name
		
		if(!uploadedImage.empty) {
			
			InputStream image = uploadedImage.inputStream
			
			def imageIn = ImageIO.read(image)
			BufferedImage scaledImage = Scalr.resize(imageIn, 50)
			BufferedImage scaledImage_1 = Scalr.resize(imageIn, 150)
			//println "After: Width:"+scaledImage.getWidth()+" Height:"+scaledImage.getHeight()
			
			def thumbnail = new java.io.File("D:\\sample.jpeg")
			def thumbnail_1 = new java.io.File("D:\\sample_1.jpeg")
			
			ImageIO.write(scaledImage, "jpeg", thumbnail)
			ImageIO.write(scaledImage_1, "jpeg", thumbnail_1)
			
			cagePartInstance.cagePartThumbnail = thumbnail.getBytes()
			cagePartInstance.cagePartImage = thumbnail_1.getBytes()
			
		}		

        if (!cagePartInstance.save(flush: true)) {
            render(view: "edit", model: [cagePartInstance: cagePartInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePart.label', default: 'CagePart'), cagePartInstance.id])
        redirect(action: "show", id: cagePartInstance.id)
    }

    def delete() {
        def cagePartInstance = CagePart.get(params.id)
        if (!cagePartInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePart.label', default: 'CagePart'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cagePartInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePart.label', default: 'CagePart'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cagePart.label', default: 'CagePart'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def showImage() {
		def cagePartInstance = CagePart.get(params.id)
		response.outputStream << (cagePartInstance?.cagePartThumbnail)
	}
}
