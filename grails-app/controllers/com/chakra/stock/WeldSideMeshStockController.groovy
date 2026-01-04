package com.chakra.stock

import org.springframework.dao.DataIntegrityViolationException

class WeldSideMeshStockController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [weldSideMeshStockInstanceList: WeldSideMeshStock.list(params), weldSideMeshStockInstanceTotal: WeldSideMeshStock.count()]
    }

    def create() {
        [weldSideMeshStockInstance: new WeldSideMeshStock(params)]
    }

    def save() {
        def weldSideMeshStockInstance = new WeldSideMeshStock(params)
        if (!weldSideMeshStockInstance.save(flush: true)) {
            render(view: "create", model: [weldSideMeshStockInstance: weldSideMeshStockInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock'), weldSideMeshStockInstance.id])
        redirect(action: "show", id: weldSideMeshStockInstance.id)
    }

    def show() {
        def weldSideMeshStockInstance = WeldSideMeshStock.get(params.id)
        if (!weldSideMeshStockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock'), params.id])
            redirect(action: "list")
            return
        }

        [weldSideMeshStockInstance: weldSideMeshStockInstance]
    }

    def edit() {
        def weldSideMeshStockInstance = WeldSideMeshStock.get(params.id)
        if (!weldSideMeshStockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock'), params.id])
            redirect(action: "list")
            return
        }

        [weldSideMeshStockInstance: weldSideMeshStockInstance]
    }

    def update() {
        def weldSideMeshStockInstance = WeldSideMeshStock.get(params.id)
        if (!weldSideMeshStockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (weldSideMeshStockInstance.version > version) {
                weldSideMeshStockInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock')] as Object[],
                          "Another user has updated this WeldSideMeshStock while you were editing")
                render(view: "edit", model: [weldSideMeshStockInstance: weldSideMeshStockInstance])
                return
            }
        }

        weldSideMeshStockInstance.properties = params

        if (!weldSideMeshStockInstance.save(flush: true)) {
            render(view: "edit", model: [weldSideMeshStockInstance: weldSideMeshStockInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock'), weldSideMeshStockInstance.id])
        redirect(action: "show", id: weldSideMeshStockInstance.id)
    }

    def delete() {
        def weldSideMeshStockInstance = WeldSideMeshStock.get(params.id)
        if (!weldSideMeshStockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock'), params.id])
            redirect(action: "list")
            return
        }

        try {
            weldSideMeshStockInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'weldSideMeshStock.label', default: 'WeldSideMeshStock'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def weldSideMeshStockReport() {
		
		def c1 = WeldSideMeshStock.createCriteria()
		def weldSideMeshStockInstanceList = c1.list {
			
			eq("availabilityStatus",true)
			projections {
				
				groupProperty("sideMesh")
				groupProperty("wireBrand")
				sum("noOfInStock")
			}
		}
		log.debug weldSideMeshStockInstanceList
		[weldSideMeshStockInstanceList: weldSideMeshStockInstanceList, weldSideMeshStockInstanceTotal: weldSideMeshStockInstanceList.size()]
	}
}
