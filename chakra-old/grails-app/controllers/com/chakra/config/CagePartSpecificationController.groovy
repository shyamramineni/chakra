package com.chakra.config

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

import org.springframework.dao.DataIntegrityViolationException

import com.chakra.notifications.Notification
import com.chakra.security.User
import com.chakra.service.NotificationService

//@Secured(['ROLE_ADMIN'])
class CagePartSpecificationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cagePartSpecificationInstanceList: CagePartSpecification.list(params), cagePartSpecificationInstanceTotal: CagePartSpecification.count()]
    }

    def create() {
        [cagePartSpecificationInstance: new CagePartSpecification(params)]
    }

    def save() {
        def cagePartSpecificationInstance = new CagePartSpecification(params)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cagePartSpecificationInstance.save(flush: true)) {
            render(view: "create", model: [cagePartSpecificationInstance: cagePartSpecificationInstance])
            return
        }

		notificationService.addNotification(users.username, Notification.NOTIFMSG_NEW_CAGEPART_SPEC, true, ""+g.link(action:"list", controller:"cagePartSpecification", id: cagePartSpecificationInstance.id) { cagePartSpecificationInstance.cagePartSpecification }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.created.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), cagePartSpecificationInstance.id])
        redirect(action: "show", id: cagePartSpecificationInstance.id)
    }

    def show() {
        def cagePartSpecificationInstance = CagePartSpecification.get(params.id)
        if (!cagePartSpecificationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartSpecificationInstance: cagePartSpecificationInstance]
    }

    def edit() {
        def cagePartSpecificationInstance = CagePartSpecification.get(params.id)
        if (!cagePartSpecificationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartSpecificationInstance: cagePartSpecificationInstance]
    }

    def update() {
        def cagePartSpecificationInstance = CagePartSpecification.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cagePartSpecificationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cagePartSpecificationInstance.version > version) {
                cagePartSpecificationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification')] as Object[],
                          "Another user has updated this CagePartSpecification while you were editing")
                render(view: "edit", model: [cagePartSpecificationInstance: cagePartSpecificationInstance])
                return
            }
        }

        cagePartSpecificationInstance.properties = params

        if (!cagePartSpecificationInstance.save(flush: true)) {
            render(view: "edit", model: [cagePartSpecificationInstance: cagePartSpecificationInstance])
            return
        }

		notificationService.addNotification(users.username, Notification.NOTIFMSG_UPDATE_CAGEPART_SPEC, true, ""+g.link(action:"list", controller:"cagePartSpecification", id: cagePartSpecificationInstance.id) { cagePartSpecificationInstance.id }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), cagePartSpecificationInstance.id])
        redirect(action: "show", id: cagePartSpecificationInstance.id)
    }

    def delete() {
        def cagePartSpecificationInstance = CagePartSpecification.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cagePartSpecificationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cagePartSpecificationInstance.delete(flush: true)
			notificationService.addNotification(users.username, Notification.NOTIFMSG_DELETE_CAGEPART_SPEC, true, ""+g.link(action:"list", controller:"cagePartSpecification", id: cagePartSpecificationInstance.id) { cagePartSpecificationInstance.id }, Notification.NOTIFTYPE_APP)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def cagePartSpecification(){
		println'params '+params
		def cagePartTypeData = JSON.parse(params.requestData)
		println'cagePartTypeData '+cagePartTypeData
		def cagePartType = cagePartTypeData.id
		def cagePartTypeInstance = CagePartType.get(cagePartType)
		println'cagePartTypeInstance '+cagePartTypeInstance
		def cagePartSpecList = CagePartSpecification.findAllByCagePartType(cagePartTypeInstance)
		println'cagePartSpecList '+cagePartSpecList
		String html 
		html = '<option value="">Select</option>'
		for(int i=0;(i<=cagePartSpecList.size()-1);i++){
			println"<option>"+cagePartSpecList.getAt(i)+"</option>"
			html += "<option class=\"option_field\" value=\""+cagePartSpecList.getAt(i).id+"\">"+cagePartSpecList.getAt(i)+"</option>"
		}
		render html
	}
}
