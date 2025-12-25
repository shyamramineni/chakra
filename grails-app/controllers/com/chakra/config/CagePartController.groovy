package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class CagePartController {

    CagePartService cagePartService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond cagePartService.list(params), model:[cagePartCount: cagePartService.count()]
    }

    def show(Long id) {
        respond cagePartService.get(id)
    }

    def create() {
        respond new CagePart(params)
    }

    def save(CagePart cagePart) {
        if (cagePart == null) {
            notFound()
            return
        }

        try {
            cagePartService.save(cagePart)
        } catch (ValidationException e) {
            respond cagePart.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cagePart.label', default: 'CagePart'), cagePart.id])
                redirect cagePart
            }
            '*' { respond cagePart, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond cagePartService.get(id)
    }

    def update(CagePart cagePart) {
        if (cagePart == null) {
            notFound()
            return
        }

        try {
            cagePartService.save(cagePart)
        } catch (ValidationException e) {
            respond cagePart.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePart.label', default: 'CagePart'), cagePart.id])
                redirect cagePart
            }
            '*'{ respond cagePart, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        cagePartService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePart.label', default: 'CagePart'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePart.label', default: 'CagePart'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
