package com.chakra.enquiry

import com.chakra.config.CagePartType
import com.chakra.config.EnquirySource
import com.chakra.customer.Customer
import com.chakra.security.User

class Enquiry {
	
	def springSecurityService
	
	private static final STATUS_NEW = "NEW"
	private static final STATUS_ASSIGNED = "ASSIGNED"
	private static final STATUS_PASTDUE = "PASTDUE"
	private static final STATUS_QUOTATION = "QUOTATION"
	private static final STATUS_REQUEST_REASSIGN = "REQUEST REASSIGN"
	private static final STATUS_ACCEPTED = "ACCEPTED"
	private static final STATUS_MANUAL_QUOTATION_GENERATED = "MANUAL QUOTATION"
	private static final STATUS_REALIZED = "REALIZED"
		
	Customer customer
	
	String enquiryId
	Date enquiryDate
	EnquirySource enquirySource
	String comments
	String reassignReqDescription 
		
	User assigned
	String status
	Long uploadFileId
	
	User createdBy
	Date createdDate
	
	User lastEditedBy
	Date lastEditedDate
	
	static belongsTo = [customer:Customer]
	static hasMany = [cagePartTypeList:CagePartType]
	static constraints = {
		
		//source(inList:['In Person', 'Telephone', 'Referral', 'Web'],blank:false)
		//enquiryDate(min:new Date())
		enquiryId(blank:true,nullable:true)
		assigned(blank:true,nullable:true)
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		lastEditedDate(blank:true,nullable:true)
		comments(maxLength:500,blank:true,nullable:true)
		reassignReqDescription(maxLength:1000,blank:true,nullable:true)
		uploadFileId(nullable:true)
	
    }
	
	def beforeUpdate = {
		
		lastEditedBy = springSecurityService.currentUser
		lastEditedDate = new Date()
		
	}
	
	def beforeInsert = {
		createdBy = springSecurityService.currentUser
		createdDate = new Date()
		String user = springSecurityService.currentUser.toString()
		user = user.toUpperCase()
		enquiryId = user.substring(0, 2)+"E"+new Date().format("ddMMyyHHmm")
		
	}
	
	String toString() {
		"${this.customer.customerName} - ${this.customer.companyName}"  
	}
		
}
