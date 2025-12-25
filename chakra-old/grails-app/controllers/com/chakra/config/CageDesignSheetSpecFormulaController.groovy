package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import com.chakra.notifications.Notification
import com.chakra.security.User
import com.chakra.service.NotificationService

@Secured(['ROLE_ADMIN'])
class CageDesignSheetSpecFormulaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def exportService
	def grailsApplication
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 50, 100)
		
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=CageDesignSpecForm.${params.extension}")

			exportService.export(params.format, response.outputStream,CageDesignSheetSpecFormula.list(params), [:], [:])
		}
		
        [cageDesignSheetSpecFormulaInstanceList: CageDesignSheetSpecFormula.list(params), cageDesignSheetSpecFormulaInstanceTotal: CageDesignSheetSpecFormula.count()]
    }

    def create() {
        [cageDesignSheetSpecFormulaInstance: new CageDesignSheetSpecFormula(params)]
    }

    def save() {
        def cageDesignSheetSpecFormulaInstance = new CageDesignSheetSpecFormula(params)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cageDesignSheetSpecFormulaInstance.save(flush: true)) {
            render(view: "create", model: [cageDesignSheetSpecFormulaInstance: cageDesignSheetSpecFormulaInstance])
            return
        }

		notificationService.addNotification(users.username, Notification.NOTIFMSG_NEW_CAGEDESIGN_SHEETSPEC, true, ""+g.link(action:"list", controller:"cageDesignSheetSpecFormula", id: cageDesignSheetSpecFormulaInstance.id) { cageDesignSheetSpecFormulaInstance.cageDesign }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.created.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), cageDesignSheetSpecFormulaInstance.id])
        redirect(action: "show", id: cageDesignSheetSpecFormulaInstance.id)
    }

    def show() {
        def cageDesignSheetSpecFormulaInstance = CageDesignSheetSpecFormula.get(params.id)
        if (!cageDesignSheetSpecFormulaInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), params.id])
            redirect(action: "list")
            return
        }

        [cageDesignSheetSpecFormulaInstance: cageDesignSheetSpecFormulaInstance]
    }

    def edit() {
        def cageDesignSheetSpecFormulaInstance = CageDesignSheetSpecFormula.get(params.id)
        if (!cageDesignSheetSpecFormulaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), params.id])
            redirect(action: "list")
            return
        }

        [cageDesignSheetSpecFormulaInstance: cageDesignSheetSpecFormulaInstance]
    }

    def update() {
        def cageDesignSheetSpecFormulaInstance = CageDesignSheetSpecFormula.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cageDesignSheetSpecFormulaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cageDesignSheetSpecFormulaInstance.version > version) {
                cageDesignSheetSpecFormulaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula')] as Object[],
                          "Another user has updated this CageDesignSheetSpecFormula while you were editing")
                render(view: "edit", model: [cageDesignSheetSpecFormulaInstance: cageDesignSheetSpecFormulaInstance])
                return
            }
        }

        cageDesignSheetSpecFormulaInstance.properties = params

        if (!cageDesignSheetSpecFormulaInstance.save(flush: true)) {
            render(view: "edit", model: [cageDesignSheetSpecFormulaInstance: cageDesignSheetSpecFormulaInstance])
            return
        }
		
		notificationService.addNotification(users.username, Notification.NOTIFMSG_UPDATE_CAGEDESIGN_SHEETSPEC, true, ""+g.link(action:"list", controller:"cageDesignSheetSpecFormula", id: cageDesignSheetSpecFormulaInstance.id) { cageDesignSheetSpecFormulaInstance.id }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.updated.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), cageDesignSheetSpecFormulaInstance.id])
        redirect(action: "show", id: cageDesignSheetSpecFormulaInstance.id)
    }

    def delete() {
        def cageDesignSheetSpecFormulaInstance = CageDesignSheetSpecFormula.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cageDesignSheetSpecFormulaInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cageDesignSheetSpecFormulaInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), params.id])
			notificationService.addNotification(users.username, Notification.NOTIFMSG_DELETE_CAGEDESIGN_SHEETSPEC, true, ""+g.link(action:"list", controller:"cageDesignSheetSpecFormula", id: cageDesignSheetSpecFormulaInstance.id) { cageDesignSheetSpecFormulaInstance.id }, Notification.NOTIFTYPE_APP)
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
