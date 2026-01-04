package com.chakra.production

import org.springframework.dao.DataIntegrityViolationException

import com.chakra.notifications.Notification
import com.chakra.security.DummyUser
import com.chakra.service.NotificationService
import com.chakra.stock.CageStock

class CagePartReportingController {
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cagePartReportingInstanceList: CagePartReporting.list(params), cagePartReportingInstanceTotal: CagePartReporting.count()]
    }

    def create() {
        [cagePartReportingInstance: new CagePartReporting(params)]
    }

    def save() {
        def cagePartReportingInstance = new CagePartReporting(params)
        if (!cagePartReportingInstance.save(flush: true)) {
            render(view: "create", model: [cagePartReportingInstance: cagePartReportingInstance])
            return
        }
		
		def cageStockInstance = new CageStock()
		
		cageStockInstance.cagePart = cagePartReportingInstance.cagePart
		cageStockInstance.noOfPurchased = cagePartReportingInstance.totalQuantity
		
		cageStockInstance.noOfInStock = cagePartReportingInstance.totalQuantity
		cageStockInstance.availabilityStatus = true
		cageStockInstance.cageStockId = 'CS'+cagePartReportingInstance.stockPurchasedTime.format("ddMMyyhhmmss")
		
		cageStockInstance.purchasedTime = cagePartReportingInstance.stockPurchasedTime
		log.debug "Saved stock"
		
		log.debug "Saving New stock"
		cagePartReportingInstance.comments = params.comments+" "+"Created By "+ "dummy" +new Date().format("dd/MM/yy-hh:mm")+"<br>"
		
		if (!cageStockInstance.save(flush: true)) {
			cageStockInstance.errors.each {
				log.error it
			}
			render(view: "create", model: [cagePartReportingInstance: cagePartReportingInstance])
			return
		}
		
		log.debug "Saved New stock"
		
		if (!cagePartReportingInstance.save(flush: true)) {
			cagePartReportingInstance.errors.each {
				log.error it
			}
			
		}
		cagePartReportingInstance.cageStock = cageStockInstance
		
		NotificationService notificationService = new NotificationService()
		def users = new DummyUser(username: 'admin')
		log.debug users.username
		notificationService.addNotification(users.username, Notification.NOTIFMSG_NEW_CAGEPART_REPORTING, true, ""+g.link(action:"show", controller:"cagePartReporting", id: cagePartReportingInstance.id) { cagePartReportingInstance.cagePart }, Notification.NOTIFTYPE_APP)

		flash.message = message(code: 'default.created.message', args: [message(code: 'cagePartReporting.label', default: 'CagePartReporting'), cagePartReportingInstance.id])
        redirect(action: "show", id: cagePartReportingInstance.id)
    }

    def show() {
        def cagePartReportingInstance = CagePartReporting.get(params.id)
        if (!cagePartReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartReporting.label', default: 'CagePartReporting'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartReportingInstance: cagePartReportingInstance]
    }

    def edit() {
        def cagePartReportingInstance = CagePartReporting.get(params.id)
        if (!cagePartReportingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartReporting.label', default: 'CagePartReporting'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartReportingInstance: cagePartReportingInstance]
    }

    def update() {
        def cagePartReportingInstance = CagePartReporting.get(params.id)
        if (!cagePartReportingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartReporting.label', default: 'CagePartReporting'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cagePartReportingInstance.version > version) {
                cagePartReportingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cagePartReporting.label', default: 'CagePartReporting')] as Object[],
                          "Another user has updated this CagePartReporting while you were editing")
                render(view: "edit", model: [cagePartReportingInstance: cagePartReportingInstance])
                return
            }
        }

        cagePartReportingInstance.properties = params
		
		def cageStockInstance = cagePartReportingInstance.cageStock
		
		cageStockInstance.cagePart = cagePartReportingInstance.cagePart
		cageStockInstance.noOfInStock = cagePartReportingInstance.totalQuantity
		cageStockInstance.purchasedTime = cagePartReportingInstance.stockPurchasedTime
		cageStockInstance.noOfPurchased = cagePartReportingInstance.totalQuantity
		cageStockInstance.cageStockId = 'CS'+cagePartReportingInstance.stockPurchasedTime.format("ddMMyyhhmmss")
		cageStockInstance.availabilityStatus = true
		
		if (!cageStockInstance.save(flush: true)) {
			cageStockInstance.errors.each {
				log.error it
			}
			render(view: "create", model: [cagePartReportingInstance: cagePartReportingInstance])
			return
		}

        if (!cagePartReportingInstance.save(flush: true)) {
            render(view: "edit", model: [cagePartReportingInstance: cagePartReportingInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePartReporting.label', default: 'CagePartReporting'), cagePartReportingInstance.id])
        redirect(action: "show", id: cagePartReportingInstance.id)
    }

    def delete() {
        def cagePartReportingInstance = CagePartReporting.get(params.id)
        if (!cagePartReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartReporting.label', default: 'CagePartReporting'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cagePartReportingInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePartReporting.label', default: 'CagePartReporting'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cagePartReporting.label', default: 'CagePartReporting'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
