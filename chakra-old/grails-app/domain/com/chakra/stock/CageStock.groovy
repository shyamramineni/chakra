package com.chakra.stock

import java.util.List;

import com.chakra.config.CagePart
import com.chakra.security.User

class CageStock {

	def springSecurityService
	
	CagePart cagePart		
	
	BigDecimal noOfPurchased
	BigDecimal noOfInStock = 0.0
	Date purchasedTime
	String cageStockId
	Boolean availabilityStatus
	String comments
	
	User createdBy
	Date createdDate
	
	User lastEditedBy
	Date lastEditedDate
	
	List cageStockOrderItems
	
	static hasMany = [cageStockOrderItems: CageStockOrder]
	

	static constraints = {
		
		noOfPurchased(blank:false)
		noOfInStock(blank:false)
		cagePart(blank:false)
		comments(maxLength:500,blank:true,nullable:true)
		cageStockId(blank:true,nullable:true)
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		lastEditedDate(blank:true,nullable:true)
	}
	
	def beforeUpdate = {
		
		lastEditedBy = springSecurityService.currentUser
		lastEditedDate = new Date()
		
	}
	
	def beforeInsert = {
		
		//println "before insert"
		noOfInStock = noOfPurchased
		availabilityStatus = true
		createdBy = springSecurityService.currentUser
		createdDate = new Date()
		cageStockId = 'CS'+new Date().format("ddMMyyhhmm")
		
	}
	
	
	@Override
	public String toString() {
		return "CageStock [cagePart=" + cagePart
				+ ",  noOfPurchased=" + noOfPurchased
				+ ", noOfInStock=" + noOfInStock
				+ ", purchasedTime=" + purchasedTime
				+ ", cageStockId=" + cageStockId 
				+ ", availabilityStatus=" + availabilityStatus + "]";
	}
}
