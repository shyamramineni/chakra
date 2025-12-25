package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class CagePartSpecFormulaController {

    CagePartSpecFormulaService cagePartSpecFormulaService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond cagePartSpecFormulaService.list(params), model:[cagePartSpecFormulaCount: cagePartSpecFormulaService.count()]
    }

    def show(Long id) {
        respond cagePartSpecFormulaService.get(id)
    }

    def create() {
        respond new CagePartSpecFormula(params)
    }

    def save(CagePartSpecFormula cagePartSpecFormula) {
        if (cagePartSpecFormula == null) {
            notFound()
            return
        }

        try {
            cagePartSpecFormulaService.save(cagePartSpecFormula)
        } catch (ValidationException e) {
            respond cagePartSpecFormula.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), cagePartSpecFormula.id])
                redirect cagePartSpecFormula
            }
            '*' { respond cagePartSpecFormula, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond cagePartSpecFormulaService.get(id)
    }

    def update(CagePartSpecFormula cagePartSpecFormula) {
        if (cagePartSpecFormula == null) {
            notFound()
            return
        }

        try {
            cagePartSpecFormulaService.save(cagePartSpecFormula)
        } catch (ValidationException e) {
            respond cagePartSpecFormula.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), cagePartSpecFormula.id])
                redirect cagePartSpecFormula
            }
            '*'{ respond cagePartSpecFormula, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        cagePartSpecFormulaService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
