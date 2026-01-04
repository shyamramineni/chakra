package com.chakra.stock

import org.springframework.dao.DataIntegrityViolationException

class CageStockController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cageStockInstanceList: CageStock.list(params), cageStockInstanceTotal: CageStock.count()]
    }

    def create() {
        [cageStockInstance: new CageStock(params)]
    }

    def save() {
        def cageStockInstance = new CageStock(params)
        if (!cageStockInstance.save(flush: true)) {
            render(view: "create", model: [cageStockInstance: cageStockInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'cageStock.label', default: 'CageStock'), cageStockInstance.id])
        redirect(action: "show", id: cageStockInstance.id)
    }

    def show() {
        def cageStockInstance = CageStock.get(params.id)
        if (!cageStockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageStock.label', default: 'CageStock'), params.id])
            redirect(action: "list")
            return
        }

        [cageStockInstance: cageStockInstance]
    }

    def edit() {
        def cageStockInstance = CageStock.get(params.id)
        if (!cageStockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageStock.label', default: 'CageStock'), params.id])
            redirect(action: "list")
            return
        }

        [cageStockInstance: cageStockInstance]
    }

    def update() {
        def cageStockInstance = CageStock.get(params.id)
        if (!cageStockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageStock.label', default: 'CageStock'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cageStockInstance.version > version) {
                cageStockInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cageStock.label', default: 'CageStock')] as Object[],
                          "Another user has updated this CageStock while you were editing")
                render(view: "edit", model: [cageStockInstance: cageStockInstance])
                return
            }
        }

        cageStockInstance.properties = params

        if (!cageStockInstance.save(flush: true)) {
            render(view: "edit", model: [cageStockInstance: cageStockInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'cageStock.label', default: 'CageStock'), cageStockInstance.id])
        redirect(action: "show", id: cageStockInstance.id)
    }

    def delete() {
        def cageStockInstance = CageStock.get(params.id)
        if (!cageStockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageStock.label', default: 'CageStock'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cageStockInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cageStock.label', default: 'CageStock'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cageStock.label', default: 'CageStock'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def cageStockReport() {
		
		def c1 = CageStock.createCriteria()
		def cageStockInstanceList = c1.list {
			
			eq("availabilityStatus",true)
			projections {
				
				groupProperty("cagePart")
				sum("noOfInStock")
			}
		}
		log.debug cageStockInstanceList
		[cageStockInstanceList: cageStockInstanceList, cageStockInstanceTotal: cageStockInstanceList.size()]
	}
	
}
