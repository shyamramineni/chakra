package com.chakra.order

import org.springframework.dao.DataIntegrityViolationException

class CorderMeshPartsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [orderMeshPartsInstanceList: CorderMeshParts.list(params), orderMeshPartsInstanceTotal: CorderMeshParts.count()]
    }

    def create() {
        [orderMeshPartsInstance: new CorderMeshParts(params)]
    }

    def save() {
        def orderMeshPartsInstance = new CorderMeshParts(params)
        if (!orderMeshPartsInstance.save(flush: true)) {
            render(view: "create", model: [orderMeshPartsInstance: orderMeshPartsInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'orderMeshParts.label', default: 'OrderMeshParts'), orderMeshPartsInstance.id])
        redirect(action: "show", id: orderMeshPartsInstance.id)
    }

    def show() {
        def orderMeshPartsInstance = CorderMeshParts.get(params.id)
        if (!orderMeshPartsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'orderMeshParts.label', default: 'OrderMeshParts'), params.id])
            redirect(action: "list")
            return
        }

        [orderMeshPartsInstance: orderMeshPartsInstance]
    }

    def edit() {
        def orderMeshPartsInstance = CorderMeshParts.get(params.id)
        if (!orderMeshPartsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orderMeshParts.label', default: 'OrderMeshParts'), params.id])
            redirect(action: "list")
            return
        }

        [orderMeshPartsInstance: orderMeshPartsInstance]
    }

    def update() {
        def orderMeshPartsInstance = CorderMeshParts.get(params.id)
        if (!orderMeshPartsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orderMeshParts.label', default: 'OrderMeshParts'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (orderMeshPartsInstance.version > version) {
                orderMeshPartsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'orderMeshParts.label', default: 'OrderMeshParts')] as Object[],
                          "Another user has updated this OrderMeshParts while you were editing")
                render(view: "edit", model: [orderMeshPartsInstance: orderMeshPartsInstance])
                return
            }
        }

        orderMeshPartsInstance.properties = params

        if (!orderMeshPartsInstance.save(flush: true)) {
            render(view: "edit", model: [orderMeshPartsInstance: orderMeshPartsInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'orderMeshParts.label', default: 'OrderMeshParts'), orderMeshPartsInstance.id])
        redirect(action: "show", id: orderMeshPartsInstance.id)
    }

    def delete() {
        def orderMeshPartsInstance = CorderMeshParts.get(params.id)
        if (!orderMeshPartsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'orderMeshParts.label', default: 'OrderMeshParts'), params.id])
            redirect(action: "list")
            return
        }

        try {
            orderMeshPartsInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'orderMeshParts.label', default: 'OrderMeshParts'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'orderMeshParts.label', default: 'OrderMeshParts'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
