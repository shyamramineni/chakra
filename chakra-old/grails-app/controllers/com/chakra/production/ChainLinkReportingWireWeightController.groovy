package com.chakra.production

import org.springframework.dao.DataIntegrityViolationException

class ChainLinkReportingWireWeightController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		
		def w = ChainLinkReportingWireWeight.createCriteria()
		def chainLinkReportingWireWeightInstanceList = w.list {
			
			isNotNull("wireConsumptionDate")
			isNotNull("wireBrand")
			isNotNull("diameter")
			
			projections {
				
				groupProperty("wireBrand")
				groupProperty("diameter")
				groupProperty("wireConsumptionDate")
				sum("weight")
				
				
			}
		}
		println'chainLinkReportingWireWeightInstanceList '+chainLinkReportingWireWeightInstanceList
        //[chainLinkReportingWireWeightInstanceList: ChainLinkReportingWireWeight.list(params), chainLinkReportingWireWeightInstanceTotal: ChainLinkReportingWireWeight.count()]
		[chainLinkReportingWireWeightInstanceList: chainLinkReportingWireWeightInstanceList, chainLinkReportingWireWeightInstanceTotal: chainLinkReportingWireWeightInstanceList.size()]
    }

    def create() {
        [chainLinkReportingWireWeightInstance: new ChainLinkReportingWireWeight(params)]
    }

    def save() {
        def chainLinkReportingWireWeightInstance = new ChainLinkReportingWireWeight(params)
        if (!chainLinkReportingWireWeightInstance.save(flush: true)) {
            render(view: "create", model: [chainLinkReportingWireWeightInstance: chainLinkReportingWireWeightInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight'), chainLinkReportingWireWeightInstance.id])
        redirect(action: "show", id: chainLinkReportingWireWeightInstance.id)
    }

    def show() {
        def chainLinkReportingWireWeightInstance = ChainLinkReportingWireWeight.get(params.id)
        if (!chainLinkReportingWireWeightInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        [chainLinkReportingWireWeightInstance: chainLinkReportingWireWeightInstance]
    }

    def edit() {
        def chainLinkReportingWireWeightInstance = ChainLinkReportingWireWeight.get(params.id)
        if (!chainLinkReportingWireWeightInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        [chainLinkReportingWireWeightInstance: chainLinkReportingWireWeightInstance]
    }

    def update() {
        def chainLinkReportingWireWeightInstance = ChainLinkReportingWireWeight.get(params.id)
        if (!chainLinkReportingWireWeightInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (chainLinkReportingWireWeightInstance.version > version) {
                chainLinkReportingWireWeightInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight')] as Object[],
                          "Another user has updated this ChainLinkReportingWireWeight while you were editing")
                render(view: "edit", model: [chainLinkReportingWireWeightInstance: chainLinkReportingWireWeightInstance])
                return
            }
        }

        chainLinkReportingWireWeightInstance.properties = params

        if (!chainLinkReportingWireWeightInstance.save(flush: true)) {
            render(view: "edit", model: [chainLinkReportingWireWeightInstance: chainLinkReportingWireWeightInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight'), chainLinkReportingWireWeightInstance.id])
        redirect(action: "show", id: chainLinkReportingWireWeightInstance.id)
    }

    def delete() {
        def chainLinkReportingWireWeightInstance = ChainLinkReportingWireWeight.get(params.id)
        if (!chainLinkReportingWireWeightInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        try {
            chainLinkReportingWireWeightInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'chainLinkReportingWireWeight.label', default: 'ChainLinkReportingWireWeight'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
