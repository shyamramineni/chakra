package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class LinkMeshController {

    LinkMeshService linkMeshService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond linkMeshService.list(params), model:[linkMeshCount: linkMeshService.count()]
    }

    def show(Long id) {
        respond linkMeshService.get(id)
    }

    def create() {
        respond new LinkMesh(params)
    }

    def save(LinkMesh linkMesh) {
        if (linkMesh == null) {
            notFound()
            return
        }

        try {
            linkMeshService.save(linkMesh)
        } catch (ValidationException e) {
            respond linkMesh.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), linkMesh.id])
                redirect linkMesh
            }
            '*' { respond linkMesh, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond linkMeshService.get(id)
    }

    def update(LinkMesh linkMesh) {
        if (linkMesh == null) {
            notFound()
            return
        }

        try {
            linkMeshService.save(linkMesh)
        } catch (ValidationException e) {
            respond linkMesh.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), linkMesh.id])
                redirect linkMesh
            }
            '*'{ respond linkMesh, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        linkMeshService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'linkMesh.label', default: 'LinkMesh'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
