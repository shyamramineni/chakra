package com.chakra.production

import java.util.Date;

import com.chakra.config.Machine;
import com.chakra.config.SheetSpecification;
import com.chakra.config.WireBrand;
import com.chakra.stock.Stock

class ProductionReporting {
	
	def springSecurityService
	
	Machine machine
	SheetSpecification sheetSpecifcation
	WireBrand wireBrand
	Stock stock
	
	BigDecimal totalQuantity
	BigDecimal mending
	Date stockManufacturedTime
	String comments
	
	String createdBy
	Date createdDate
	
	String lastEditedBy
	Date editedDate
	
	List productionReportingWireWeightList
		
	static hasMany = [productionReportingWireWeightList : ProductionReportingWireWeight]

    static constraints = {
    
		//stockManufacturedTime(min:new Date())
		machine(blank:false)
		sheetSpecifcation(blank:false)
		wireBrand(blank:false)
		mending(blank:false)
		stock(nullable:true)
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
