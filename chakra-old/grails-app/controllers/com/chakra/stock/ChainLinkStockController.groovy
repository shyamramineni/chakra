package com.chakra.stock

import org.springframework.dao.DataIntegrityViolationException

class ChainLinkStockController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [chainLinkStockInstanceList: ChainLinkStock.list(params), chainLinkStockInstanceTotal: ChainLinkStock.count()]
    }

    def create() {
        [chainLinkStockInstance: new ChainLinkStock(params)]
    }

    def save() {
        def chainLinkStockInstance = new ChainLinkStock(params)
        if (!chainLinkStockInstance.save(flush: true)) {
            render(view: "create", model: [chainLinkStockInstance: chainLinkStockInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'chainLinkStock.label', default: 'ChainLinkStock'), chainLinkStockInstance.id])
        redirect(action: "show", id: chainLinkStockInstance.id)
    }

    def show() {
        def chainLinkStockInstance = ChainLinkStock.get(params.id)
        if (!chainLinkStockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkStock.label', default: 'ChainLinkStock'), params.id])
            redirect(action: "list")
            return
        }

        [chainLinkStockInstance: chainLinkStockInstance]
    }

    def edit() {
        def chainLinkStockInstance = ChainLinkStock.get(params.id)
        if (!chainLinkStockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkStock.label', default: 'ChainLinkStock'), params.id])
            redirect(action: "list")
            return
        }

        [chainLinkStockInstance: chainLinkStockInstance]
    }

    def update() {
        def chainLinkStockInstance = ChainLinkStock.get(params.id)
        if (!chainLinkStockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkStock.label', default: 'ChainLinkStock'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (chainLinkStockInstance.version > version) {
                chainLinkStockInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'chainLinkStock.label', default: 'ChainLinkStock')] as Object[],
                          "Another user has updated this ChainLinkStock while you were editing")
                render(view: "edit", model: [chainLinkStockInstance: chainLinkStockInstance])
                return
            }
        }

        chainLinkStockInstance.properties = params

        if (!chainLinkStockInstance.save(flush: true)) {
            render(view: "edit", model: [chainLinkStockInstance: chainLinkStockInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'chainLinkStock.label', default: 'ChainLinkStock'), chainLinkStockInstance.id])
        redirect(action: "show", id: chainLinkStockInstance.id)
    }

    def delete() {
        def chainLinkStockInstance = ChainLinkStock.get(params.id)
        if (!chainLinkStockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkStock.label', default: 'ChainLinkStock'), params.id])
            redirect(action: "list")
            return
        }

        try {
            chainLinkStockInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'chainLinkStock.label', default: 'ChainLinkStock'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'chainLinkStock.label', default: 'ChainLinkStock'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def chainLinkStockReport() {
		
		def c1 = ChainLinkStock.createCriteria()
		def chainLinkStockInstanceList = c1.list {
			
			eq("availabilityStatus",true)
			projections {
				
				groupProperty("linkMesh")
				groupProperty("wireBrand")
				sum("noOfInStock")
			}
		}
		log.debug chainLinkStockInstanceList
		[chainLinkStockInstanceList: chainLinkStockInstanceList, chainLinkStockInstanceTotal: chainLinkStockInstanceList.size()]
	}
}
