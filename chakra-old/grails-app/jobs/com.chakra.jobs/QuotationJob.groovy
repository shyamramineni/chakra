package com.chakra.jobs

import com.chakra.notifications.Notification
import com.chakra.quotation.Quotation
import com.chakra.security.User
import com.chakra.service.NotificationService
import com.chakra.registry.Registry

class QuotationJob {
		
	static triggers = {
		   cron name:'quotationTrigger', startDelay:10000, cronExpression: "0 0 10 ? * *"
	   }
   
	   def execute() {
		   
		   //def grailsLinkGenerator
	
		   def quotationList = Quotation.findAllByStatus("NEW")
		   println'quotationList '+quotationList
		   
		   def registry = Registry.findAll()
		   def days = registry.entryValue[2]
		   println'days '+days
		   
		   def users = User.findByUsername("admin")
		   println'user '+ users.username
		   
		   NotificationService notificationService = new NotificationService()
		  
		   quotationList.each { quotation ->
			   Date now = new Date()
			   Date createdDate = quotation.createdDate
			   if(createdDate < (now.plus(-days))) {
				   def quotationInstance = Quotation.get(quotation.id)
				   quotationInstance.status = Quotation.STATUS_EXPIRED
				   println'status '+quotationInstance.status
				   if (!quotationInstance.save(flush: true)) {
					   quotationInstance.errors.each {
						   println it
					   }
					   
				   }
				   notificationService.addNotification(users.username, Notification.NOTIFMSG_QUOTATION_EXPIRED, true, ""+g.link(action:"show", controller:"quotation", id: quotationInstance.id) { quotationInstance.quotationId }, Notification.NOTIFTYPE_APP)
			   }
		   }
	}

}
