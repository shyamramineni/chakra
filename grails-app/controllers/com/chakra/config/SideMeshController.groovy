package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class SideMeshController {

    SideMeshService sideMeshService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond sideMeshService.list(params), model:[sideMeshCount: sideMeshService.count()]
    }

    def show(Long id) {
        respond sideMeshService.get(id)
    }

    def create() {
        respond new SideMesh(params)
    }

    def save(SideMesh sideMesh) {
        if (sideMesh == null) {
            notFound()
            return
        }

        try {
            sideMeshService.save(sideMesh)
        } catch (ValidationException e) {
            respond sideMesh.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), sideMesh.id])
                redirect sideMesh
            }
            '*' { respond sideMesh, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond sideMeshService.get(id)
    }

    def update(SideMesh sideMesh) {
        if (sideMesh == null) {
            notFound()
            return
        }

        try {
            sideMeshService.save(sideMesh)
        } catch (ValidationException e) {
            respond sideMesh.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), sideMesh.id])
                redirect sideMesh
            }
            '*'{ respond sideMesh, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        sideMeshService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sideMesh.label', default: 'SideMesh'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
