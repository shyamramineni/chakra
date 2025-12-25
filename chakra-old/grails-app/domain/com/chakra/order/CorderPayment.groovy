package com.chakra.order

import com.chakra.customer.Customer
import com.chakra.security.User

class CorderPayment {
	
	def springSecurityService	
	
	Corder corder
	Customer customer
	Date paymentDate
	BigDecimal paymentAmount
	String comments
	
	User createdBy
	Date createdDate
	
	User lastEditedBy
	Date lastEditedDate
	
	
	static belongsTo = [Corder] 
	
    static constraints = {
		
		//paymentDate(min:new Date())
		paymentAmount(scale:5)
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		lastEditedDate(blank:true,nullable:true)
		comments(maxLength:500,blank:true,nullable:true)
    }
	
	def beforeUpdate = {
		
		lastEditedBy = springSecurityService.currentUser
		lastEditedDate = new Date()
		
	}
	
	def beforeInsert = {
		createdBy = springSecurityService.currentUser
		createdDate = new Date()
				
	}
	
	String toString() {
		return "Order -${corder.id} -Customer -${customer} -Date -${paymentDate} -Amount -${paymentAmount}" 
	}
}
