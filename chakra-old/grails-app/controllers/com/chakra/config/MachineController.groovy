package com.chakra.config

import org.springframework.dao.DataIntegrityViolationException

import com.chakra.notifications.Notification
import com.chakra.security.User
import com.chakra.service.NotificationService

import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class MachineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [machineInstanceList: Machine.list(params), machineInstanceTotal: Machine.count()]
    }

    def create() {
        [machineInstance: new Machine(params)]
    }

    def save() {
        def machineInstance = new Machine(params)
		NotificationService notificationService = new NotificationService()
		def users = User.findByUsername("admin")
		log.debug users.username
        if (!machineInstance.save(flush: true)) {
            render(view: "create", model: [machineInstance: machineInstance])
            return
        }
		notificationService.addNotification(users.username, Notification.NOTIFMSG_NEW_MACHINE, true, ""+g.link(action:"list", controller:"machine", id: machineInstance.id) { machineInstance.machineName }, Notification.NOTIFTYPE_APP)

		flash.message = message(code: 'default.created.message', args: [message(code: 'machine.label', default: 'Machine'), machineInstance.id])
        redirect(action: "show", id: machineInstance.id)
    }

    def show() {
        def machineInstance = Machine.get(params.id)
        if (!machineInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])
            redirect(action: "list")
            return
        }

        [machineInstance: machineInstance]
    }

    def edit() {
        def machineInstance = Machine.get(params.id)
        if (!machineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])
            redirect(action: "list")
            return
        }

        [machineInstance: machineInstance]
    }

    def update() {
        def machineInstance = Machine.get(params.id)
        if (!machineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (machineInstance.version > version) {
                machineInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'machine.label', default: 'Machine')] as Object[],
                          "Another user has updated this Machine while you were editing")
                render(view: "edit", model: [machineInstance: machineInstance])
                return
            }
        }

        machineInstance.properties = params

        if (!machineInstance.save(flush: true)) {
            render(view: "edit", model: [machineInstance: machineInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'machine.label', default: 'Machine'), machineInstance.id])
        redirect(action: "show", id: machineInstance.id)
    }

    def delete() {
        def machineInstance = Machine.get(params.id)
        if (!machineInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])
            redirect(action: "list")
            return
        }

        try {
            machineInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
