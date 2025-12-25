package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

import com.chakra.notifications.Notification
import com.chakra.security.User
import com.chakra.service.NotificationService

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

//@Secured(['ROLE_ADMIN'])
class CageDesignController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cageDesignInstanceList: CageDesign.list(params), cageDesignInstanceTotal: CageDesign.count()]
    }

    def create() {
        [cageDesignInstance: new CageDesign(params)]
    }

    def save() {
        def cageDesignInstance = new CageDesign(params)
		cageDesignInstance.isCustom = false
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
		if (!cageDesignInstance.save(flush: true)) {
            render(view: "create", model: [cageDesignInstance: cageDesignInstance])
            return
        }
		notificationService.addNotification(users.username, Notification.NOTIFMSG_NEW_CAGEDESIGN, true, ""+g.link(action:"show", controller:"cageDesign", id: cageDesignInstance.id) { cageDesignInstance.cageDesign }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.created.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), cageDesignInstance.id])
        redirect(action: "show", id: cageDesignInstance.id)
    }

    def show() {
        def cageDesignInstance = CageDesign.get(params.id)
        if (!cageDesignInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), params.id])
            redirect(action: "list")
            return
        }

        [cageDesignInstance: cageDesignInstance]
    }

    def edit() {
        def cageDesignInstance = CageDesign.get(params.id)
        if (!cageDesignInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), params.id])
            redirect(action: "list")
            return
        }

        [cageDesignInstance: cageDesignInstance]
    }

    def update() {
        def cageDesignInstance = CageDesign.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cageDesignInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cageDesignInstance.version > version) {
                cageDesignInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cageDesign.label', default: 'CageDesign')] as Object[],
                          "Another user has updated this CageDesign while you were editing")
                render(view: "edit", model: [cageDesignInstance: cageDesignInstance])
                return
            }
        }

        cageDesignInstance.properties = params

        if (!cageDesignInstance.save(flush: true)) {
            render(view: "edit", model: [cageDesignInstance: cageDesignInstance])
            return
        }
		notificationService.addNotification(users.username, Notification.NOTIFMSG_UPDATE_CAGEDESIGN, true, ""+g.link(action:"show", controller:"cageDesign", id: cageDesignInstance.id) { cageDesignInstance.cageDesign }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.updated.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), cageDesignInstance.id])
        redirect(action: "show", id: cageDesignInstance.id)
    }

    def delete() {
		println'params '+params
        def cageDesignInstance = CageDesign.get(params.id)
		println'customCageDesign '+cageDesignInstance.isCustom
		
		if(cageDesignInstance.isCustom){
			println'in if'
			cageDesignInstance.removeFromChildCageDesign(cageDesignInstance)
			//cageDesignInstance.delete(flush: true)
			/*try {
				cageDesignInstance.delete(flush: true)
				//notificationService.addNotification(users.username, Notification.NOTIFMSG_DELETE_CAGEDESIGN, true, ""+g.link(action:"list", controller:"cageDesign", id: cageDesignInstance.id) { cageDesignInstance.id }, Notification.NOTIFTYPE_APP)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), params.id])
				redirect(action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), params.id])
				redirect(action: "show", id: params.id)
			}*/
		}
		
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!cageDesignInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cageDesignInstance.delete(flush: true)
			notificationService.addNotification(users.username, Notification.NOTIFMSG_DELETE_CAGEDESIGN, true, ""+g.link(action:"list", controller:"cageDesign", id: cageDesignInstance.id) { cageDesignInstance.id }, Notification.NOTIFTYPE_APP)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	/*def sheetSpecifications() {
		
		log.debug 'sheetSpecification()'
		def cageDesignInstance = CageDesign.get(params.id)
		if(cageDesignInstance) {
			render g:select(id: "sheetSpecification", name:"sheetSpecification.id", from:cageDesignInstance.cageDesignSheetSpecFormula.sheetSpecification, noSelection:['':'Select One...'], optionKey: "id")
		} 
		render g:select(id: "sheetSpecification", name:"sheetSpecification.id",  from:[''])
			
					
	}*/
	
	def ajaxGetCageDesign() {
		
		def designType = params.id
		println'designType '+designType
		def cageDesignList = CageDesign.findAllByDesignTypeAndIsCustom(designType,false)
		println'cageDesignList '+cageDesignList
		
		//render g:select(name:"cageDesign.id", from:cageDesignList, noSelection:['':'Select One...'], optionKey: "id")
					
		// foreach cageDesing in cageDesignlist
		//print <option> with cage designid
		//if cageDesign.childDesignList is not null
		// for cageDesignList in childDesignList print another option with tabbed value
		
		
		/*String html
		html = "<select name=cageDesign.id id=cageDesign.id"
		for(int i=0;(i<=cageDesignList.size()-1);i++){
				println"<option>"+cageDesignList.getAt(i)+"</option>"
				html += "<option value="+cageDesignList.getAt(i).id+">"+cageDesignList.getAt(i)+"</option>"
			println'child'+cageDesignList.childCageDesign
			if(cageDesignList.childCageDesign != null) {
				cageDesignList.childCageDesign.each { childCageDesign ->
					//println"<option>&nbsp;"+childCageDesign[0]+"</option>"
					html += "<option value="+cageDesignList.getAt(i).id+">&nbsp;&nbsp;"+childCageDesign[0]+"</option>" 
					println'html1 '+html
				}
				//println"<option>&nbsp;"+cageDesignList.childCageDesign.getAt(i)+"</option>"
				//html = "<option>&nbsp;"+cageDesignList..childCageDesign.getAt(i)+"</option>"
			}
		}
		html += "</select>"
		println'html '+html
		render html*/
		
		String html
		html = "<select name=cageDesign.id id=cageDesign.id>"
		for(int i=0;(i<=cageDesignList.size()-1);i++){
			println"<option>"+cageDesignList.getAt(i)+"</option>"
			html += "<option value="+cageDesignList.getAt(i).id+">"+cageDesignList.getAt(i)+"</option>"
			def cageDesign = cageDesignList.getAt(i)
			println'childCageDesign.size() '+cageDesign.childCageDesign.size()
			println'childCageDesign '+cageDesign.childCageDesign.getAt(i)
			if(cageDesign.childCageDesign.size() > 0) {
				for(int j=0;(j<=cageDesign.childCageDesign.size()-1);j++) {
					html += "<option style='color: #000000;' value="+cageDesign.childCageDesign.getAt(i).id+">&nbsp;&nbsp;"+cageDesign.childCageDesign.getAt(i)+"</option>"
				}
			}		
			
		}		
		render html	
		
	}
	
	def customCageDesign() {
		
		def cageDesignInstance = CageDesign.get(params.cageDesign)
		log.debug'cageDesignInstance '+cageDesignInstance
		
		[cageDesignInstance: cageDesignInstance]
		
	}
	
	def createCustomCageDesign() {
		
		log.debug'params'+params
		def cageDesignInstance = CageDesign.get(params.cageDesign)
		log.debug'cageDesignInstance '+cageDesignInstance
		//cageDesignInstance.properties = params
		CageDesign childCageDesign = new CageDesign()
		
		childCageDesign.cageDesign = params.cageDesignName
		childCageDesign.sheetLength = params.sheetLength.toBigDecimal()
		childCageDesign.noOfBirdsPerCageSingleBox = params.noOfBirdsPerCageSingleBox.toBigDecimal()
		childCageDesign.noOfBirdsPerCageDoubleBox = params.noOfBirdsPerCageDoubleBox.toBigDecimal()
		childCageDesign.noOfPartitionsPerSheetLength = params.noOfPartitionsPerSheetLength.toBigDecimal()
		childCageDesign.noOfSingleBottomsPerSheet = params.noOfSingleBottomsPerSheet.toBigDecimal()
		childCageDesign.bottomDepth = params.bottomDepth.toBigDecimal()
		childCageDesign.topDepth = params.topDepth.toBigDecimal()
		childCageDesign.cageHeight = params.cageHeight.toBigDecimal()
		childCageDesign.cageFront = params.cageFront.toBigDecimal()
		childCageDesign.description = params.description
		childCageDesign.designType = params.designType
		childCageDesign.isCustom = params.isCustom
		childCageDesign.doubleBottomCentreIncluded = params.doubleBottomCentreIncluded
		
		cageDesignInstance.addToChildCageDesign(childCageDesign)
		
		if (!cageDesignInstance.save(flush: true)) {
			render(view: "customCageDesign", model: [cageDesignInstance: cageDesignInstance])
			return
		}
		flash.message = message(code: 'default.created.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), cageDesignInstance.id])
		redirect(action: "show", id: cageDesignInstance.id)
		
	}
	
	def getSheetSpecifications() {
		println 'sheetSpecification()'
		println'params '+params
		println'JsonResopnse '+params.id//.requestData[0].id
		println' '+params.requestType
		//def test = JSON.parse(params.reqdata.toString())
		//println'test '+test.requestData[0]
		def cageDesignInstance = CageDesign.get(params.id)
		println'cageDesignInstance '+cageDesignInstance
		def sheeSpecificationList = CageDesignSheetSpecFormula.findAllByCageDesign(cageDesignInstance)
		println'sheeSpecificationList '+sheeSpecificationList
		//def responseData = new Object()
		
		List meshItems = new ArrayList()
		//def sheetSpecMap = [:]
		
		sheeSpecificationList.each { sheetSpec ->
			//sheetSpecMap['id'] = sheetSpec.sheetSpecification.id
			//sheetSpecMap.put("id", sheetSpec.sheetSpecification.id)
			//meshItems.put("sheetName", sheetSpec.sheetSpecification.sheetName)
			//meshItems.put("sheetSpecId", sheetSpec.sheetSpecification.sheetSpecId)
			//meshItems.put("desc", sheetSpec.sheetSpecification.description)
			//meshItems.add("id",sheetSpec.sheetSpecification.id)
			//meshItems.add("sheetName",sheetSpec.sheetSpecification.sheetName)
			//meshItems.add("sheetSpecId",sheetSpec.sheetSpecification.sheetSpecId)
			//meshItems.add("desc",sheetSpec.sheetSpecification.description)
			meshItems.add( 
				"id":sheetSpec.sheetSpecification.id , "name":sheetSpec.sheetSpecification.toString(), "itemId": sheetSpec.sheetSpecification.sheetSpecId, "desc":sheetSpec.sheetSpecification.description)
			
		}
		println'meshItems '+meshItems
		
		def responseData = [meshItems: meshItems]
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': meshItems ? "OK" : "NODATA"
    
		]}
		
		return
			
	}
	
	def cageDesignType() {
		println'params '+params
		def designTypeData = JSON.parse(params.requestData)
		println'designTypeData '+designTypeData
		def designType = designTypeData.id
		def cageDesignList = CageDesign.findAllByDesignTypeAndIsCustom(designType,false)
		println'cageDesignList '+cageDesignList
		
		String html
		html = "<select name=cageDesign.id id=cageDesign.id>"
		html += '<option value="">Select</option>'
		for(int i=0;(i<=cageDesignList.size()-1);i++){
			println"<option>"+cageDesignList.getAt(i)+"</option>"
			html += "<option value="+cageDesignList.getAt(i).id+">"+cageDesignList.getAt(i)+"</option>"
			def cageDesign = cageDesignList.getAt(i)
			println'childCageDesign.size() '+cageDesign.childCageDesign.size()
			println'childCageDesign '+cageDesign.childCageDesign.getAt(i)
			if(cageDesign.childCageDesign.size() > 0) {
				for(int j=0;(j<=cageDesign.childCageDesign.size()-1);j++) {
					html += "<option style='color: #000000;' value="+cageDesign.childCageDesign.getAt(i).id+">&nbsp;&nbsp;"+cageDesign.childCageDesign.getAt(i)+"</option>"
				}
			}
			
		}
		render html
	}
		
}
