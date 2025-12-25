package com.chakra.production

import org.springframework.dao.DataIntegrityViolationException

class WeldSideMeshReportingWireWeightController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		
		def w = WeldSideMeshReportingWireWeight.createCriteria()
		def weldSideMeshReportingWireWeightInstanceList = w.list {
			
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
		println'weldSideMeshReportingWireWeightInstanceList '+weldSideMeshReportingWireWeightInstanceList
        //[weldSideMeshReportingWireWeightInstanceList: WeldSideMeshReportingWireWeight.list(params), weldSideMeshReportingWireWeightInstanceTotal: WeldSideMeshReportingWireWeight.count()]
		[weldSideMeshReportingWireWeightInstanceList: weldSideMeshReportingWireWeightInstanceList, weldSideMeshReportingWireWeightInstanceTotal: weldSideMeshReportingWireWeightInstanceList.size()]
    }

    def create() {
        [weldSideMeshReportingWireWeightInstance: new WeldSideMeshReportingWireWeight(params)]
    }

    def save() {
        def weldSideMeshReportingWireWeightInstance = new WeldSideMeshReportingWireWeight(params)
        if (!weldSideMeshReportingWireWeightInstance.save(flush: true)) {
            render(view: "create", model: [weldSideMeshReportingWireWeightInstance: weldSideMeshReportingWireWeightInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight'), weldSideMeshReportingWireWeightInstance.id])
        redirect(action: "show", id: weldSideMeshReportingWireWeightInstance.id)
    }

    def show() {
        def weldSideMeshReportingWireWeightInstance = WeldSideMeshReportingWireWeight.get(params.id)
        if (!weldSideMeshReportingWireWeightInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        [weldSideMeshReportingWireWeightInstance: weldSideMeshReportingWireWeightInstance]
    }

    def edit() {
        def weldSideMeshReportingWireWeightInstance = WeldSideMeshReportingWireWeight.get(params.id)
        if (!weldSideMeshReportingWireWeightInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        [weldSideMeshReportingWireWeightInstance: weldSideMeshReportingWireWeightInstance]
    }

    def update() {
        def weldSideMeshReportingWireWeightInstance = WeldSideMeshReportingWireWeight.get(params.id)
        if (!weldSideMeshReportingWireWeightInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (weldSideMeshReportingWireWeightInstance.version > version) {
                weldSideMeshReportingWireWeightInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight')] as Object[],
                          "Another user has updated this WeldSideMeshReportingWireWeight while you were editing")
                render(view: "edit", model: [weldSideMeshReportingWireWeightInstance: weldSideMeshReportingWireWeightInstance])
                return
            }
        }

        weldSideMeshReportingWireWeightInstance.properties = params

        if (!weldSideMeshReportingWireWeightInstance.save(flush: true)) {
            render(view: "edit", model: [weldSideMeshReportingWireWeightInstance: weldSideMeshReportingWireWeightInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight'), weldSideMeshReportingWireWeightInstance.id])
        redirect(action: "show", id: weldSideMeshReportingWireWeightInstance.id)
    }

    def delete() {
        def weldSideMeshReportingWireWeightInstance = WeldSideMeshReportingWireWeight.get(params.id)
        if (!weldSideMeshReportingWireWeightInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight'), params.id])
            redirect(action: "list")
            return
        }

        try {
            weldSideMeshReportingWireWeightInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'weldSideMeshReportingWireWeight.label', default: 'WeldSideMeshReportingWireWeight'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
