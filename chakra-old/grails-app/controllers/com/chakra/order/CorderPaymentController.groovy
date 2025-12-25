package com.chakra.order

import org.springframework.dao.DataIntegrityViolationException
import com.chakra.notifications.Notification
import com.chakra.security.*
import com.chakra.service.NotificationService

class CorderPaymentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [corderPaymentInstanceList: CorderPayment.list(params), corderPaymentInstanceTotal: CorderPayment.count()]
    }

    def create() {
        [corderPaymentInstance: new CorderPayment(params)]
    }

    def save() {
        def corderPaymentInstance = new CorderPayment(params)
		NotificationService notificationService = new NotificationService()
        if (!corderPaymentInstance.save(flush: true)) {
            render(view: "create", model: [corderPaymentInstance: corderPaymentInstance])
            return
        }
		
		def corderInstance = Corder.get(corderPaymentInstance.corder.id)
		corderInstance.balance -= corderPaymentInstance.paymentAmount
		
		if(corderInstance.balance <= 0) {
			corderInstance.paymentStatus = Notification.NOTIFMSG_SMS_ORDER_PAYMENT_DONE
		}
		
		if (!corderInstance.save(flush: true)) {
			render(view: "create", model: [corderInstance: corderInstance])
			return
		}
		//notificationService.addSmsNotification(Notification.NOTIFMSG_SMS_ORDER_PAYMENT+corderPaymentInstance.paymentAmount+" OF ORDER ID"+corderInstance.orderId+" BALANCE TO BE PAID:Rs."+corderInstance.balance, true, Notification.NOTIFTYPE_SMS, corderInstance.customer.mobileNumber)
		notificationService.addSmsNotification(Notification.NOTIFMSG_SMS_ORDER_PAYMENT+corderPaymentInstance.paymentAmount+" IN OUR ACCOUNT, OF THE ORDER ID "+corderInstance.orderId+" OF VALUE "+corderInstance.totalCost+", BALANCE: Rs."+corderInstance.balance, true, Notification.NOTIFTYPE_SMS, corderInstance.customer.mobileNumber)
		notificationService.addNotification(corderPaymentInstance.corder.createdBy.username, Notification.NOTIFMSG_ORDER_PAYMENT, true, ""+g.link(action:"show", controller:"corder", id: corderPaymentInstance.corder.id) { corderPaymentInstance.corder.orderId }, Notification.NOTIFTYPE_APP)
		flash.message = message(code: 'default.created.message', args: [message(code: 'corderPayment.label', default: 'CorderPayment'), corderPaymentInstance.id])
        //redirect(action: "show", id: corderPaymentInstance.id)
		redirect(controller: "corder", action: "show", id: corderPaymentInstance.corder.id)
    }

    def show() {
        def corderPaymentInstance = CorderPayment.get(params.id)
        if (!corderPaymentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'corderPayment.label', default: 'CorderPayment'), params.id])
            redirect(action: "list")
            return
        }

        [corderPaymentInstance: corderPaymentInstance]
    }

    def edit() {
        def corderPaymentInstance = CorderPayment.get(params.id)
        if (!corderPaymentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'corderPayment.label', default: 'CorderPayment'), params.id])
            redirect(action: "list")
            return
        }

        [corderPaymentInstance: corderPaymentInstance]
    }

    def update() {
        def corderPaymentInstance = CorderPayment.get(params.id)
        if (!corderPaymentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'corderPayment.label', default: 'CorderPayment'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (corderPaymentInstance.version > version) {
                corderPaymentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'corderPayment.label', default: 'CorderPayment')] as Object[],
                          "Another user has updated this CorderPayment while you were editing")
                render(view: "edit", model: [corderPaymentInstance: corderPaymentInstance])
                return
            }
        }

        corderPaymentInstance.properties = params

        if (!corderPaymentInstance.save(flush: true)) {
            render(view: "edit", model: [corderPaymentInstance: corderPaymentInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'corderPayment.label', default: 'CorderPayment'), corderPaymentInstance.id])
        redirect(action: "show", id: corderPaymentInstance.id)
    }

    def delete() {
        def corderPaymentInstance = CorderPayment.get(params.id)
        if (!corderPaymentInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'corderPayment.label', default: 'CorderPayment'), params.id])
            redirect(action: "list")
            return
        }

        try {
            corderPaymentInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'corderPayment.label', default: 'CorderPayment'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'corderPayment.label', default: 'CorderPayment'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
