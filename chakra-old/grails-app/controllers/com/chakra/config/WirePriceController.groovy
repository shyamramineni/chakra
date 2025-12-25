package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

class WirePriceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [wirePriceInstanceList: WirePrice.list(params), wirePriceInstanceTotal: WirePrice.count()]
    }

    def create() {
        [wirePriceInstance: new WirePrice(params)]
    }

    def save() {
        def wirePriceInstance = new WirePrice(params)
		
		//wirePriceInstance.wastage = ((wirePriceInstance.wirePrice)*(wirePriceInstance.wastage/100))
		wirePriceInstance.price = (wirePriceInstance.wirePriceTrending + wirePriceInstance.conversion + (wirePriceInstance.wirePrice)*(wirePriceInstance.wastage/100) + wirePriceInstance.freightHandlingPerMetricTon + wirePriceInstance.wirePrice)
		log.debug wirePriceInstance.wastage
		log.debug wirePriceInstance.price

        if (!wirePriceInstance.save(flush: true)) {
            render(view: "create", model: [wirePriceInstance: wirePriceInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), wirePriceInstance.id])
        redirect(action: "show", id: wirePriceInstance.id)
    }

    def show() {
        def wirePriceInstance = WirePrice.get(params.id)
        if (!wirePriceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), params.id])
            redirect(action: "list")
            return
        }

        [wirePriceInstance: wirePriceInstance]
    }

    def edit() {
        def wirePriceInstance = WirePrice.get(params.id)
        if (!wirePriceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), params.id])
            redirect(action: "list")
            return
        }

        [wirePriceInstance: wirePriceInstance]
    }

    def update() {
        def wirePriceInstance = WirePrice.get(params.id)
        if (!wirePriceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (wirePriceInstance.version > version) {
                wirePriceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'wirePrice.label', default: 'WirePrice')] as Object[],
                          "Another user has updated this WirePrice while you were editing")
                render(view: "edit", model: [wirePriceInstance: wirePriceInstance])
                return
            }
        }

        wirePriceInstance.properties = params
		
		//wirePriceInstance.wastage = ((wirePriceInstance.wirePrice)*(wirePriceInstance.wastage/100))
		wirePriceInstance.price = (wirePriceInstance.wirePriceTrending + wirePriceInstance.conversion + (wirePriceInstance.wirePrice)*(wirePriceInstance.wastage/100) + wirePriceInstance.freightHandlingPerMetricTon + wirePriceInstance.wirePrice)
		log.debug wirePriceInstance.wastage
		log.debug wirePriceInstance.price

        if (!wirePriceInstance.save(flush: true)) {
            render(view: "edit", model: [wirePriceInstance: wirePriceInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), wirePriceInstance.id])
        redirect(action: "show", id: wirePriceInstance.id)
    }

    def delete() {
        def wirePriceInstance = WirePrice.get(params.id)
        if (!wirePriceInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), params.id])
            redirect(action: "list")
            return
        }

        try {
            wirePriceInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'wirePrice.label', default: 'WirePrice'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
