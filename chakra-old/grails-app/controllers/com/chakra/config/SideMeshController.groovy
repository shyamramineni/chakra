package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

class SideMeshController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [sideMeshInstanceList: SideMesh.list(params), sideMeshInstanceTotal: SideMesh.count()]
    }

    def create() {
        [sideMeshInstance: new SideMesh(params)]
    }

    def save() {
        def sideMeshInstance = new SideMesh(params)
        if (!sideMeshInstance.save(flush: true)) {
            render(view: "create", model: [sideMeshInstance: sideMeshInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), sideMeshInstance.id])
        redirect(action: "show", id: sideMeshInstance.id)
    }

    def show() {
        def sideMeshInstance = SideMesh.get(params.id)
        if (!sideMeshInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), params.id])
            redirect(action: "list")
            return
        }

        [sideMeshInstance: sideMeshInstance]
    }

    def edit() {
        def sideMeshInstance = SideMesh.get(params.id)
        if (!sideMeshInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), params.id])
            redirect(action: "list")
            return
        }

        [sideMeshInstance: sideMeshInstance]
    }

    def update() {
        def sideMeshInstance = SideMesh.get(params.id)
        if (!sideMeshInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (sideMeshInstance.version > version) {
                sideMeshInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'sideMesh.label', default: 'SideMesh')] as Object[],
                          "Another user has updated this SideMesh while you were editing")
                render(view: "edit", model: [sideMeshInstance: sideMeshInstance])
                return
            }
        }

        sideMeshInstance.properties = params

        if (!sideMeshInstance.save(flush: true)) {
            render(view: "edit", model: [sideMeshInstance: sideMeshInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), sideMeshInstance.id])
        redirect(action: "show", id: sideMeshInstance.id)
    }

    def delete() {
        def sideMeshInstance = SideMesh.get(params.id)
        if (!sideMeshInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), params.id])
            redirect(action: "list")
            return
        }

        try {
            sideMeshInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def sideMeshPriceReport() {
	
	}
}
