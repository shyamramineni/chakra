package com.chakra.stock

import org.springframework.dao.DataIntegrityViolationException

class StockController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [stockInstanceList: Stock.list(params), stockInstanceTotal: Stock.count()]
    }

    def create() {
        [stockInstance: new Stock(params)]
    }

    def save() {
        def stockInstance = new Stock(params)
		stockInstance.comments = params.comments+" "+"Created By "+"DummyUser"+new Date().format("dd/MM/yy-hh:mm")+"<br>"
		
        if (!stockInstance.save(flush: true)) {
            render(view: "create", model: [stockInstance: stockInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'stock.label', default: 'Stock'), stockInstance.id])
        redirect(action: "show", id: stockInstance.id)
    }

    def show() {
        def stockInstance = Stock.get(params.id)
        if (!stockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])
            redirect(action: "list")
            return
        }

        [stockInstance: stockInstance]
    }

    def edit() {
        def stockInstance = Stock.get(params.id)
        if (!stockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])
            redirect(action: "list")
            return
        }

        [stockInstance: stockInstance]
    }

    def update() {
        def stockInstance = Stock.get(params.id)
        if (!stockInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (stockInstance.version > version) {
                stockInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'stock.label', default: 'Stock')] as Object[],
                          "Another user has updated this Stock while you were editing")
                render(view: "edit", model: [stockInstance: stockInstance])
                return
            }
        }

        stockInstance.properties = params
		stockInstance.comments = params.comments+" "+"Edited By "+"DummyUser"+new Date().format("dd/MM/yy-hh:mm")+"<br>"

        if (!stockInstance.save(flush: true)) {
            render(view: "edit", model: [stockInstance: stockInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'stock.label', default: 'Stock'), stockInstance.id])
        redirect(action: "show", id: stockInstance.id)
    }

    def delete() {
        def stockInstance = Stock.get(params.id)
        if (!stockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])
            redirect(action: "list")
            return
        }

        try {
            stockInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def search() {

	}

	def searchResults() {

		def s = Stock.createCriteria()
		def stockInstanceList = s {

			//eq("stockManufacturedTime",params.stockManufacturedTime)
			le("createdDate",params.createdDate)
			ge("lastEditedDate",params.lastEditedDate)

			//order("startDate", "desc")
		}

		log.debug "Final stockInstanceList.size() "+stockInstanceList.size()

		[stockInstanceList: stockInstanceList, stockInstanceTotal: stockInstanceList.size()]

	}
	
	def stockReport() {
		
		def c1 = Stock.createCriteria()
		def stockInstanceList = c1.list {
			
			eq("availabilityStatus",true)
			projections {
				/*property("sheetSpecification")
				property("wireBrand")
				property("noOfMeshParts")*/
				
				groupProperty("sheetSpec")
				groupProperty("wireBrand")
				sum("noOfInStock")
			}
		}
		log.debug stockInstanceList
		[stockInstanceList: stockInstanceList, stockInstanceTotal: stockInstanceList.size()]
	}
}
