package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class EnquirySourceController {

    EnquirySourceService enquirySourceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond enquirySourceService.list(params), model:[enquirySourceCount: enquirySourceService.count()]
    }

    def show(Long id) {
        respond enquirySourceService.get(id)
    }

    def create() {
        respond new EnquirySource(params)
    }

    def save(EnquirySource enquirySource) {
        if (enquirySource == null) {
            notFound()
            return
        }

        try {
            enquirySourceService.save(enquirySource)
        } catch (ValidationException e) {
            respond enquirySource.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), enquirySource.id])
                redirect enquirySource
            }
            '*' { respond enquirySource, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond enquirySourceService.get(id)
    }

    def update(EnquirySource enquirySource) {
        if (enquirySource == null) {
            notFound()
            return
        }

        try {
            enquirySourceService.save(enquirySource)
        } catch (ValidationException e) {
            respond enquirySource.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), enquirySource.id])
                redirect enquirySource
            }
            '*'{ respond enquirySource, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        enquirySourceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquirySource.label', default: 'EnquirySource'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
