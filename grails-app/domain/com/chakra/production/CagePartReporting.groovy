package com.chakra.production

import java.util.Date;

import com.chakra.config.CagePart
import com.chakra.stock.CageStock
import com.chakra.security.DummyUser

class CagePartReporting {
	
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
		
		lastEditedBy = new DummyUser(username: 'dummy').toString()
		editedDate = new Date()
		
	}
	
	def beforeInsert = {
		createdBy = new DummyUser(username: 'dummy').toString()
		createdDate = new Date()
		
	}

    
}
