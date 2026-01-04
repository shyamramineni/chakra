package com.chakra.production

import org.springframework.dao.DataIntegrityViolationException

import com.chakra.config.LinkMesh
import com.chakra.config.WireBrand

class ChainLinkReportingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def chainLinkService
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [chainLinkReportingInstanceList: ChainLinkReporting.list(params), chainLinkReportingInstanceTotal: ChainLinkReporting.count()]
    }

    def create() {
        [chainLinkReportingInstance: new ChainLinkReporting(params)]
    }

    def save() {
        
		def wireBrand = WireBrand.get(params.wireBrand.id)
		println'wireBrand '+wireBrand
		def linkMesh = LinkMesh.get(params.linkMesh.id)
		println'linkMesh '+linkMesh		
				
		def chainLinkReportingInstance = chainLinkService.chainLinkSave(params, wireBrand, linkMesh)
		if (!chainLinkReportingInstance) {
            render(view: "create", model: [chainLinkReportingInstance: chainLinkReportingInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting'), chainLinkReportingInstance.id])
        redirect(action: "show", id: chainLinkReportingInstance.id)
    }

    def show() {
        def chainLinkReportingInstance = ChainLinkReporting.get(params.id)
        if (!chainLinkReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting'), params.id])
            redirect(action: "list")
            return
        }

        [chainLinkReportingInstance: chainLinkReportingInstance]
    }

    def edit() {
        def chainLinkReportingInstance = ChainLinkReporting.get(params.id)
        if (!chainLinkReportingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting'), params.id])
            redirect(action: "list")
            return
        }

        [chainLinkReportingInstance: chainLinkReportingInstance]
    }

    def update() {
        def chainLinkReportingInstance = ChainLinkReporting.get(params.id)
        if (!chainLinkReportingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (chainLinkReportingInstance.version > version) {
                chainLinkReportingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting')] as Object[],
                          "Another user has updated this ChainLinkReporting while you were editing")
                render(view: "edit", model: [chainLinkReportingInstance: chainLinkReportingInstance])
                return
            }
        }

        chainLinkReportingInstance.properties = params

        if (!chainLinkReportingInstance.save(flush: true)) {
            render(view: "edit", model: [chainLinkReportingInstance: chainLinkReportingInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting'), chainLinkReportingInstance.id])
        redirect(action: "show", id: chainLinkReportingInstance.id)
    }

    def delete() {
        def chainLinkReportingInstance = ChainLinkReporting.get(params.id)
        if (!chainLinkReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting'), params.id])
            redirect(action: "list")
            return
        }

        try {
            chainLinkReportingInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'chainLinkReporting.label', default: 'ChainLinkReporting'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
