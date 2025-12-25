package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

class LinkMeshController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [linkMeshInstanceList: LinkMesh.list(params), linkMeshInstanceTotal: LinkMesh.count()]
    }

    def create() {
        [linkMeshInstance: new LinkMesh(params)]
    }

    def save() {
        def linkMeshInstance = new LinkMesh(params)
        if (!linkMeshInstance.save(flush: true)) {
            render(view: "create", model: [linkMeshInstance: linkMeshInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), linkMeshInstance.id])
        redirect(action: "show", id: linkMeshInstance.id)
    }

    def show() {
        def linkMeshInstance = LinkMesh.get(params.id)
        if (!linkMeshInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), params.id])
            redirect(action: "list")
            return
        }

        [linkMeshInstance: linkMeshInstance]
    }

    def edit() {
        def linkMeshInstance = LinkMesh.get(params.id)
        if (!linkMeshInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), params.id])
            redirect(action: "list")
            return
        }

        [linkMeshInstance: linkMeshInstance]
    }

    def update() {
        def linkMeshInstance = LinkMesh.get(params.id)
        if (!linkMeshInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (linkMeshInstance.version > version) {
                linkMeshInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'linkMesh.label', default: 'LinkMesh')] as Object[],
                          "Another user has updated this LinkMesh while you were editing")
                render(view: "edit", model: [linkMeshInstance: linkMeshInstance])
                return
            }
        }

        linkMeshInstance.properties = params

        if (!linkMeshInstance.save(flush: true)) {
            render(view: "edit", model: [linkMeshInstance: linkMeshInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), linkMeshInstance.id])
        redirect(action: "show", id: linkMeshInstance.id)
    }

    def delete() {
        def linkMeshInstance = LinkMesh.get(params.id)
        if (!linkMeshInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), params.id])
            redirect(action: "list")
            return
        }

        try {
            linkMeshInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def linkMeshPriceReport() {
		
	}
}
