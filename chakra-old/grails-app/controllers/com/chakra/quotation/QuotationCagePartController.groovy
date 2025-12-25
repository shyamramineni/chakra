package com.chakra.quotation

import org.springframework.dao.DataIntegrityViolationException

class QuotationCagePartController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [quotationCagePartInstanceList: QuotationCagePart.list(params), quotationCagePartInstanceTotal: QuotationCagePart.count()]
    }

    def create() {
        [quotationCagePartInstance: new QuotationCagePart(params)]
    }

    def save() {
        def quotationCagePartInstance = new QuotationCagePart(params)
        if (!quotationCagePartInstance.save(flush: true)) {
            render(view: "create", model: [quotationCagePartInstance: quotationCagePartInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'quotationCagePart.label', default: 'QuotationCagePart'), quotationCagePartInstance.id])
        redirect(action: "show", id: quotationCagePartInstance.id)
    }

    def show() {
        def quotationCagePartInstance = QuotationCagePart.get(params.id)
        if (!quotationCagePartInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationCagePart.label', default: 'QuotationCagePart'), params.id])
            redirect(action: "list")
            return
        }

        [quotationCagePartInstance: quotationCagePartInstance]
    }

    def edit() {
        def quotationCagePartInstance = QuotationCagePart.get(params.id)
        if (!quotationCagePartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationCagePart.label', default: 'QuotationCagePart'), params.id])
            redirect(action: "list")
            return
        }

        [quotationCagePartInstance: quotationCagePartInstance]
    }

    def update() {
        def quotationCagePartInstance = QuotationCagePart.get(params.id)
        if (!quotationCagePartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationCagePart.label', default: 'QuotationCagePart'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationCagePartInstance.version > version) {
                quotationCagePartInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotationCagePart.label', default: 'QuotationCagePart')] as Object[],
                          "Another user has updated this QuotationCagePart while you were editing")
                render(view: "edit", model: [quotationCagePartInstance: quotationCagePartInstance])
                return
            }
        }

        quotationCagePartInstance.properties = params

        if (!quotationCagePartInstance.save(flush: true)) {
            render(view: "edit", model: [quotationCagePartInstance: quotationCagePartInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationCagePart.label', default: 'QuotationCagePart'), quotationCagePartInstance.id])
        redirect(action: "show", id: quotationCagePartInstance.id)
    }

    def delete() {
        def quotationCagePartInstance = QuotationCagePart.get(params.id)
        if (!quotationCagePartInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationCagePart.label', default: 'QuotationCagePart'), params.id])
            redirect(action: "list")
            return
        }

        try {
            quotationCagePartInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotationCagePart.label', default: 'QuotationCagePart'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'quotationCagePart.label', default: 'QuotationCagePart'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
