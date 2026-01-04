package com.chakra.production

import org.springframework.dao.DataIntegrityViolationException

class ProductionReportingWireWeightController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		
		def w = ProductionReportingWireWeight.createCriteria()
		def productionReportingWireWeightInstanceList = w.list {
			
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
		log.debug'productionReportingWireWeightInstanceList '+productionReportingWireWeightInstanceList
		//[productionReportingWireWeightInstanceList: ProductionReportingWireWeight.list(params), productionReportingWireWeightInstanceTotal: ProductionReportingWireWeight.count()]
        [productionReportingWireWeightInstanceList: productionReportingWireWeightInstanceList, productionReportingWireWeightInstanceTotal: productionReportingWireWeightInstanceList.size()]
    }

    def create() {
        [productionReportingWireWeightInstance: new ProductionReportingWireWeight(params)]
    }

    def save() {
        def productionReportingWireWeightInstance = new ProductionReportingWireWeight(params)
        if (!productionReportingWireWeightInstance.save(flush: true)) {
            render(view: "create", model: [productionReportingWireWeightInstance: productionReportingWireWeightInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), productionReportingWireWeightInstance.id])
        redirect(action: "show", id: productionReportingWireWeightInstance.id)
    }

    def show() {
        def productionReportingWireWeightInstance = ProductionReportingWireWeight.get(params.id)
        if (!productionReportingWireWeightInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        [productionReportingWireWeightInstance: productionReportingWireWeightInstance]
    }

    def edit() {
        def productionReportingWireWeightInstance = ProductionReportingWireWeight.get(params.id)
        if (!productionReportingWireWeightInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        [productionReportingWireWeightInstance: productionReportingWireWeightInstance]
    }

    def update() {
        def productionReportingWireWeightInstance = ProductionReportingWireWeight.get(params.id)
        if (!productionReportingWireWeightInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (productionReportingWireWeightInstance.version > version) {
                productionReportingWireWeightInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight')] as Object[],
                          "Another user has updated this ProductionReportingWireWeight while you were editing")
                render(view: "edit", model: [productionReportingWireWeightInstance: productionReportingWireWeightInstance])
                return
            }
        }

        productionReportingWireWeightInstance.properties = params

        if (!productionReportingWireWeightInstance.save(flush: true)) {
            render(view: "edit", model: [productionReportingWireWeightInstance: productionReportingWireWeightInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), productionReportingWireWeightInstance.id])
        redirect(action: "show", id: productionReportingWireWeightInstance.id)
    }

    def delete() {
        def productionReportingWireWeightInstance = ProductionReportingWireWeight.get(params.id)
        if (!productionReportingWireWeightInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        try {
            productionReportingWireWeightInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
