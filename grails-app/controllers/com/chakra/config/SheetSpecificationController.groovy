package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class SheetSpecificationController {

    SheetSpecificationService sheetSpecificationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond sheetSpecificationService.list(params), model:[sheetSpecificationCount: sheetSpecificationService.count()]
    }

    def show(Long id) {
        respond sheetSpecificationService.get(id)
    }

    def create() {
        respond new SheetSpecification(params)
    }

    def save(SheetSpecification sheetSpecification) {
        if (sheetSpecification == null) {
            notFound()
            return
        }

        try {
            sheetSpecificationService.save(sheetSpecification)
        } catch (ValidationException e) {
            respond sheetSpecification.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), sheetSpecification.id])
                redirect sheetSpecification
            }
            '*' { respond sheetSpecification, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond sheetSpecificationService.get(id)
    }

    def update(SheetSpecification sheetSpecification) {
        if (sheetSpecification == null) {
            notFound()
            return
        }

        try {
            sheetSpecificationService.save(sheetSpecification)
        } catch (ValidationException e) {
            respond sheetSpecification.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), sheetSpecification.id])
                redirect sheetSpecification
            }
            '*'{ respond sheetSpecification, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        sheetSpecificationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
