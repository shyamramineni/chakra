package com.chakra.stock

import org.springframework.dao.DataIntegrityViolationException

class StockOrderController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [stockOrderInstanceList: StockOrder.list(params), stockOrderInstanceTotal: StockOrder.count()]
    }

    def create() {
        [stockOrderInstance: new StockOrder(params)]
    }

    def save() {
        def stockOrderInstance = new StockOrder(params)
		stockOrderInstance.comments = params.comments+" "+"Created By "+"DummyUser"+new Date().format("dd/MM/yy-hh:mm")+"<br>"
        if (!stockOrderInstance.save(flush: true)) {
            render(view: "create", model: [stockOrderInstance: stockOrderInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), stockOrderInstance.id])
        redirect(action: "show", id: stockOrderInstance.id)
    }

    def show() {
        def stockOrderInstance = StockOrder.get(params.id)
        if (!stockOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), params.id])
            redirect(action: "list")
            return
        }

        [stockOrderInstance: stockOrderInstance]
    }

    def edit() {
        def stockOrderInstance = StockOrder.get(params.id)
        if (!stockOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), params.id])
            redirect(action: "list")
            return
        }

        [stockOrderInstance: stockOrderInstance]
    }

    def update() {
        def stockOrderInstance = StockOrder.get(params.id)
        if (!stockOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (stockOrderInstance.version > version) {
                stockOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'stockOrder.label', default: 'StockOrder')] as Object[],
                          "Another user has updated this StockOrder while you were editing")
                render(view: "edit", model: [stockOrderInstance: stockOrderInstance])
                return
            }
        }

        stockOrderInstance.properties = params
		stockOrderInstance.comments = params.comments+" "+"Edited By "+"DummyUser"+new Date().format("dd/MM/yy-hh:mm")+"<br>"

        if (!stockOrderInstance.save(flush: true)) {
            render(view: "edit", model: [stockOrderInstance: stockOrderInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), stockOrderInstance.id])
        redirect(action: "show", id: stockOrderInstance.id)
    }

    def delete() {
        def stockOrderInstance = StockOrder.get(params.id)
        if (!stockOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), params.id])
            redirect(action: "list")
            return
        }

        try {
            stockOrderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
