package com.chakra.rawmaterial

import java.util.Date;

import com.chakra.config.WireBrand
import com.chakra.production.ProductionReportingWireWeight

class WireReceiptReporting {
	
	//def springSecurityService
		
	WireBrand wireBrand
	BigDecimal wireDiameter
	BigDecimal weightPurchased
	BigDecimal weightInStock
	
	Date purchaseDate
	Boolean availabilityStatus
	String comments
	
	String createdBy
	Date createdDate
	String lastEditedBy
	Date editedDate
	
	static hasMany = [productionReportingWireWeightList: ProductionReportingWireWeight]

    static constraints = {
		wireBrand(blank:false)
		wireDiameter(blank:false)
		weightInStock(blank:true,nullable:true)
		availabilityStatus(blank:true,nullable:true)
		comments(maxLength:500,blank:true,nullable:true)
		
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		editedDate(blank:true,nullable:true)
	}
	
	def beforeUpdate = {
		//lastEditedBy = springSecurityService.currentUser
		lastEditedBy = "UNKNOWN_USER"
		editedDate = new Date()
	}
	
	def beforeInsert = {
		
		weightInStock = weightPurchased
		availabilityStatus =  true
		//createdBy = springSecurityService.currentUser
		createdBy = "UNKNOWN_USER"
		createdDate = new Date()
	}
}
