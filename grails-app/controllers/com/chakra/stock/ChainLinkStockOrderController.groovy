package com.chakra.stock

import org.springframework.dao.DataIntegrityViolationException

class ChainLinkStockOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [chainLinkStockOrderInstanceList: ChainLinkStockOrder.list(params), chainLinkStockOrderInstanceTotal: ChainLinkStockOrder.count()]
    }

    def create() {
        [chainLinkStockOrderInstance: new ChainLinkStockOrder(params)]
    }

    def save() {
        def chainLinkStockOrderInstance = new ChainLinkStockOrder(params)
        chainLinkStockOrderInstance.comments = params.comments+" "+"Created By "+"UNKNOWN_USER"+new Date().format("dd/MM/yy-hh:mm")+"<br>"
        if (!chainLinkStockOrderInstance.save(flush: true)) {
            render(view: "create", model: [chainLinkStockOrderInstance: chainLinkStockOrderInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), chainLinkStockOrderInstance.id])
        redirect(action: "show", id: chainLinkStockOrderInstance.id)
    }

    def show() {
        def chainLinkStockOrderInstance = ChainLinkStockOrder.get(params.id)
        if (!chainLinkStockOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        [chainLinkStockOrderInstance: chainLinkStockOrderInstance]
    }

    def edit() {
        def chainLinkStockOrderInstance = ChainLinkStockOrder.get(params.id)
        if (!chainLinkStockOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        [chainLinkStockOrderInstance: chainLinkStockOrderInstance]
    }

    def update() {
        def chainLinkStockOrderInstance = ChainLinkStockOrder.get(params.id)
        if (!chainLinkStockOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (chainLinkStockOrderInstance.version > version) {
                chainLinkStockOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder')] as Object[],
                          "Another user has updated this ChainLinkStockOrder while you were editing")
                render(view: "edit", model: [chainLinkStockOrderInstance: chainLinkStockOrderInstance])
                return
            }
        }

        chainLinkStockOrderInstance.properties = params
        chainLinkStockOrderInstance.comments = params.comments+" "+"Edited By "+"UNKNOWN_USER"+new Date().format("dd/MM/yy-hh:mm")+"<br>"

        if (!chainLinkStockOrderInstance.save(flush: true)) {
            render(view: "edit", model: [chainLinkStockOrderInstance: chainLinkStockOrderInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), chainLinkStockOrderInstance.id])
        redirect(action: "show", id: chainLinkStockOrderInstance.id)
    }

    def delete() {
        def chainLinkStockOrderInstance = ChainLinkStockOrder.get(params.id)
        if (!chainLinkStockOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        try {
            chainLinkStockOrderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
