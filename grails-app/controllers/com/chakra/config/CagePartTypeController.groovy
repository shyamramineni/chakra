package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class CagePartTypeController {

    CagePartTypeService cagePartTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond cagePartTypeService.list(params), model:[cagePartTypeCount: cagePartTypeService.count()]
    }

    def show(Long id) {
        respond cagePartTypeService.get(id)
    }

    def create() {
        respond new CagePartType(params)
    }

    def save(CagePartType cagePartType) {
        if (cagePartType == null) {
            notFound()
            return
        }

        try {
            cagePartTypeService.save(cagePartType)
        } catch (ValidationException e) {
            respond cagePartType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), cagePartType.id])
                redirect cagePartType
            }
            '*' { respond cagePartType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond cagePartTypeService.get(id)
    }

    def update(CagePartType cagePartType) {
        if (cagePartType == null) {
            notFound()
            return
        }

        try {
            cagePartTypeService.save(cagePartType)
        } catch (ValidationException e) {
            respond cagePartType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), cagePartType.id])
                redirect cagePartType
            }
            '*'{ respond cagePartType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        cagePartTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartType.label', default: 'CagePartType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
