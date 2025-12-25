package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

class CagePartSpecFormulaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cagePartSpecFormulaInstanceList: CagePartSpecFormula.list(params), cagePartSpecFormulaInstanceTotal: CagePartSpecFormula.count()]
    }

    def create() {
        [cagePartSpecFormulaInstance: new CagePartSpecFormula(params)]
    }

    def save() {
        def cagePartSpecFormulaInstance = new CagePartSpecFormula(params)
        if (!cagePartSpecFormulaInstance.save(flush: true)) {
            render(view: "create", model: [cagePartSpecFormulaInstance: cagePartSpecFormulaInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), cagePartSpecFormulaInstance.id])
        redirect(action: "show", id: cagePartSpecFormulaInstance.id)
    }

    def show() {
        def cagePartSpecFormulaInstance = CagePartSpecFormula.get(params.id)
        if (!cagePartSpecFormulaInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartSpecFormulaInstance: cagePartSpecFormulaInstance]
    }

    def edit() {
        def cagePartSpecFormulaInstance = CagePartSpecFormula.get(params.id)
        if (!cagePartSpecFormulaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), params.id])
            redirect(action: "list")
            return
        }

        [cagePartSpecFormulaInstance: cagePartSpecFormulaInstance]
    }

    def update() {
        def cagePartSpecFormulaInstance = CagePartSpecFormula.get(params.id)
        if (!cagePartSpecFormulaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (cagePartSpecFormulaInstance.version > version) {
                cagePartSpecFormulaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula')] as Object[],
                          "Another user has updated this CagePartSpecFormula while you were editing")
                render(view: "edit", model: [cagePartSpecFormulaInstance: cagePartSpecFormulaInstance])
                return
            }
        }

        cagePartSpecFormulaInstance.properties = params

        if (!cagePartSpecFormulaInstance.save(flush: true)) {
            render(view: "edit", model: [cagePartSpecFormulaInstance: cagePartSpecFormulaInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), cagePartSpecFormulaInstance.id])
        redirect(action: "show", id: cagePartSpecFormulaInstance.id)
    }

    def delete() {
        def cagePartSpecFormulaInstance = CagePartSpecFormula.get(params.id)
        if (!cagePartSpecFormulaInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), params.id])
            redirect(action: "list")
            return
        }

        try {
            cagePartSpecFormulaInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cagePartSpecFormula.label', default: 'CagePartSpecFormula'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
