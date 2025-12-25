package com.chakra.stock

import org.springframework.dao.DataIntegrityViolationException

class CageStockOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cageStockOrderInstanceList: CageStockOrder.list(params), cageStockOrderInstanceTotal: CageStockOrder.count()]
    }

    def create() {
        [cageStockOrderInstance: new CageStockOrder(params)]
    }

    def save() {
        def cageStockOrderInstance = new CageStockOrder(params)
        if (!cageStockOrderInstance.save(flush: true)) {
            render(view: "create", model: [cageStockOrderInstance: cageStockOrderInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), cageStockOrderInstance.id])
        redirect(action: "show", id: cageStockOrderInstance.id)
    }

    def show() {
        def cageStockOrderInstance = CageStockOrder.get(params.id)
        if (!cageStockOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        [cageStockOrderInstance: cageStockOrderInstance]
    }

    def edit() {
        def cageStockOrderInstance = CageStockOrder.get(params.id)
        if (!cageStockOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        [cageStockOrderInstance: cageStockOrderInstance]
    }

    def update() {
        def cageStockOrderInstance = CageStockOrder.get(params.id)
        if (!cageStockOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cageStockOrderInstance.version > version) {
                cageStockOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cageStockOrder.label', default: 'CageStockOrder')] as Object[],
                          "Another user has updated this CageStockOrder while you were editing")
                render(view: "edit", model: [cageStockOrderInstance: cageStockOrderInstance])
                return
            }
        }

        cageStockOrderInstance.properties = params

        if (!cageStockOrderInstance.save(flush: true)) {
            render(view: "edit", model: [cageStockOrderInstance: cageStockOrderInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), cageStockOrderInstance.id])
        redirect(action: "show", id: cageStockOrderInstance.id)
    }

    def delete() {
        def cageStockOrderInstance = CageStockOrder.get(params.id)
        if (!cageStockOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cageStockOrderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
