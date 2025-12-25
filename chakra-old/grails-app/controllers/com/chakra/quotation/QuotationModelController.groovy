package com.chakra.quotation

import org.springframework.dao.DataIntegrityViolationException

class QuotationModelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [quotationModelsInstanceList: QuotationModel.list(params), quotationModelsInstanceTotal: QuotationModel.count()]
    }

    def create() {
        [quotationModelsInstance: new QuotationModel(params)]
    }

    def save() {
        def quotationModelsInstance = new QuotationModel(params)
        if (!quotationModelsInstance.save(flush: true)) {
            render(view: "create", model: [quotationModelsInstance: quotationModelsInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'quotationModels.label', default: 'QuotationModels'), quotationModelsInstance.id])
        redirect(action: "show", id: quotationModelsInstance.id)
    }

    def show() {
        def quotationModelsInstance = QuotationModel.get(params.id)
        if (!quotationModelsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationModels.label', default: 'QuotationModels'), params.id])
            redirect(action: "list")
            return
        }

        [quotationModelsInstance: quotationModelsInstance]
    }

    def edit() {
        def quotationModelsInstance = QuotationModel.get(params.id)
        if (!quotationModelsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationModels.label', default: 'QuotationModels'), params.id])
            redirect(action: "list")
            return
        }

        [quotationModelsInstance: quotationModelsInstance]
    }

    def update() {
        def quotationModelsInstance = QuotationModel.get(params.id)
        if (!quotationModelsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationModels.label', default: 'QuotationModels'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationModelsInstance.version > version) {
                quotationModelsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotationModels.label', default: 'QuotationModels')] as Object[],
                          "Another user has updated this QuotationModels while you were editing")
                render(view: "edit", model: [quotationModelsInstance: quotationModelsInstance])
                return
            }
        }

        quotationModelsInstance.properties = params

        if (!quotationModelsInstance.save(flush: true)) {
            render(view: "edit", model: [quotationModelsInstance: quotationModelsInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationModels.label', default: 'QuotationModels'), quotationModelsInstance.id])
        redirect(action: "show", id: quotationModelsInstance.id)
    }

    def delete() {
        def quotationModelsInstance = QuotationModel.get(params.id)
        if (!quotationModelsInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationModels.label', default: 'QuotationModels'), params.id])
            redirect(action: "list")
            return
        }

        try {
            quotationModelsInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotationModels.label', default: 'QuotationModels'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'quotationModels.label', default: 'QuotationModels'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
