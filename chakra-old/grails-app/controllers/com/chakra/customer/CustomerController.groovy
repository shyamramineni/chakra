package com.chakra.customer

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.springframework.dao.DataIntegrityViolationException


class CustomerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService

	@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def index() {
        redirect(action: "list", params: params)
    }

	@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def list() {
		
		log.debug'params' +params
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		//[customerInstanceList: Customer.list(params), customerInstanceTotal: Customer.count()]
		
		log.debug'customerName' +params.customerName
		
		def c = Customer.createCriteria()
		def customerInstanceList = c.list {
			log.debug'customerName' +params.customerName
			if(params.customerName)
				like('customerName', params.customerName+"%")
			if(params.companyName)
				like('companyName', params.companyName+"%")
			if(params.mobileNumber)
				like('mobileNumber', params.mobileNumber+"%")				
		}
		[customerInstanceList: customerInstanceList, customerInstanceTotal: customerInstanceList.size()]
		
    }

	@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def create() {
        [customerInstance: new Customer(params)]
    }

	@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def save() {
        def customerInstance = new Customer(params)
		customerInstance.comments = params.comments+"Created By "+springSecurityService.currentUser.toString()+new Date().format("dd/MM/yy-hh:mm")+"<br>"
		
        if (!customerInstance.save(flush: true)) {
            render(view: "create", model: [customerInstance: customerInstance])
            return
        }
		
		flash.message = message(code: 'default.created.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance.id])
        redirect(action: "show", id: customerInstance.id)
    }

	@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def show() {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])
            redirect(action: "list")
            return
        }

        [customerInstance: customerInstance]
    }

	@Secured(['ROLE_ADMIN'])
	def edit() {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])
            redirect(action: "list")
            return
        }

        [customerInstance: customerInstance]
    }

	@Secured(['ROLE_ADMIN'])
	def update() {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (customerInstance.version > version) {
                customerInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'customer.label', default: 'Customer')] as Object[],
                          "Another user has updated this Customer while you were editing")
                render(view: "edit", model: [customerInstance: customerInstance])
                return
            }
        }

        customerInstance.properties = params
		customerInstance.comments = customerInstance.comments+" "+"Edited By "+springSecurityService.currentUser.toString()+new Date().format("dd/MM/yy-hh:mm")+"</br>"
		log.debug customerInstance.comments

        if (!customerInstance.save(flush: true)) {
            render(view: "edit", model: [customerInstance: customerInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance.id])
        redirect(action: "show", id: customerInstance.id)
    }

	@Secured(['ROLE_ADMIN'])
	def delete() {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])
            redirect(action: "list")
            return
        }

        try {
            customerInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def search() {
		
	}
	
	def searchResults() {
		
		def c = Customer.createCriteria()
		def customerInstanceList = c.list {
			if(params.customerName)
				like('customerName', params.customerName+"%")
			if(params.companyName)
				like('companyName', params.companyName+"%")
			if(params.mobileNumber)
				like('mobileNumber', params.mobileNumber+"%")
				
		}
		[customerInstanceList: customerInstanceList, customerInstanceTotal: customerInstanceList.size()]
		
	}
	
	def searchCustomer() {
		
		def c = Customer.createCriteria()
		def customerInstanceList = c.list {
			log.debug'customerName' +params.customerName
			if(params.customerName)
				like('customerName', params.customerName+"%")
			if(params.companyName)
				like('companyName', params.companyName+"%")
			if(params.mobileNumber)
				like('mobileNumber', params.mobileNumber+"%")
				
		}
		[customerInstanceList: customerInstanceList, customerInstanceTotal: customerInstanceList.size()]
		
	}
	
	def customerPdf() {
		
		def customerInstance = Customer.get(params.id)
		def image = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/grails_logo.jpg"))
		//println'image'+image
		renderPdf(template: "customer", model: [customerInstance: customerInstance, imageBytes:image.bytes], filename: "customer.pdf")
	}
	
	/*def quotations() {
		
		println 'quotation()'
		def customerInstance = Customer.get(params.id)
		if(customerInstance) {
			render g:select(id: "quotation", name:"quotation.id", from:customerInstance.quotation, noSelection:['':'Select One...'], optionKey: "id")
		}
		render g:select(id: "quotation", name:"quotation.id",  from:[''])
			
					
	}*/
	
	def customerSearch() {
		println'params'+params
		def customerData = JSON.parse(params.requestData)
		println'customerData '+customerData
		
		def c = Customer.createCriteria()
		def customerList = c.list {
			println'customer '+customerData.custname
			if(customerData.custname)
				like('customerName', customerData.custname+"%") 				
			if(customerData.compname)
				like('companyName', customerData.compname)
			if(customerData.mobile)
				like('mobileNumber', customerData.mobile+"%")
				
		}
		
		//def customerList = Customer.findAllByCustomerNameLikeOrCompanyNameLikeOrMobileNumberLike("%"+customerData.custname+"%", customerData.compname+"%", customerData.mobile+"%")
		println'customerList '+customerList
		//List customerItems = new ArrayList()
		List responseData = new ArrayList()
		customerList.each { customer ->
			println'customerid'+ customer.id
			responseData.add(
				"id":customer.id,"custname":customer.customerName,"compname":customer.companyName,"email":customer.email,"mobile":customer.mobileNumber,"phoneno":customer.phoneNumber,"fax":customer.fax,"address":customer.address,"comments":customer.comments)
		
		}
		//def responseData = [customerList: customerItems]
		println'responseData '+responseData
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "MATCH" : "NOMATCH"
	
		]}
		return
	}
	
	def addCustomer() {
		println'param '+params
		def customerData = JSON.parse(params.requestData)
		println'customerData '+customerData
		def c = Customer.createCriteria()
		def customerList = c.list {
			//println'customerName' +params.custName
			if(customerData.custname)
				eq('customerName', customerData.custname)
			if(customerData.compname)
				eq('companyName', customerData.compname)
			if(customerData.mobile)
				eq('mobileNumber', customerData.mobile)
				
		}
		
//		def customerList = Customer.findAllByCustomerNameLikeOrCompanyNameLikeOrMobileNumberLike(customerData.custname, customerData.compname, customerData.mobile)
		println'customerList '+customerList
		
		if(customerList.size() > 0){
			List responseData = new ArrayList()
			customerList.each { customer ->
				println'customerid'+ customer.id
				responseData.add(
				"id":customer.id,"custname":customer.customerName,"compname":customer.companyName,"email":customer.email,"mobile":customer.mobileNumber,"phone":customer.phoneNumber,"fax":customer.fax,"address":customer.address,"comments":customer.comments)
		
			}
			//def responseData = [customerList: customerItems]
			println'responseData '+responseData
			render(contentType: 'text/json') {[
				'responseData': responseData,'responseCode': responseData ? "NOEXISTS" : "EXISTS"
			]}
			return
		} else {
			Customer customerInstance = new Customer(customerData)
			println'customer '+customerData.custname
			customerInstance.customerName = customerData.custname
			customerInstance.companyName = customerData.compname
			customerInstance.mobileNumber = customerData.mobile
			customerInstance.address = customerData.address
			customerInstance.email = customerData.email
			customerInstance.phoneNumber = customerData.phoneNo
			customerInstance.fax = customerData.fax
			customerInstance.comments = customerData.comments
			println'in else'
			if (!customerInstance.save(flush: true)) {
				customerInstance.errors.each {
					println it
				}
				return
			}
			def responseData = ["id":customerInstance.id,"custname":customerInstance.customerName,"compname":customerInstance.companyName,"email":customerInstance.email,"mobile":customerInstance.mobileNumber,"phone":customerInstance.phoneNumber,"fax":customerInstance.fax,"address":customerInstance.address,"comments":customerInstance.comments]
			println'responseData '+responseData
			render(contentType: 'text/json') {[
				'responseData': responseData,'responseCode': responseData ? "OK" : "INVALID"
			]}
		}
		
	}
	
	def customerFetch() {
		
		println'params '+params
		def customerData = JSON.parse(params.requestData)
		println'customerData '+customerData
		def customer = customerData.customerId.toBigDecimal()
		println'customer '+customer
		def customerInstance = Customer.get(customer)
		
		def responseData = ["id":customerInstance.id,"custname":customerInstance.customerName,"compname":customerInstance.companyName,"mobile":customerInstance.mobileNumber,"address":customerInstance.address]
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "OK" : "INVALID"
		]}
		
	}
}
