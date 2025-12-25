package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class TaxationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		
        [taxationInstanceList: Taxation.list(params), taxationInstanceTotal: Taxation.count()]
    }

    def create() {
        [taxationInstance: new Taxation(params)]
    }

    def save() {
        def taxationInstance = new Taxation(params)
        if (!taxationInstance.save(flush: true)) {
            render(view: "create", model: [taxationInstance: taxationInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'taxation.label', default: 'Taxation'), taxationInstance.id])
        redirect(action: "show", id: taxationInstance.id)
    }

    def show() {
        def taxationInstance = Taxation.get(params.id)
        if (!taxationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'taxation.label', default: 'Taxation'), params.id])
            redirect(action: "list")
            return
        }

        [taxationInstance: taxationInstance]
    }

    def edit() {
        def taxationInstance = Taxation.get(params.id)
        if (!taxationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'taxation.label', default: 'Taxation'), params.id])
            redirect(action: "list")
            return
        }

        [taxationInstance: taxationInstance]
    }

    def update() {
        def taxationInstance = Taxation.get(params.id)
        if (!taxationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'taxation.label', default: 'Taxation'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (taxationInstance.version > version) {
                taxationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'taxation.label', default: 'Taxation')] as Object[],
                          "Another user has updated this Taxation while you were editing")
                render(view: "edit", model: [taxationInstance: taxationInstance])
                return
            }
        }

        taxationInstance.properties = params

        if (!taxationInstance.save(flush: true)) {
            render(view: "edit", model: [taxationInstance: taxationInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'taxation.label', default: 'Taxation'), taxationInstance.id])
        redirect(action: "show", id: taxationInstance.id)
    }

    def delete() {
        def taxationInstance = Taxation.get(params.id)
        if (!taxationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'taxation.label', default: 'Taxation'), params.id])
            redirect(action: "list")
            return
        }

        try {
            taxationInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'taxation.label', default: 'Taxation'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'taxation.label', default: 'Taxation'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
