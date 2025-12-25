/*package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

class CagePartPriceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cagePartPriceInstanceList: CagePartPrice.list(params), cagePartPriceInstanceTotal: CagePartPrice.count()]
    }

    def create() {
        [cagePartPriceInstance: new CagePartPrice(params)]
    }

    def save() {
        def cagePartPriceInstance = new CagePartPrice(params)
        if (!cagePartPriceInstance.save(flush: true)) {
            render(view: "create", model: [cagePartPriceInstance: cagePartPriceInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), cagePartPriceInstance.id])
        redirect(action: "show", id: cagePartPriceInstance.id)
    }

    def show() {
        def cagePartPriceInstance = CagePartPrice.get(params.id)
        if (!cagePartPriceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartPriceInstance: cagePartPriceInstance]
    }

    def edit() {
        def cagePartPriceInstance = CagePartPrice.get(params.id)
        if (!cagePartPriceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartPriceInstance: cagePartPriceInstance]
    }

    def update() {
        def cagePartPriceInstance = CagePartPrice.get(params.id)
        if (!cagePartPriceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cagePartPriceInstance.version > version) {
                cagePartPriceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cagePartPrice.label', default: 'CagePartPrice')] as Object[],
                          "Another user has updated this CagePartPrice while you were editing")
                render(view: "edit", model: [cagePartPriceInstance: cagePartPriceInstance])
                return
            }
        }

        cagePartPriceInstance.properties = params

        if (!cagePartPriceInstance.save(flush: true)) {
            render(view: "edit", model: [cagePartPriceInstance: cagePartPriceInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), cagePartPriceInstance.id])
        redirect(action: "show", id: cagePartPriceInstance.id)
    }

    def delete() {
        def cagePartPriceInstance = CagePartPrice.get(params.id)
        if (!cagePartPriceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cagePartPriceInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}*/

package com.chakra.config

//import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import com.chakra.notifications.Notification
import com.chakra.security.User
import com.chakra.service.FormulaService
import com.chakra.service.NotificationService

