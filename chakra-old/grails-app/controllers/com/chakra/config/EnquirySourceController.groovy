package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

class EnquirySourceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [enquirySourceInstanceList: EnquirySource.list(params), enquirySourceInstanceTotal: EnquirySource.count()]
    }

    def create() {
        [enquirySourceInstance: new EnquirySource(params)]
    }

    def save() {
        def enquirySourceInstance = new EnquirySource(params)
        if (!enquirySourceInstance.save(flush: true)) {
            render(view: "create", model: [enquirySourceInstance: enquirySourceInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), enquirySourceInstance.id])
        redirect(action: "show", id: enquirySourceInstance.id)
    }

    def show() {
        def enquirySourceInstance = EnquirySource.get(params.id)
        if (!enquirySourceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), params.id])
            redirect(action: "list")
            return
        }

        [enquirySourceInstance: enquirySourceInstance]
    }

    def edit() {
        def enquirySourceInstance = EnquirySource.get(params.id)
        if (!enquirySourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), params.id])
            redirect(action: "list")
            return
        }

        [enquirySourceInstance: enquirySourceInstance]
    }

    def update() {
        def enquirySourceInstance = EnquirySource.get(params.id)
        if (!enquirySourceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (enquirySourceInstance.version > version) {
                enquirySourceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'enquirySource.label', default: 'EnquirySource')] as Object[],
                          "Another user has updated this EnquirySource while you were editing")
                render(view: "edit", model: [enquirySourceInstance: enquirySourceInstance])
                return
            }
        }

        enquirySourceInstance.properties = params

        if (!enquirySourceInstance.save(flush: true)) {
            render(view: "edit", model: [enquirySourceInstance: enquirySourceInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), enquirySourceInstance.id])
        redirect(action: "show", id: enquirySourceInstance.id)
    }

    def delete() {
        def enquirySourceInstance = EnquirySource.get(params.id)
        if (!enquirySourceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), params.id])
            redirect(action: "list")
            return
        }

        try {
            enquirySourceInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
