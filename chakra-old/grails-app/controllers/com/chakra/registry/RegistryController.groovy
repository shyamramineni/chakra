package com.chakra.registry

import org.springframework.dao.DataIntegrityViolationException

class RegistryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
				
        [registryInstanceList: Registry.list(params), registryInstanceTotal: Registry.count()]
    }

    def create() {
        [registryInstance: new Registry(params)]
    }

    def save() {
        def registryInstance = new Registry(params)
        if (!registryInstance.save(flush: true)) {
            render(view: "create", model: [registryInstance: registryInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'registry.label', default: 'Registry'), registryInstance.id])
        redirect(action: "show", id: registryInstance.id)
    }

    def show() {
        def registryInstance = Registry.get(params.id)
        if (!registryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'registry.label', default: 'Registry'), params.id])
            redirect(action: "list")
            return
        }

        [registryInstance: registryInstance]
    }

    def edit() {
        def registryInstance = Registry.get(params.id)
        if (!registryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registry.label', default: 'Registry'), params.id])
            redirect(action: "list")
            return
        }

        [registryInstance: registryInstance]
    }

    def update() {
        def registryInstance = Registry.get(params.id)
        if (!registryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registry.label', default: 'Registry'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (registryInstance.version > version) {
                registryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'registry.label', default: 'Registry')] as Object[],
                          "Another user has updated this Registry while you were editing")
                render(view: "edit", model: [registryInstance: registryInstance])
                return
            }
        }

        registryInstance.properties = params

        if (!registryInstance.save(flush: true)) {
            render(view: "edit", model: [registryInstance: registryInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'registry.label', default: 'Registry'), registryInstance.id])
        redirect(action: "show", id: registryInstance.id)
    }

    def delete() {
        def registryInstance = Registry.get(params.id)
        if (!registryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'registry.label', default: 'Registry'), params.id])
            redirect(action: "list")
            return
        }

        try {
            registryInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'registry.label', default: 'Registry'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'registry.label', default: 'Registry'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
}
