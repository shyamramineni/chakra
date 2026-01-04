package com.chakra.stock

import org.springframework.dao.DataIntegrityViolationException

class WeldSideMeshStockOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [weldSideMeshStockOrderInstanceList: WeldSideMeshStockOrder.list(params), weldSideMeshStockOrderInstanceTotal: WeldSideMeshStockOrder.count()]
    }

    def create() {
        [weldSideMeshStockOrderInstance: new WeldSideMeshStockOrder(params)]
    }

    def save() {
        def weldSideMeshStockOrderInstance = new WeldSideMeshStockOrder(params)
        weldSideMeshStockOrderInstance.comments = params.comments+" "+"Created By "+"UNKNOWN_USER"+new Date().format("dd/MM/yy-hh:mm")+"<br>"
        if (!weldSideMeshStockOrderInstance.save(flush: true)) {
            render(view: "create", model: [weldSideMeshStockOrderInstance: weldSideMeshStockOrderInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder'), weldSideMeshStockOrderInstance.id])
        redirect(action: "show", id: weldSideMeshStockOrderInstance.id)
    }

    def show() {
        def weldSideMeshStockOrderInstance = WeldSideMeshStockOrder.get(params.id)
        if (!weldSideMeshStockOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        [weldSideMeshStockOrderInstance: weldSideMeshStockOrderInstance]
    }

    def edit() {
        def weldSideMeshStockOrderInstance = WeldSideMeshStockOrder.get(params.id)
        if (!weldSideMeshStockOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        [weldSideMeshStockOrderInstance: weldSideMeshStockOrderInstance]
    }

    def update() {
        def weldSideMeshStockOrderInstance = WeldSideMeshStockOrder.get(params.id)
        if (!weldSideMeshStockOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (weldSideMeshStockOrderInstance.version > version) {
                weldSideMeshStockOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder')] as Object[],
                          "Another user has updated this WeldSideMeshStockOrder while you were editing")
                render(view: "edit", model: [weldSideMeshStockOrderInstance: weldSideMeshStockOrderInstance])
                return
            }
        }

        weldSideMeshStockOrderInstance.properties = params
        weldSideMeshStockOrderInstance.comments = params.comments+" "+"Edited By "+"UNKNOWN_USER"+new Date().format("dd/MM/yy-hh:mm")+"<br>"

        if (!weldSideMeshStockOrderInstance.save(flush: true)) {
            render(view: "edit", model: [weldSideMeshStockOrderInstance: weldSideMeshStockOrderInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder'), weldSideMeshStockOrderInstance.id])
        redirect(action: "show", id: weldSideMeshStockOrderInstance.id)
    }

    def delete() {
        def weldSideMeshStockOrderInstance = WeldSideMeshStockOrder.get(params.id)
        if (!weldSideMeshStockOrderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder'), params.id])
            redirect(action: "list")
            return
        }

        try {
            weldSideMeshStockOrderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
