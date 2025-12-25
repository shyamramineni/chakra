package com.chakra.quotation

import org.springframework.dao.DataIntegrityViolationException

class QuotationWeldSideModelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [quotationWeldSideModelInstanceList: QuotationWeldSideModel.list(params), quotationWeldSideModelInstanceTotal: QuotationWeldSideModel.count()]
    }

    def create() {
        [quotationWeldSideModelInstance: new QuotationWeldSideModel(params)]
    }

    def save() {
        def quotationWeldSideModelInstance = new QuotationWeldSideModel(params)
        if (!quotationWeldSideModelInstance.save(flush: true)) {
            render(view: "create", model: [quotationWeldSideModelInstance: quotationWeldSideModelInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), quotationWeldSideModelInstance.id])
        redirect(action: "show", id: quotationWeldSideModelInstance.id)
    }

    def show() {
        def quotationWeldSideModelInstance = QuotationWeldSideModel.get(params.id)
        if (!quotationWeldSideModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), params.id])
            redirect(action: "list")
            return
        }

        [quotationWeldSideModelInstance: quotationWeldSideModelInstance]
    }

    def edit() {
        def quotationWeldSideModelInstance = QuotationWeldSideModel.get(params.id)
        if (!quotationWeldSideModelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), params.id])
            redirect(action: "list")
            return
        }

        [quotationWeldSideModelInstance: quotationWeldSideModelInstance]
    }

    def update() {
        def quotationWeldSideModelInstance = QuotationWeldSideModel.get(params.id)
        if (!quotationWeldSideModelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationWeldSideModelInstance.version > version) {
                quotationWeldSideModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel')] as Object[],
                          "Another user has updated this QuotationWeldSideModel while you were editing")
                render(view: "edit", model: [quotationWeldSideModelInstance: quotationWeldSideModelInstance])
                return
            }
        }

        quotationWeldSideModelInstance.properties = params

        if (!quotationWeldSideModelInstance.save(flush: true)) {
            render(view: "edit", model: [quotationWeldSideModelInstance: quotationWeldSideModelInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), quotationWeldSideModelInstance.id])
        redirect(action: "show", id: quotationWeldSideModelInstance.id)
    }

    def delete() {
        def quotationWeldSideModelInstance = QuotationWeldSideModel.get(params.id)
        if (!quotationWeldSideModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), params.id])
            redirect(action: "list")
            return
        }

        try {
            quotationWeldSideModelInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
