package com.chakra.quotation

import org.springframework.dao.DataIntegrityViolationException

class QuotationChainLinkModelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [quotationChainLinkModelInstanceList: QuotationChainLinkModel.list(params), quotationChainLinkModelInstanceTotal: QuotationChainLinkModel.count()]
    }

    def create() {
        [quotationChainLinkModelInstance: new QuotationChainLinkModel(params)]
    }

    def save() {
        def quotationChainLinkModelInstance = new QuotationChainLinkModel(params)
        if (!quotationChainLinkModelInstance.save(flush: true)) {
            render(view: "create", model: [quotationChainLinkModelInstance: quotationChainLinkModelInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), quotationChainLinkModelInstance.id])
        redirect(action: "show", id: quotationChainLinkModelInstance.id)
    }

    def show() {
        def quotationChainLinkModelInstance = QuotationChainLinkModel.get(params.id)
        if (!quotationChainLinkModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), params.id])
            redirect(action: "list")
            return
        }

        [quotationChainLinkModelInstance: quotationChainLinkModelInstance]
    }

    def edit() {
        def quotationChainLinkModelInstance = QuotationChainLinkModel.get(params.id)
        if (!quotationChainLinkModelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), params.id])
            redirect(action: "list")
            return
        }

        [quotationChainLinkModelInstance: quotationChainLinkModelInstance]
    }

    def update() {
        def quotationChainLinkModelInstance = QuotationChainLinkModel.get(params.id)
        if (!quotationChainLinkModelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationChainLinkModelInstance.version > version) {
                quotationChainLinkModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel')] as Object[],
                          "Another user has updated this QuotationChainLinkModel while you were editing")
                render(view: "edit", model: [quotationChainLinkModelInstance: quotationChainLinkModelInstance])
                return
            }
        }

        quotationChainLinkModelInstance.properties = params

        if (!quotationChainLinkModelInstance.save(flush: true)) {
            render(view: "edit", model: [quotationChainLinkModelInstance: quotationChainLinkModelInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), quotationChainLinkModelInstance.id])
        redirect(action: "show", id: quotationChainLinkModelInstance.id)
    }

    def delete() {
        def quotationChainLinkModelInstance = QuotationChainLinkModel.get(params.id)
        if (!quotationChainLinkModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), params.id])
            redirect(action: "list")
            return
        }

        try {
            quotationChainLinkModelInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
