package com.chakra.quotation

import com.chakra.security.DummyUser
import com.chakra.config.QuotationFailedReason
import com.chakra.customer.Customer
import com.chakra.enquiry.Enquiry

class Quotation {
	
	private static final STATUS_NEW = "NEW"
	private static final STATUS_PENDING = "PENDING"
	private static final STATUS_REALIZED= "REALIZED"
	private static final STATUS_FAILED = "FAILED"
	private static final STATUS_EXPIRED = "EXPIRED"
	
	Customer customer
	Enquiry enquiry
	QuotationFailedReason quotationFailedReason
	
	List quotationModels
    
	BigDecimal cageLength
	BigDecimal fulls
	BigDecimal halfs
	BigDecimal tiers
	BigDecimal noOfCuttingsInShed
	BigDecimal noOfSheds
		
	DummyUser createdBy
	Date createdDate
	
	DummyUser lastEditedBy
	Date lastEditedDate
	
	String status
	String comments
	String quotationFailedComments
	
	String quotationId
	
	Boolean isMeshQuotation
	Boolean isCageQuotation
	Boolean isChainLinkQuotation
	Boolean isWeldSideMeshQuotation	
	
	static hasMany = [quotationModels:QuotationModel]
	static belongsTo = [customer:Customer]
	static constraints = {
		
		cageLength(min:1.0,blank:true,nullable:true)
		fulls(blank:true,nullable:true)
		halfs(blank:true,nullable:true)
		tiers(min:1.0,blank:true,nullable:true)
		noOfCuttingsInShed(blank:true,nullable:true)
		noOfSheds(min:1.0,blank:true,nullable:true)
		comments(maxLength:500,blank:true,nullable:true)
		quotationId(blank:true,nullable:true)
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		lastEditedDate(blank:true,nullable:true)
		status(blank:true,nullable:true)
		enquiry(blank:true,nullable:true)
		quotationFailedReason(blank:true,nullable:true)
		quotationFailedComments(maxLength:300,blank:true,nullable:true)
		isMeshQuotation(nullable:true)
		isCageQuotation(nullable:true)
		isChainLinkQuotation(nullable:true)
		isWeldSideMeshQuotation(nullable:true)
	}
	
	def beforeUpdate = {
		
		lastEditedBy = DummyUser.findByUsername('admin')
		lastEditedDate = new Date()
		
	}
	
	def beforeInsert = {
		status = STATUS_NEW
		createdBy = DummyUser.findByUsername('admin')
		if (!createdBy) {
			// Fallback if admin user doesn't exist, though typically it should.
			// Ideally we might create one or handle it, but for migration simple lookup is best.
		}
		createdDate = new Date()
		String user = createdBy ? createdBy.toString() : "ADMIN"
		user = user.toUpperCase()
		quotationId = user.substring(0, Math.min(2, user.length()))+"Q"+new Date().format("ddMMyyHHmm")
		
	}
	
	String toString() {
		"${this.quotationId}"
	}
    

}
