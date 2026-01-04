package com.chakra.quotation

import org.springframework.dao.DataIntegrityViolationException

class QuotationMeshModelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [quotationMeshModelInstanceList: QuotationMeshModel.list(params), quotationMeshModelInstanceTotal: QuotationMeshModel.count()]
    }

    def create() {
        [quotationMeshModelInstance: new QuotationMeshModel(params)]
    }

    def save() {
        def quotationMeshModelInstance = new QuotationMeshModel(params)
        if (!quotationMeshModelInstance.save(flush: true)) {
            render(view: "create", model: [quotationMeshModelInstance: quotationMeshModelInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), quotationMeshModelInstance.id])
        redirect(action: "show", id: quotationMeshModelInstance.id)
    }

    def show() {
        def quotationMeshModelInstance = QuotationMeshModel.get(params.id)
        if (!quotationMeshModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), params.id])
            redirect(action: "list")
            return
        }

        [quotationMeshModelInstance: quotationMeshModelInstance]
    }

    def edit() {
        def quotationMeshModelInstance = QuotationMeshModel.get(params.id)
        if (!quotationMeshModelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), params.id])
            redirect(action: "list")
            return
        }

        [quotationMeshModelInstance: quotationMeshModelInstance]
    }

    def update() {
        def quotationMeshModelInstance = QuotationMeshModel.get(params.id)
        if (!quotationMeshModelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationMeshModelInstance.version > version) {
                quotationMeshModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel')] as Object[],
                          "Another user has updated this QuotationMeshModel while you were editing")
                render(view: "edit", model: [quotationMeshModelInstance: quotationMeshModelInstance])
                return
            }
        }

        quotationMeshModelInstance.properties = params

        if (!quotationMeshModelInstance.save(flush: true)) {
            render(view: "edit", model: [quotationMeshModelInstance: quotationMeshModelInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), quotationMeshModelInstance.id])
        redirect(action: "show", id: quotationMeshModelInstance.id)
    }

    def delete() {
        def quotationMeshModelInstance = QuotationMeshModel.get(params.id)
        if (!quotationMeshModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), params.id])
            redirect(action: "list")
            return
        }

        try {
            quotationMeshModelInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
