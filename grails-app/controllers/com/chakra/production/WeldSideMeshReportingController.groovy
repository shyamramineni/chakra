package com.chakra.production

import org.springframework.dao.DataIntegrityViolationException

import com.chakra.config.SideMesh
import com.chakra.config.WireBrand

class WeldSideMeshReportingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def weldSideMeshService
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [weldSideMeshReportingInstanceList: WeldSideMeshReporting.list(params), weldSideMeshReportingInstanceTotal: WeldSideMeshReporting.count()]
    }

    def create() {
        [weldSideMeshReportingInstance: new WeldSideMeshReporting(params)]
    }

    def save() {
        def wireBrand = WireBrand.get(params.wireBrand.id)
		println'wireBrand '+wireBrand
		def sideMesh = SideMesh.get(params.sideMesh.id)
		println'sideMesh '+sideMesh
				
		def weldSideMeshReportingInstance = weldSideMeshService.weldSideMeshSave(params, wireBrand, sideMesh)
        if (!weldSideMeshReportingInstance) {
            render(view: "create", model: [weldSideMeshReportingInstance: weldSideMeshReportingInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting'), weldSideMeshReportingInstance.id])
        redirect(action: "show", id: weldSideMeshReportingInstance.id)
    }

    def show() {
        def weldSideMeshReportingInstance = WeldSideMeshReporting.get(params.id)
        if (!weldSideMeshReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting'), params.id])
            redirect(action: "list")
            return
        }

        [weldSideMeshReportingInstance: weldSideMeshReportingInstance]
    }

    def edit() {
        def weldSideMeshReportingInstance = WeldSideMeshReporting.get(params.id)
        if (!weldSideMeshReportingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting'), params.id])
            redirect(action: "list")
            return
        }

        [weldSideMeshReportingInstance: weldSideMeshReportingInstance]
    }

    def update() {
        def weldSideMeshReportingInstance = WeldSideMeshReporting.get(params.id)
        if (!weldSideMeshReportingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (weldSideMeshReportingInstance.version > version) {
                weldSideMeshReportingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting')] as Object[],
                          "Another user has updated this WeldSideMeshReporting while you were editing")
                render(view: "edit", model: [weldSideMeshReportingInstance: weldSideMeshReportingInstance])
                return
            }
        }

        weldSideMeshReportingInstance.properties = params

        if (!weldSideMeshReportingInstance.save(flush: true)) {
            render(view: "edit", model: [weldSideMeshReportingInstance: weldSideMeshReportingInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting'), weldSideMeshReportingInstance.id])
        redirect(action: "show", id: weldSideMeshReportingInstance.id)
    }

    def delete() {
        def weldSideMeshReportingInstance = WeldSideMeshReporting.get(params.id)
        if (!weldSideMeshReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting'), params.id])
            redirect(action: "list")
            return
        }

        try {
            weldSideMeshReportingInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'weldSideMeshReporting.label', default: 'WeldSideMeshReporting'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
