package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class CageDesignSheetSpecFormulaController {

    CageDesignSheetSpecFormulaService cageDesignSheetSpecFormulaService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond cageDesignSheetSpecFormulaService.list(params), model:[cageDesignSheetSpecFormulaCount: cageDesignSheetSpecFormulaService.count()]
    }

    def show(Long id) {
        respond cageDesignSheetSpecFormulaService.get(id)
    }

    def create() {
        respond new CageDesignSheetSpecFormula(params)
    }

    def save(CageDesignSheetSpecFormula cageDesignSheetSpecFormula) {
        if (cageDesignSheetSpecFormula == null) {
            notFound()
            return
        }

        try {
            cageDesignSheetSpecFormulaService.save(cageDesignSheetSpecFormula)
        } catch (ValidationException e) {
            respond cageDesignSheetSpecFormula.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), cageDesignSheetSpecFormula.id])
                redirect cageDesignSheetSpecFormula
            }
            '*' { respond cageDesignSheetSpecFormula, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond cageDesignSheetSpecFormulaService.get(id)
    }

    def update(CageDesignSheetSpecFormula cageDesignSheetSpecFormula) {
        if (cageDesignSheetSpecFormula == null) {
            notFound()
            return
        }

        try {
            cageDesignSheetSpecFormulaService.save(cageDesignSheetSpecFormula)
        } catch (ValidationException e) {
            respond cageDesignSheetSpecFormula.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), cageDesignSheetSpecFormula.id])
                redirect cageDesignSheetSpecFormula
            }
            '*'{ respond cageDesignSheetSpecFormula, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        cageDesignSheetSpecFormulaService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageDesignSheetSpecFormula.label', default: 'CageDesignSheetSpecFormula'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
