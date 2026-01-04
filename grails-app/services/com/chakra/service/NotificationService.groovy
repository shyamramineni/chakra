package com.chakra.service

import java.util.Date;
import com.chakra.notifications.Notification

class NotificationService {
	
		
	def addNotification(String users, String notifMsg, Boolean notifDisplay, String notifUrl, String notifType) {
		
			
		def notificationInstance = new Notification()
						
		notificationInstance.userName = users
		notificationInstance.notifMsg = notifMsg
		notificationInstance.notifDisplay = notifDisplay
		notificationInstance.notifUrl = notifUrl
		notificationInstance.notifType = notifType
		notificationInstance.createdDate = new Date()
						
		if (!notificationInstance.save(flush: true)) {
			notificationInstance.errors.each {
				log.error it
			}
		}
			
	}
	
	def addSmsNotification(String users, String notifMsg, Boolean notifDisplay, String notifType, String phoneNumber) {
		
			
		def notificationInstance = new Notification()
						
		notificationInstance.userName = users
		notificationInstance.notifMsg = notifMsg
		notificationInstance.notifDisplay = notifDisplay
		notificationInstance.notifType = notifType
		notificationInstance.createdDate = new Date()
		notificationInstance.phoneNumber = phoneNumber
				
		if (!notificationInstance.save(flush: true)) {
			notificationInstance.errors.each {
				log.error it
			}
		}
	}	
		
}
