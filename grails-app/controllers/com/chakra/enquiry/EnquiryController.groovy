package com.chakra.enquiry

import com.chakra.customer.Customer
//import com.chakra.notifications.Notification
import com.chakra.security.*
//import com.chakra.service.NotificationService
import org.springframework.dao.DataIntegrityViolationException
//import grails.plugins.springsecurity.Secured
//import com.lucastex.grails.fileuploader.UFile

class EnquiryController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	//def springSecurityService
	
	//@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def index() {
		redirect(action: "list", params: params)
	}

	//@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def list() {		
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[enquiryInstanceList: Enquiry.list(params), enquiryInstanceTotal: Enquiry.count()]
	}
	
	//@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def create() {
		/*def enquiryInstance = new Enquiry()
		 enquiryInstance.properties = params
		 if(!enquiryInstance.customer) {
		 flash.message = "Customer is not set"
		 redirect(controller: "customer", action: "list")
		 }*/
		log.debug"params" +params
		[enquiryInstance: new Enquiry(params)]
	}

	/*def create() {
	 [enquiryInstance: new Enquiry(params)]
	 }*/

	//@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def save() {

		def enquiryInstance = new Enquiry(params)
		println 'enquiryInstance.cagePartTypeList'+enquiryInstance.cagePartTypeList
		println'params'+params
		println'CPL'+params.cagePartTypeList
		def cagePartTypeList = params.cagePartTypeList
		//NotificationService notificationService = new NotificationService()		
		// find all users with Role SALES
		// filter with cagePartType from enquiry

		// check the count of enquiries that sales person is handling...info is there enquiry table
		// assign to user hadling least no enquires
		if(!enquiryInstance.cagePartTypeList) {
			flash.message = "Select atleast one CagePart Type"
			render(view: "create", model: [enquiryInstance: enquiryInstance])
			return
		}
		
		/*
		def salesRole = Role.findByAuthority("ROLE_SALES")
		log.debug 'salesRole'+salesRole
		def usersList = UserRole.findAllByRole(salesRole)		
		log.debug 'usersList'+usersList
		List finalUserList = new ArrayList()
		usersList.each { userRole ->
			
			log.debug userRole
			User user = userRole.user
			println'userCagePartList'+user.cagePartTypeList
			//if (user.cagePartTypeList.containsAll(cagePartTypeList)) {
			if (user.cagePartTypeList.containsAll(enquiryInstance.cagePartTypeList)) {
				 finalUserList.add(user)
			 }
		
		}
		
		log.debug 'finalUserList'+finalUserList
		
		if(finalUserList.size() > 0) {
			log.debug 'In assignedList'
			
			def e = Enquiry.createCriteria()
			def salesAssignedList = e.list {
				'in'("assigned",finalUserList)
				eq("status","ASSIGNED")
				projections {
										
					groupProperty("assigned")
					rowCount("total")
					order("total", "asc")
				}
				
			}
			
			List assignedList = new ArrayList()
			salesAssignedList.each { assigned ->
				assignedList.add(User.findByUsername(assigned[0].toString()))	
			}
			
			log.debug 'assignedList'+assignedList
						
			if(finalUserList.size() > assignedList.size()) {
				log.debug 'Not all sales persons are allocated'
				
				if(finalUserList.removeAll(assignedList)) {
					log.debug 'in test1'
					log.debug'finalUserList' +finalUserList
					
					enquiryInstance.assigned = finalUserList.get(0)
					enquiryInstance.status = Enquiry.STATUS_ASSIGNED
				} else {
				
					enquiryInstance.assigned = finalUserList.get(0)
					enquiryInstance.status = Enquiry.STATUS_ASSIGNED
				
				}
				
				
			} else if(finalUserList.size() == assignedList.size()) {
					
					log.debug "All sales persons are allocated, so assign to least occupied person"	
					enquiryInstance.assigned = assignedList.get(0)
					enquiryInstance.status = Enquiry.STATUS_ASSIGNED

								
			} else {
			 
		    	log.debug "This code is not reachable"
			}
					
		} else {
		
			log.debug " No user found"
			
			enquiryInstance.assigned = null
			enquiryInstance.status = Enquiry.STATUS_NEW
			
		}
		*/
		
		// Fallback for missing user assignment logic
		//enquiryInstance.assigned = null
		//enquiryInstance.status = Enquiry.STATUS_NEW
				
		//enquiryInstance.comments = params.comments+" "+"Created By "+springSecurityService.currentUser.toString()+new Date().format("dd/MM/yy-hh:mm")+'<br>'
		enquiryInstance.comments = params.comments+" "+"Created By Admin "+new java.text.SimpleDateFormat("dd/MM/yy-hh:mm").format(new Date())+'<br>'
		
		if (!enquiryInstance.save(flush: true)) {
			render(view: "create", model: [enquiryInstance: enquiryInstance])
			return
		}

		log.debug'params' +params
		//def user = User.findByUsername("admin")
		
		/*
		notificationService.addSmsNotification(user.toString(),"We have received your enquiry for "+enquiryInstance.cagePartTypeList+" , your enqiury id is "+enquiryInstance.enquiryId+" ." , true, Notification.NOTIFTYPE_SMS, enquiryInstance.customer.mobileNumber)
//		notificationService.addSmsNotification(user.toString(), "WE HAVE RECEIVED YOUR ENQUIRY FOR "+enquiryInstance.cagePartTypeList+", YOUR ENQUIRY ID IS "+enquiryInstance.enquiryId, true, Notification.NOTIFTYPE_SMS, enquiryInstance.customer.mobileNumber)
//		notificationService.addSmsNotification(user.toString(), "Received your Enquiry for "+enquiryInstance.enquiryId+" will be attended by "+enquiryInstance.assigned.toString(), true, Notification.NOTIFTYPE_SMS, enquiryInstance.customer.mobileNumber)
		
		if(enquiryInstance.assigned == null) {
			notificationService.addNotification(user.toString(), Notification.NOTIFMSG_ENQUIRY_UNASSIGNED +", CREATED BY "+enquiryInstance.createdBy, true, ""+g.link(action:"show", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
		} else {
		notificationService.addNotification(enquiryInstance.assigned.toString(), Notification.NOTIFMSG_ENQUIRY_ASSIGNED +", CREATED BY "+enquiryInstance.createdBy, true, ""+g.link(action:"userShow", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
		notificationService.addNotification(user.toString(), Notification.NOTIFMSG_ENQUIRY_ASSIGNED +", CREATED BY "+enquiryInstance.createdBy, true, ""+g.link(action:"show", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
		}
		*/
		//println g.link(action:"show", controller:"enquiry") { "text of the link here" }
		
		//String url = "<a href="+grailsApplication.serverUrl+"/enquiry/show/"+enquiryInstance.id+"/>"
				
		flash.message = message(code: 'default.created.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), enquiryInstance.id])
		redirect(action: "show", id: enquiryInstance.id)
	}

	//@Secured(['ROLE_ADMIN', 'ROLE_SALES', 'ROLE_PRODMANAGER'])
	def show() {
		def enquiryInstance = Enquiry.get(params.id)
		if (!enquiryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), params.id])
			redirect(action: "list")
			return
		}
		
		//println g.link(action:"show", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }
		// [enquiryInstance: enquiryInstance, files: UFile.list()]
		[enquiryInstance: enquiryInstance]
	}

	//@Secured(['ROLE_ADMIN'])
	def edit() {
		def enquiryInstance = Enquiry.get(params.id)
		if (!enquiryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), params.id])
			redirect(action: "list")
			return
		}

		[enquiryInstance: enquiryInstance]
	}

	//@Secured(['ROLE_ADMIN'])
	def update() {
		def enquiryInstance = Enquiry.get(params.id)
		if (!enquiryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (enquiryInstance.version > version) {
				enquiryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[message(code: 'enquiry.label', default: 'Enquiry')] as Object[],
						"Another user has updated this Enquiry while you were editing")
				render(view: "edit", model: [enquiryInstance: enquiryInstance])
				return
			}
		}

		enquiryInstance.properties = params
		
		//enquiryInstance.comments = enquiryInstance.comments+" "+"Edited By "+springSecurityService.currentUser.toString()+new Date().format("dd/MM/yy-hh:mm") +"<br>"
		enquiryInstance.comments = enquiryInstance.comments+" "+"Edited By Admin "+new java.text.SimpleDateFormat("dd/MM/yy-hh:mm").format(new Date()) +"<br>"

		if (!enquiryInstance.save(flush: true)) {
			
			render(view: "edit", model: [enquiryInstance: enquiryInstance])
			return
		}
		
		flash.message = message(code: 'default.updated.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), enquiryInstance.id])
		redirect(action: "show", id: enquiryInstance.id)
	}

	//@Secured(['ROLE_ADMIN'])
	def delete() {
		def enquiryInstance = Enquiry.get(params.id)
		if (!enquiryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), params.id])
			redirect(action: "list")
			return
		}

		try {
			enquiryInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), params.id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), params.id])
			redirect(action: "show", id: params.id)
		}
	}
	
	//@Secured(['ROLE_ADMIN'])
	def enquiryUserReport() {
				
		/*def usersList = User.findAll()
		println'usersList '+ usersList
		
		def assignedUsers = Enquiry.findAllByAssignedIsNotNull()
		println'assignedUsers '+assignedUsers.assigned*/
		
		def e = Enquiry.createCriteria()
		def noOfEnquiriesList = e.list {
			
			//isNotNull("assigned")
			projections {
				
				//groupProperty("assigned")
				rowCount("total")
				order("total","asc")				
			}
					
		}
		log.debug'noOfEnquiriesList' +noOfEnquiriesList
		
		[noOfEnquiriesList: noOfEnquiriesList, enquiryInstanceTotal: noOfEnquiriesList.size()]	
		
	}
	
	//@Secured(['ROLE_ADMIN'])
	def userEnquiries() {
		/*
		def userInstance = User.get(params.user)
		log.debug'userInstance' +userInstance
		def u = Enquiry.createCriteria()
		def noUserEnquiriesList = u.list {
			eq("assigned",userInstance)
		}
		
		log.debug'noUserEnquiriesList' +noUserEnquiriesList
		
		[noUserEnquiriesList: noUserEnquiriesList, enquiryInstanceTotal: noUserEnquiriesList.size()]
		*/
		[]
	}
	
	//@Secured(['ROLE_ADMIN'])
	def enquiryUnassigned() {
		
		/*
		def enquiryInstanceList = Enquiry.findAllByAssignedIsNull()
		log.debug'enquiryInstanceList' +enquiryInstanceList
		[enquiryInstanceList: enquiryInstanceList, enquiryInstanceTotal: enquiryInstanceList.size()]
		*/
		[]
	}
	
	//@Secured(['ROLE_ADMIN'])
	def editUser() {
		
		def enquiryInstance = Enquiry.get(params.id)
		
		/*def salesRole = Role.findByAuthority("ROLE_SALES")
		println'salesRole '+ salesRole
		def usersList = UserRole.findAllByRole(salesRole)
		println'users '+usersList.size()
		println'users '+usersList.findAll()
		def u = UserRole.createCriteria()
		def usersList = u.list {
			
			eq("role",salesRole)			
			
		}*/
				
		if (!enquiryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), params.id])
			redirect(action: "list")
			return
		}

		[enquiryInstance: enquiryInstance]
	}
	
	//@Secured(['ROLE_ADMIN'])
	def updateUser() {
		/*
		println'params '+params
		def enquiryInstance = Enquiry.get(params.id)
		def userInstance = User.get(params.assigned.id)
		println'userInstance '+userInstance
		NotificationService notificationService = new NotificationService()
		if (!enquiryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (enquiryInstance.version > version) {
				enquiryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[message(code: 'enquiry.label', default: 'Enquiry')] as Object[],
						"Another user has updated this Enquiry while you were editing")
				render(view: "edit", model: [enquiryInstance: enquiryInstance])
				return
			}
		}

		enquiryInstance.properties = params
		println userInstance
		enquiryInstance.assigned = userInstance
		enquiryInstance.status = Enquiry.STATUS_ASSIGNED
		notificationService.addNotification(enquiryInstance.assigned.toString(), Notification.NOTIFMSG_ENQUIRY_ASSIGNED, true, ""+g.link(action:"show", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
		notificationService.addNotification(springSecurityService.currentUser.toString(), Notification.NOTIFMSG_ENQUIRY_REASSIGNED, true, ""+g.link(action:"show", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)

		if (!enquiryInstance.save(flush: true)) {
			render(view: "editUser", model: [enquiryInstance: enquiryInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), enquiryInstance.id])
		
		redirect(action: "show", id: enquiryInstance.id)
		*/
	}
	
	//@Secured(['ROLE_SALES'])
	def enquiryBySales() {
		
		/*		
		User user = springSecurityService.currentUser
		log.debug user
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		List enquiryInstanceList = Enquiry.findAllByAssigned(user, [max: params.max, offset: params.offset])
		[enquiryInstanceList: enquiryInstanceList, enquiryInstanceTotal: enquiryInstanceList.size()]
		*/
		[]
	}
	
	def userShow() {
		def enquiryInstance = Enquiry.get(params.id)
		if (!enquiryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'enquiry.label', default: 'Enquiry'), params.id])
			redirect(action: "list")
			return
		}
		[enquiryInstance: enquiryInstance]
	}
	
	def reassignRequestEnquiries(){
		List reassignReqInstanceList = Enquiry.findAllByStatus("REQUEST REASSIGN")
		[reassignReqInstanceList: reassignReqInstanceList, reassignReqInstanceTotal: reassignReqInstanceList.size()]
		
	}
	
	def acceptEquiry() {
		/*
		println'params '+params
		def enquiryInstance = Enquiry.get(params.enquiry.id)
		def userInstance = User.get(params.assigned.id)
		def user = User.findByUsername("admin")
		println'user '+user
		NotificationService notificationService = new NotificationService()
		
		enquiryInstance.status = Enquiry.STATUS_ACCEPTED
		enquiryInstance.assigned = userInstance
		notificationService.addNotification(enquiryInstance.assigned.toString(), Notification.NOTIFMSG_ENQUIRY_ACCEPTED, true, ""+g.link(action:"userShow", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
		notificationService.addNotification(user.toString(), Notification.NOTIFMSG_ENQUIRY_ACCEPTED, true, ""+g.link(action:"show", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
		notificationService.addSmsNotification(user.toString(), "YOUR ENQUIRY WITH ID "+enquiryInstance.enquiryId+" FOR "+enquiryInstance.cagePartTypeList+" WILL BE ATTENDED BY "+enquiryInstance.assigned.toString()+" .", true, Notification.NOTIFTYPE_SMS, enquiryInstance.customer.mobileNumber)
		redirect(action: "userShow", id: enquiryInstance.id)
		*/
	}
	def requestReassign() {
		/*
		println 'params '+params
		def enquiryInstance = Enquiry.get(params.enquiry.id)
		def userInstance = User.get(params.assigned.id)
		//def user = User.findByUsername("admin")
		[enquiryInstance: enquiryInstance, userInstance: userInstance]
		*/
	}
	def requestReassignSubmit() {
		/*
		println'params '+params
		def enquiryInstance = Enquiry.get(params.enquiry)
		def userInstance = User.get(params.assigned)
		def reassignDesc = params.reassignReqDescription
		def user = User.findByUsername("admin")
		NotificationService notificationService = new NotificationService()
		enquiryInstance.status = Enquiry.STATUS_REQUEST_REASSIGN
		enquiryInstance.reassignReqDescription = reassignDesc
		notificationService.addNotification(userInstance.toString(), Notification.NOTIFMSG_ENQUIRY_REQUEST_REASSIGN, true, ""+g.link(action:"userShow", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
		notificationService.addNotification(user.toString(), Notification.NOTIFMSG_ENQUIRY_REQUEST_REASSIGN, true, ""+g.link(action:"show", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
		redirect(action: "userShow", id: enquiryInstance.id)
		*/		
	}
	
	def denyRequest() {
		/*
		println'params '+params
		def enquiryInstance = Enquiry.get(params.enquiry.id)
		def userInstance = User.get(params.assigned.id)
		def user = User.findByUsername("admin")
		NotificationService notificationService = new NotificationService()
		enquiryInstance.status = Enquiry.STATUS_ASSIGNED
		notificationService.addNotification(userInstance.toString(), Notification.NOTIFMSG_ENQUIRY_REQUEST_DENIED, true, ""+g.link(action:"userShow", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
		redirect(action: "show", id: enquiryInstance.id)
		*/
	}
	
	//@Secured(['ROLE_ADMIN'])
	def search() {

	}

	//@Secured(['ROLE_ADMIN'])
	def searchResults() {

		Customer customerInstance

		if(params.customerName || params.mobileNumber) {

			log.debug params.customerName
			log.debug params.mobileNumber

			def c = Customer.createCriteria()
			def customerInstanceList = c.list {
				if(params.customerName)
					eq('customerName', params.customerName)
				if(params.mobileNumber)
					eq('mobileNumber', params.mobileNumber)
			}

			if (customerInstanceList.size() == 0) {
				log.debug "customerInstanceList is null or zero"
				flash.message = "Cutomer not found"
				redirect(action: "search", params: params)
			} else if (customerInstanceList.size() > 1) {
				flash.message = "More than one Customer found"
				log.debug "params.enquiryDate "+params.enquiryDate
				redirect(action: "search", params: params)
			} else {
				customerInstance = customerInstanceList.get(0)
				log.debug "Final customerInstanceList.size() "+customerInstanceList.size()
			}

		}

		def e = Enquiry.createCriteria()
		def enquiryInstanceList = e.list {
			if(params.enquiryDate)
				le('createdDate', params.enquiryDate)
			if(customerInstance)
				eq("customer", customerInstance)
		}

		log.debug "Final enquiryInstanceList.size() "+enquiryInstanceList.size()

		[enquiryInstanceList: enquiryInstanceList, enquiryInstanceTotal: enquiryInstanceList.size()]

	}
		
	def manualQuotation() {
		def enquiryInstance = Enquiry.get(params.enquiry.id)
		[enquiryInstance: enquiryInstance]
	}
	
	def docUpload() {
		/*
		println'params '+params
		println'ufileId '+params.ufileId
		//def file = request.getFile("file")
		//println'file '+file
		def ufileid = params.ufileId.toBigDecimal()
		def enquiryInstance = Enquiry.get(params.id)
		enquiryInstance.status = Enquiry.STATUS_MANUAL_QUOTATION_GENERATED
		enquiryInstance.uploadFileId = 	ufileid	
		redirect(action: "show", id: enquiryInstance.id)
		*/
	}

}
