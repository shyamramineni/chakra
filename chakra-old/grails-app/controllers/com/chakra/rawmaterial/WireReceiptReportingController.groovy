package com.chakra.rawmaterial

import org.springframework.dao.DataIntegrityViolationException

import grails.plugins.springsecurity.Secured



@Secured(['ROLE_ADMIN', 'ROLE_PRODMANAGER'])
class WireReceiptReportingController {
	
	def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [wireReceiptReportingInstanceList: WireReceiptReporting.list(params), wireReceiptReportingInstanceTotal: WireReceiptReporting.count()]
    }

    def create() {
        [wireReceiptReportingInstance: new WireReceiptReporting(params)]
    }

    def save() {
        def wireReceiptReportingInstance = new WireReceiptReporting(params)
		
		wireReceiptReportingInstance.comments = params.comments+" "+"Created By "+springSecurityService.currentUser.toString()+new Date().format("dd/MM/yy-hh:mm")+"<br>"
        if (!wireReceiptReportingInstance.save(flush: true)) {
            render(view: "create", model: [wireReceiptReportingInstance: wireReceiptReportingInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting'), wireReceiptReportingInstance.id])
        redirect(action: "show", id: wireReceiptReportingInstance.id)
    }

    def show() {
        def wireReceiptReportingInstance = WireReceiptReporting.get(params.id)
        if (!wireReceiptReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting'), params.id])
            redirect(action: "list")
            return
        }

        [wireReceiptReportingInstance: wireReceiptReportingInstance]
    }

    def edit() {
        def wireReceiptReportingInstance = WireReceiptReporting.get(params.id)
        if (!wireReceiptReportingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting'), params.id])
            redirect(action: "list")
            return
        }

        [wireReceiptReportingInstance: wireReceiptReportingInstance]
    }

    def update() {
        def wireReceiptReportingInstance = WireReceiptReporting.get(params.id)
        if (!wireReceiptReportingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (wireReceiptReportingInstance.version > version) {
                wireReceiptReportingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting')] as Object[],
                          "Another user has updated this WireReceiptReporting while you were editing")
                render(view: "edit", model: [wireReceiptReportingInstance: wireReceiptReportingInstance])
                return
            }
        }

        wireReceiptReportingInstance.properties = params
		wireReceiptReportingInstance.comments = params.comments+" "+"Edited By "+springSecurityService.currentUser.toString()+new Date().format("dd/MM/yy-hh:mm")+"<br>"
		
        if (!wireReceiptReportingInstance.save(flush: true)) {
            render(view: "edit", model: [wireReceiptReportingInstance: wireReceiptReportingInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting'), wireReceiptReportingInstance.id])
        redirect(action: "show", id: wireReceiptReportingInstance.id)
    }

    def delete() {
        def wireReceiptReportingInstance = WireReceiptReporting.get(params.id)
        if (!wireReceiptReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting'), params.id])
            redirect(action: "list")
            return
        }

        try {
            wireReceiptReportingInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'wireReceiptReporting.label', default: 'WireReceiptReporting'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def wireReceiptReportingReport() {
		
		def c1 = WireReceiptReporting.createCriteria()
		def wireReceiptReportingInstanceList = c1.list {
			
			eq("availabilityStatus",true)
			projections {
				/*property("sheetSpecification")
				property("wireBrand")
				property("noOfMeshParts")*/
				
				groupProperty("wireBrand")
				groupProperty("wireDiameter")
				sum("weightInStock")
			}
		}
		log.debug wireReceiptReportingInstanceList
		[wireReceiptReportingInstanceList: wireReceiptReportingInstanceList, wireReceiptReportingInstanceTotal: wireReceiptReportingInstanceList.size()]
	}
	
	
}
