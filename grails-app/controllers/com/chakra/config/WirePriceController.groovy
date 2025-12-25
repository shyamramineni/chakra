package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class WirePriceController {

    WirePriceService wirePriceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond wirePriceService.list(params), model:[wirePriceCount: wirePriceService.count()]
    }

    def show(Long id) {
        respond wirePriceService.get(id)
    }

    def create() {
        respond new WirePrice(params)
    }

    def save(WirePrice wirePrice) {
        if (wirePrice == null) {
            notFound()
            return
        }

        try {
            wirePriceService.save(wirePrice)
        } catch (ValidationException e) {
            respond wirePrice.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), wirePrice.id])
                redirect wirePrice
            }
            '*' { respond wirePrice, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond wirePriceService.get(id)
    }

    def update(WirePrice wirePrice) {
        if (wirePrice == null) {
            notFound()
            return
        }

        try {
            wirePriceService.save(wirePrice)
        } catch (ValidationException e) {
            respond wirePrice.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), wirePrice.id])
                redirect wirePrice
            }
            '*'{ respond wirePrice, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        wirePriceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
