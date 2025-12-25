package com.chakra.jobs

import com.chakra.enquiry.Enquiry
import com.chakra.notifications.Notification
import com.chakra.security.User
import com.chakra.service.NotificationService
import com.chakra.registry.Registry

class EnquiryJob {
		
	static triggers = {
		   cron name:'enquiryTrigger', startDelay:10000, cronExpression: "0 0 10 ? * *"
	}
	
   	   def execute() {
	
		   def enquiryList = Enquiry.findAllByStatus("NEW")
		   println'enquiryList '+enquiryList
		   
		   def registry = Registry.findAll()
		   def days = registry.entryValue[1]
		   println'days '+days
		   
		   def users = User.findByUsername("admin")
		   println'user '+ users.username
		   
		   NotificationService notificationService = new NotificationService()
		   
		   enquiryList.each { enquiry ->
			   Date now = new Date()
			   Date createdDate = enquiry.createdDate
			   if(createdDate < (now.plus(-days))) {
				   def enquiryInstance = Enquiry.get(enquiry.id)
				   enquiryInstance.status = Enquiry.STATUS_PASTDUE
				   println'status '+enquiryInstance.status
				   if (!enquiryInstance.save(flush: true)) {
					   enquiryInstance.errors.each {
						   println it
					   }
					   
				   }
				   notificationService.addNotification(users.username, Notification.NOTIFMSG_ENQUIRY_PASTDUE, true, ""+g.link(action:"show", controller:"enquiry", id: enquiryInstance.id) { enquiryInstance.enquiryId }, Notification.NOTIFTYPE_APP)
			   }
		   }
	}

}
