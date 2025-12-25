package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class QuotationFailedReasonController {

    QuotationFailedReasonService quotationFailedReasonService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond quotationFailedReasonService.list(params), model:[quotationFailedReasonCount: quotationFailedReasonService.count()]
    }

    def show(Long id) {
        respond quotationFailedReasonService.get(id)
    }

    def create() {
        respond new QuotationFailedReason(params)
    }

    def save(QuotationFailedReason quotationFailedReason) {
        if (quotationFailedReason == null) {
            notFound()
            return
        }

        try {
            quotationFailedReasonService.save(quotationFailedReason)
        } catch (ValidationException e) {
            respond quotationFailedReason.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), quotationFailedReason.id])
                redirect quotationFailedReason
            }
            '*' { respond quotationFailedReason, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond quotationFailedReasonService.get(id)
    }

    def update(QuotationFailedReason quotationFailedReason) {
        if (quotationFailedReason == null) {
            notFound()
            return
        }

        try {
            quotationFailedReasonService.save(quotationFailedReason)
        } catch (ValidationException e) {
            respond quotationFailedReason.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), quotationFailedReason.id])
                redirect quotationFailedReason
            }
            '*'{ respond quotationFailedReason, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        quotationFailedReasonService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationFailedReason.label', default: 'QuotationFailedReason'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