class CagePartPriceController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def exportService
	def grailsApplication
	
	@Secured(['ROLE_ADMIN'])
	def index() {
		redirect(action: "list", params: params)
	}

	@Secured(['ROLE_ADMIN'])
	def list() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[cagePartPriceInstanceList: CagePartPrice.list(params), cagePartPriceInstanceTotal: CagePartPrice.count()]
	}

	@Secured(['ROLE_ADMIN'])
	def create() {
		[cagePartPriceInstance: new CagePartPrice(params)]
	}

	@Secured(['ROLE_ADMIN'])
	def save() {
		/*def cagePartPriceInstance = new CagePartPrice(params)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
		if(cagePartPriceInstance.price != null) {
			println'cagePartPriceInstance '+cagePartPriceInstance
			flash.message = "CagePartPrice already declared"
			render(view: "edit", model: [cagePartPriceInstance: cagePartPriceInstance])
			return
			
			//redirect(action: "show", id: cagePartPriceInstance.id)
		}
		if (!cagePartPriceInstance.save(flush: true)) {
			render(view: "create", model: [cagePartPriceInstance: cagePartPriceInstance])
			return
		}*/
		
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
		def cagePartInstance  = CagePart.get(params.cagePart.id)
		def cagePartPriceInstance = CagePartPrice.findByCagePart(cagePartInstance)
		if(cagePartPriceInstance?.price != null) {
			println'cagePartPriceInstance '+cagePartPriceInstance
			flash.message = "CagePartPrice already declared"
			render(view: "edit", model: [cagePartPriceInstance: cagePartPriceInstance])
			return
		}
		cagePartPriceInstance = new CagePartPrice(params)
		if (!cagePartPriceInstance.save(flush: true)) {
			render(view: "create", model: [cagePartPriceInstance: cagePartPriceInstance])
			return
		}
		
		def cagePart = cagePartPriceInstance.cagePart
		println'cagePart '+cagePart
		//println'cagePartPrice '+cagePart.price
		def childCagePartList = CagePart.findByParentCagePart(cagePart)
		println'childCagePartList '+childCagePartList
		childCagePartList.each { childCagePart ->
			println'childCagePart '+childCagePart
			println'formula '+childCagePart.formula
			println'price '+cagePartPriceInstance.price
			
			FormulaService formulaService = new FormulaService()
			def variables = ["parentCagePart": cagePartPriceInstance.price]
			def price = formulaService.evalFormula(variables, childCagePart.formula)
			println'price'+price
			
			//cagePartPriceInstance.price = price
			
			CagePartPrice cagePartPrice = CagePartPrice.findByCagePart(childCagePart)
			println'cagePartPrice '+cagePartPrice
			cagePartPrice.cagePart = childCagePart
			cagePartPrice.price = price
			cagePartPrice.startDate = cagePartPriceInstance.startDate
			cagePartPrice.endDate = cagePartPriceInstance.endDate
			
			if (!cagePartPrice.save(flush: true)) {
				cagePartPrice.errors.each {
					println it
				}
			}
			
		}

		notificationService.addNotification(users.username, Notification.NOTIFMSG_NEW_CAGEPART_PRICE, true, ""+g.link(action:"list", controller:"cagePartPrice", id: cagePartPriceInstance.id) { cagePartPriceInstance.cagePartId }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.created.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), cagePartPriceInstance.id])
		redirect(action: "show", id: cagePartPriceInstance.id)
	}

	@Secured(['ROLE_ADMIN'])
	def show() {
		def cagePartPriceInstance = CagePartPrice.get(params.id)
		if (!cagePartPriceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
			redirect(action: "list")
			return
		}

		[cagePartPriceInstance: cagePartPriceInstance]
	}

	@Secured(['ROLE_ADMIN'])
	def edit() {
		def cagePartPriceInstance = CagePartPrice.get(params.id)
		if (!cagePartPriceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
			redirect(action: "list")
			return
		}

		[cagePartPriceInstance: cagePartPriceInstance]
	}

	@Secured(['ROLE_ADMIN'])
	def update() {
		def cagePartPriceInstance = CagePartPrice.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
		if (!cagePartPriceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (cagePartPriceInstance.version > version) {
				cagePartPriceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'cagePartPrice.label', default: 'CagePartPrice')] as Object[],
						  "Another user has updated this CagePartPrice while you were editing")
				render(view: "edit", model: [cagePartPriceInstance: cagePartPriceInstance])
				return
			}
		}

		cagePartPriceInstance.properties = params

		if (!cagePartPriceInstance.save(flush: true)) {
			render(view: "edit", model: [cagePartPriceInstance: cagePartPriceInstance])
			return
		}
		
		def cagePart = cagePartPriceInstance.cagePart
		println'cagePart '+cagePart
		
		def childCagePartList = CagePart.findAllByParentCagePart(cagePart)
		println'childCagePartList '+childCagePartList
		childCagePartList.each { childCagePart ->
			println'childCagePart '+childCagePart
			println'formula '+childCagePart.formula
			println'price '+cagePartPriceInstance.price
						
			FormulaService formulaService = new FormulaService()
			def variables = ["parentCagePart": cagePartPriceInstance.price]
			def price = formulaService.evalFormula(variables, childCagePart.formula)
			println'price'+price
			
			CagePartPrice cagePartPrice = CagePartPrice.findByCagePart(childCagePart)
			println'cagePartPrice '+cagePartPrice
			cagePartPrice.cagePart = childCagePart
			cagePartPrice.price = price
			cagePartPrice.startDate = cagePartPriceInstance.startDate
			cagePartPrice.endDate = cagePartPriceInstance.endDate
			
			if (!cagePartPrice.save(flush: true)) {
				cagePartPrice.errors.each {
					println it
				}
			}
			
		}
		

		notificationService.addNotification(users.username, Notification.NOTIFMSG_UPDATE_CAGEPART_PRICE, true, ""+g.link(action:"list", controller:"cagePartPrice", id: cagePartPriceInstance.id) { cagePartPriceInstance.id }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), cagePartPriceInstance.id])
		redirect(action: "show", id: cagePartPriceInstance.id)
	}

	@Secured(['ROLE_ADMIN'])
	def delete() {
		def cagePartPriceInstance = CagePartPrice.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		println'user '+ users.username
		if (!cagePartPriceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
			redirect(action: "list")
			return
		}

		try {
			cagePartPriceInstance.delete(flush: true)
			notificationService.addNotification(users.username, Notification.NOTIFMSG_DELETE_CAGEPART_PRICE, true, ""+g.link(action:"list", controller:"cagePartPrice", id: cagePartPriceInstance.id) { cagePartPriceInstance.id }, Notification.NOTIFTYPE_APP)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cagePartPrice.label', default: 'CagePartPrice'), params.id])
			redirect(action: "show", id: params.id)
		}
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def cagePriceReport() {
		
	}
	
	/*def cagePartsPdf() {
		
		def cagePartPriceInstance = CagePartPrice.get(params.id)
						
		def image = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/grails_logo.jpg"))
		
		renderPdf(template: "cageParts", model: [cagePartPriceInstance: cagePartPriceInstance, imageBytes: image.bytes], filename: "CageParts.pdf")
	}*/
	
	def exportCagePartPrice() {
		
		params.max = Math.min(params.max ? params.int('max') : 50, 100)
		
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=CagePartPrice.${params.extension}")
			
			List fields = ["cagePartId", "cagePartSpecFormula", "price"]
			Map labels = ["cagePartId": "CagePart Id", "cagePartSpecFormula": "CagePartSpec Formula", "price": "Price" ]

			exportService.export(params.format, response.outputStream,CagePartPrice.list(params),fields, labels, [:], [:])
		}
		
		[cagePartPriceInstanceList: CagePartPrice.list(params), cagePartPriceInstanceTotal: CagePartPrice.count()]
	}
	
}

