package com.chakra.production

import java.util.Date;

import com.chakra.config.CagePart
import com.chakra.stock.CageStock

class CagePartReporting {
	
	def springSecurityService
	
	CagePart cagePart
	CageStock cageStock
	
	BigDecimal totalQuantity
	Date stockPurchasedTime
	String comments
	
	String createdBy
	Date createdDate
	
	String lastEditedBy
	Date editedDate
	
	static constraints = {
	
		cagePart(blank:false)
		cageStock(nullable:true)
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		editedDate(blank:true,nullable:true)
		comments(maxLength:500,blank:true,nullable:true)
	}
	
	def beforeUpdate = {
		
		lastEditedBy = springSecurityService.currentUser
		editedDate = new Date()
		
	}
	
	def beforeInsert = {
		createdBy = springSecurityService.currentUser
		createdDate = new Date()
		
	}

    
}
