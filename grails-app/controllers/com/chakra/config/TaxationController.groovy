package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class TaxationController {

    TaxationService taxationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond taxationService.list(params), model:[taxationCount: taxationService.count()]
    }

    def show(Long id) {
        respond taxationService.get(id)
    }

    def create() {
        respond new Taxation(params)
    }

    def save(Taxation taxation) {
        if (taxation == null) {
            notFound()
            return
        }

        try {
            taxationService.save(taxation)
        } catch (ValidationException e) {
            respond taxation.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'taxation.label', default: 'Taxation'), taxation.id])
                redirect taxation
            }
            '*' { respond taxation, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond taxationService.get(id)
    }

    def update(Taxation taxation) {
        if (taxation == null) {
            notFound()
            return
        }

        try {
            taxationService.save(taxation)
        } catch (ValidationException e) {
            respond taxation.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'taxation.label', default: 'Taxation'), taxation.id])
                redirect taxation
            }
            '*'{ respond taxation, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        taxationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'taxation.label', default: 'Taxation'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'taxation.label', default: 'Taxation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
