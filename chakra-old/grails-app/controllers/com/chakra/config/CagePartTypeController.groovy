package com.chakra.config

import grails.converters.*
import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import com.chakra.notifications.Notification
import com.chakra.security.User
import com.chakra.service.NotificationService

//@Secured(['ROLE_ADMIN'])
class CagePartTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cagePartTypeInstanceList: CagePartType.list(params), cagePartTypeInstanceTotal: CagePartType.count()]
    }

    def create() {
        [cagePartTypeInstance: new CagePartType(params)]
    }

    def save() {
        def cagePartTypeInstance = new CagePartType(params)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cagePartTypeInstance.save(flush: true)) {
            render(view: "create", model: [cagePartTypeInstance: cagePartTypeInstance])
            return
        }

		notificationService.addNotification(users.username, Notification.NOTIFMSG_NEW_CAGEPART_TYPE, true, ""+g.link(action:"list", controller:"cagePartType", id: cagePartTypeInstance.id) { cagePartTypeInstance.cagePartType }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.created.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), cagePartTypeInstance.id])
        redirect(action: "show", id: cagePartTypeInstance.id)
    }

    def show() {
        def cagePartTypeInstance = CagePartType.get(params.id)
        if (!cagePartTypeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartTypeInstance: cagePartTypeInstance]
    }

    def edit() {
        def cagePartTypeInstance = CagePartType.get(params.id)
        if (!cagePartTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartTypeInstance: cagePartTypeInstance]
    }

    def update() {
        def cagePartTypeInstance = CagePartType.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cagePartTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cagePartTypeInstance.version > version) {
                cagePartTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cagePartType.label', default: 'CagePartType')] as Object[],
                          "Another user has updated this CagePartType while you were editing")
                render(view: "edit", model: [cagePartTypeInstance: cagePartTypeInstance])
                return
            }
        }

        cagePartTypeInstance.properties = params

        if (!cagePartTypeInstance.save(flush: true)) {
            render(view: "edit", model: [cagePartTypeInstance: cagePartTypeInstance])
            return
        }

		notificationService.addNotification(users.username, Notification.NOTIFMSG_UPDATE_CAGEPART_TYPE, true, ""+g.link(action:"list", controller:"cagePartType", id: cagePartTypeInstance.id) { cagePartTypeInstance.id }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), cagePartTypeInstance.id])
        redirect(action: "show", id: cagePartTypeInstance.id)
    }

    def delete() {
        def cagePartTypeInstance = CagePartType.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cagePartTypeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cagePartTypeInstance.delete(flush: true)
			notificationService.addNotification(users.username, Notification.NOTIFMSG_DELETE_CAGEPART_TYPE, true, ""+g.link(action:"list", controller:"cagePartType", id: cagePartTypeInstance.id) { cagePartTypeInstance.id }, Notification.NOTIFTYPE_APP)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def ajaxGetCagePartType() {
		log.debug params.id
		def cagePartType = CagePartType.get(params.id)
		render g.select(from: cagePartType?.cagePartSpecifications,  name: 'cagePartSpecification.id', noSelection:['':'Select One...'], optionKey: 'id')
		return		
		
	}
	
	def ajaxGetCagePartSpec() {
		log.debug params.id
		def cagePartSpecification = CagePartSpecification.get(params.id)
		render g.select(from: cagePartSpecification?.cagePartSpecFormulaList,  name: 'cagePartSpecFormula.id', optionKey: 'id')
		return		
		
	}
	
	def getCageParts() {
		def cagePartSpecification = CagePartSpecification.get(params.id)
		println'cagePartSpecification '+cagePartSpecification
		def cagePartList = CagePartSpecFormula.findAllByCagePartSpecification(cagePartSpecification)
		println'cagePartList'+cagePartList
		List cageItems = new ArrayList()
		cagePartList.each { cagePart ->
			def cagePartPrice = CagePartPrice.findByCagePart(cagePart.cagePart)
			cageItems.add(
				"id":cagePart.id, "name":cagePart.cagePart.cagePart, "itemId":cagePart.cagePart.cagePartCode, "pic_url":"http://localhost:8080/chakrap/cagePart/showImage/"+cagePart.id, "desc":cagePart.cagePart.description, "price":cagePartPrice.price)
		}
		
		println'cageItems '+cageItems
		
		def responseData = [cageItems: cageItems]
		println'responseData '+responseData
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': cageItems ? "OK" : "NODATA"
	
		]}
		
		return		
	}
	
	def cagePartType(){
		println'param '+params
		def cagePartTypeList = CagePartType.findAll()
		println'cagePartTypeList '+cagePartTypeList
		String html
		html = '<option value="null">Select</option>'
		for(int i=0;(i<=cagePartTypeList.size()-1);i++){
			println"<option>"+cagePartTypeList.getAt(i)+"</option>"
			html += '<option value="'+cagePartTypeList.getAt(i).id+'">'+cagePartTypeList.getAt(i)+"</option>"
			/*def cageDesign = cageDesignList.getAt(i)
			println'childCageDesign.size() '+cageDesign.childCageDesign.size()
			println'childCageDesign '+cageDesign.childCageDesign.getAt(i)
			if(cageDesign.childCageDesign.size() > 0) {
				for(int j=0;(j<=cageDesign.childCageDesign.size()-1);j++) {
					html += "<option style='color: #000000;' value="+cageDesign.childCageDesign.getAt(i).id+">&nbsp;&nbsp;"+cageDesign.childCageDesign.getAt(i)+"</option>"
				}
			}*/
			
		}
		render html
	}
}
