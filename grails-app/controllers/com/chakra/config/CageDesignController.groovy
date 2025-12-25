package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class CageDesignController {

    CageDesignService cageDesignService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond cageDesignService.list(params), model:[cageDesignCount: cageDesignService.count()]
    }

    def show(Long id) {
        respond cageDesignService.get(id)
    }

    def create() {
        respond new CageDesign(params)
    }

    def save(CageDesign cageDesign) {
        if (cageDesign == null) {
            notFound()
            return
        }

        try {
            cageDesignService.save(cageDesign)
        } catch (ValidationException e) {
            respond cageDesign.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), cageDesign.id])
                redirect cageDesign
            }
            '*' { respond cageDesign, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond cageDesignService.get(id)
    }

    def update(CageDesign cageDesign) {
        if (cageDesign == null) {
            notFound()
            return
        }

        try {
            cageDesignService.save(cageDesign)
        } catch (ValidationException e) {
            respond cageDesign.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), cageDesign.id])
                redirect cageDesign
            }
            '*'{ respond cageDesign, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        cageDesignService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesign.label', default: 'CageDesign'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
