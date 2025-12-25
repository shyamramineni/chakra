package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

class QuotationFailedReasonController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [quotationFailedReasonInstanceList: QuotationFailedReason.list(params), quotationFailedReasonInstanceTotal: QuotationFailedReason.count()]
    }

    def create() {
        [quotationFailedReasonInstance: new QuotationFailedReason(params)]
    }

    def save() {
        def quotationFailedReasonInstance = new QuotationFailedReason(params)
        if (!quotationFailedReasonInstance.save(flush: true)) {
            render(view: "create", model: [quotationFailedReasonInstance: quotationFailedReasonInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), quotationFailedReasonInstance.id])
        redirect(action: "show", id: quotationFailedReasonInstance.id)
    }

    def show() {
        def quotationFailedReasonInstance = QuotationFailedReason.get(params.id)
        if (!quotationFailedReasonInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), params.id])
            redirect(action: "list")
            return
        }

        [quotationFailedReasonInstance: quotationFailedReasonInstance]
    }

    def edit() {
        def quotationFailedReasonInstance = QuotationFailedReason.get(params.id)
        if (!quotationFailedReasonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), params.id])
            redirect(action: "list")
            return
        }

        [quotationFailedReasonInstance: quotationFailedReasonInstance]
    }

    def update() {
        def quotationFailedReasonInstance = QuotationFailedReason.get(params.id)
        if (!quotationFailedReasonInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationFailedReasonInstance.version > version) {
                quotationFailedReasonInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason')] as Object[],
                          "Another user has updated this QuotationFailedReason while you were editing")
                render(view: "edit", model: [quotationFailedReasonInstance: quotationFailedReasonInstance])
                return
            }
        }

        quotationFailedReasonInstance.properties = params

        if (!quotationFailedReasonInstance.save(flush: true)) {
            render(view: "edit", model: [quotationFailedReasonInstance: quotationFailedReasonInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), quotationFailedReasonInstance.id])
        redirect(action: "show", id: quotationFailedReasonInstance.id)
    }

    def delete() {
        def quotationFailedReasonInstance = QuotationFailedReason.get(params.id)
        if (!quotationFailedReasonInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), params.id])
            redirect(action: "list")
            return
        }

        try {
            quotationFailedReasonInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
