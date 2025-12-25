package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class WireBrandController {

    WireBrandService wireBrandService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond wireBrandService.list(params), model:[wireBrandCount: wireBrandService.count()]
    }

    def show(Long id) {
        respond wireBrandService.get(id)
    }

    def create() {
        respond new WireBrand(params)
    }

    def save(WireBrand wireBrand) {
        if (wireBrand == null) {
            notFound()
            return
        }

        try {
            wireBrandService.save(wireBrand)
        } catch (ValidationException e) {
            respond wireBrand.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), wireBrand.id])
                redirect wireBrand
            }
            '*' { respond wireBrand, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond wireBrandService.get(id)
    }

    def update(WireBrand wireBrand) {
        if (wireBrand == null) {
            notFound()
            return
        }

        try {
            wireBrandService.save(wireBrand)
        } catch (ValidationException e) {
            respond wireBrand.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), wireBrand.id])
                redirect wireBrand
            }
            '*'{ respond wireBrand, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        wireBrandService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'wireBrand.label', default: 'WireBrand'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
