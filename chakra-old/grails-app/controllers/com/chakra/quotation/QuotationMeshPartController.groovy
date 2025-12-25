package com.chakra.quotation

import org.springframework.dao.DataIntegrityViolationException

class QuotationMeshPartController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [quotationMeshPartInstanceList: QuotationMeshPart.list(params), quotationMeshPartInstanceTotal: QuotationMeshPart.count()]
    }

    def create() {
        [quotationMeshPartInstance: new QuotationMeshPart(params)]
    }

    def save() {
        def quotationMeshPartInstance = new QuotationMeshPart(params)
        if (!quotationMeshPartInstance.save(flush: true)) {
            render(view: "create", model: [quotationMeshPartInstance: quotationMeshPartInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart'), quotationMeshPartInstance.id])
        redirect(action: "show", id: quotationMeshPartInstance.id)
    }

    def show() {
        def quotationMeshPartInstance = QuotationMeshPart.get(params.id)
        if (!quotationMeshPartInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart'), params.id])
            redirect(action: "list")
            return
        }

        [quotationMeshPartInstance: quotationMeshPartInstance]
    }

    def edit() {
        def quotationMeshPartInstance = QuotationMeshPart.get(params.id)
        if (!quotationMeshPartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart'), params.id])
            redirect(action: "list")
            return
        }

        [quotationMeshPartInstance: quotationMeshPartInstance]
    }

    def update() {
        def quotationMeshPartInstance = QuotationMeshPart.get(params.id)
        if (!quotationMeshPartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationMeshPartInstance.version > version) {
                quotationMeshPartInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart')] as Object[],
                          "Another user has updated this QuotationMeshPart while you were editing")
                render(view: "edit", model: [quotationMeshPartInstance: quotationMeshPartInstance])
                return
            }
        }

        quotationMeshPartInstance.properties = params

        if (!quotationMeshPartInstance.save(flush: true)) {
            render(view: "edit", model: [quotationMeshPartInstance: quotationMeshPartInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart'), quotationMeshPartInstance.id])
        redirect(action: "show", id: quotationMeshPartInstance.id)
    }

    def delete() {
        def quotationMeshPartInstance = QuotationMeshPart.get(params.id)
        if (!quotationMeshPartInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart'), params.id])
            redirect(action: "list")
            return
        }

        try {
            quotationMeshPartInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'quotationMeshPart.label', default: 'QuotationMeshPart'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
