package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

class WireBrandController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [wireBrandInstanceList: WireBrand.list(params), wireBrandInstanceTotal: WireBrand.count()]
    }

    def create() {
        [wireBrandInstance: new WireBrand(params)]
    }

    def save() {
        def wireBrandInstance = new WireBrand(params)
        if (!wireBrandInstance.save(flush: true)) {
            render(view: "create", model: [wireBrandInstance: wireBrandInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), wireBrandInstance.id])
        redirect(action: "show", id: wireBrandInstance.id)
    }

    def show() {
        def wireBrandInstance = WireBrand.get(params.id)
        if (!wireBrandInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), params.id])
            redirect(action: "list")
            return
        }

        [wireBrandInstance: wireBrandInstance]
    }

    def edit() {
        def wireBrandInstance = WireBrand.get(params.id)
        if (!wireBrandInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), params.id])
            redirect(action: "list")
            return
        }

        [wireBrandInstance: wireBrandInstance]
    }

    def update() {
        def wireBrandInstance = WireBrand.get(params.id)
        if (!wireBrandInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (wireBrandInstance.version > version) {
                wireBrandInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'wireBrand.label', default: 'WireBrand')] as Object[],
                          "Another user has updated this WireBrand while you were editing")
                render(view: "edit", model: [wireBrandInstance: wireBrandInstance])
                return
            }
        }

        wireBrandInstance.properties = params

        if (!wireBrandInstance.save(flush: true)) {
            render(view: "edit", model: [wireBrandInstance: wireBrandInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), wireBrandInstance.id])
        redirect(action: "show", id: wireBrandInstance.id)
    }

    def delete() {
        def wireBrandInstance = WireBrand.get(params.id)
        if (!wireBrandInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), params.id])
            redirect(action: "list")
            return
        }

        try {
            wireBrandInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
