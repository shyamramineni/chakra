package com.chakra.quotation

import org.springframework.dao.DataIntegrityViolationException

class QuotationChainLinkController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [quotationChainLinkInstanceList: QuotationChainLink.list(params), quotationChainLinkInstanceTotal: QuotationChainLink.count()]
    }

    def create() {
        [quotationChainLinkInstance: new QuotationChainLink(params)]
    }

    def save() {
        def quotationChainLinkInstance = new QuotationChainLink(params)
        if (!quotationChainLinkInstance.save(flush: true)) {
            render(view: "quotationLinkMesh", model: [quotationChainLinkInstance: quotationChainLinkInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'quotationChainLink.label', default: 'QuotationChainLink'), quotationChainLinkInstance.id])
        redirect(action: "show", id: quotationChainLinkInstance.id)
    }

    def show() {
        def quotationChainLinkInstance = QuotationChainLink.get(params.id)
        if (!quotationChainLinkInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLink.label', default: 'QuotationChainLink'), params.id])
            redirect(action: "list")
            return
        }

        [quotationChainLinkInstance: quotationChainLinkInstance]
    }

    def edit() {
        def quotationChainLinkInstance = QuotationChainLink.get(params.id)
        if (!quotationChainLinkInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLink.label', default: 'QuotationChainLink'), params.id])
            redirect(action: "list")
            return
        }

        [quotationChainLinkInstance: quotationChainLinkInstance]
    }

    def update() {
        def quotationChainLinkInstance = QuotationChainLink.get(params.id)
        if (!quotationChainLinkInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLink.label', default: 'QuotationChainLink'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationChainLinkInstance.version > version) {
                quotationChainLinkInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotationChainLink.label', default: 'QuotationChainLink')] as Object[],
                          "Another user has updated this QuotationChainLink while you were editing")
                render(view: "edit", model: [quotationChainLinkInstance: quotationChainLinkInstance])
                return
            }
        }

        quotationChainLinkInstance.properties = params

        if (!quotationChainLinkInstance.save(flush: true)) {
            render(view: "edit", model: [quotationChainLinkInstance: quotationChainLinkInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationChainLink.label', default: 'QuotationChainLink'), quotationChainLinkInstance.id])
        redirect(action: "show", id: quotationChainLinkInstance.id)
    }

    def delete() {
        def quotationChainLinkInstance = QuotationChainLink.get(params.id)
        if (!quotationChainLinkInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLink.label', default: 'QuotationChainLink'), params.id])
            redirect(action: "list")
            return
        }

        try {
            quotationChainLinkInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotationChainLink.label', default: 'QuotationChainLink'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'quotationChainLink.label', default: 'QuotationChainLink'), params.id])
            redirect(action: "show", id: params.id)
        }
    }	
	
}
