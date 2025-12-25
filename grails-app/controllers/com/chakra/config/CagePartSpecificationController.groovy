package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class CagePartSpecificationController {

    CagePartSpecificationService cagePartSpecificationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond cagePartSpecificationService.list(params), model:[cagePartSpecificationCount: cagePartSpecificationService.count()]
    }

    def show(Long id) {
        respond cagePartSpecificationService.get(id)
    }

    def create() {
        respond new CagePartSpecification(params)
    }

    def save(CagePartSpecification cagePartSpecification) {
        if (cagePartSpecification == null) {
            notFound()
            return
        }

        try {
            cagePartSpecificationService.save(cagePartSpecification)
        } catch (ValidationException e) {
            respond cagePartSpecification.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), cagePartSpecification.id])
                redirect cagePartSpecification
            }
            '*' { respond cagePartSpecification, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond cagePartSpecificationService.get(id)
    }

    def update(CagePartSpecification cagePartSpecification) {
        if (cagePartSpecification == null) {
            notFound()
            return
        }

        try {
            cagePartSpecificationService.save(cagePartSpecification)
        } catch (ValidationException e) {
            respond cagePartSpecification.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), cagePartSpecification.id])
                redirect cagePartSpecification
            }
            '*'{ respond cagePartSpecification, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        cagePartSpecificationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecification.label', default: 'CagePartSpecification'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
