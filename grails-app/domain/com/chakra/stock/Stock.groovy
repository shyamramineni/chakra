package com.chakra.stock

import java.util.List
import com.chakra.production.ProductionReporting
import com.chakra.security.DummyUser
import com.chakra.config.Machine
import com.chakra.config.SheetSpecification
import com.chakra.config.WireBrand

class Stock {
	
	Machine machine
	SheetSpecification sheetSpec
		
	WireBrand wireBrand
	BigDecimal noOfManufactured
	BigDecimal noOfInStock = 0.0
	Date stockManufacturedTime
	String stockId
	Boolean availabilityStatus
	String comments
	
	DummyUser createdBy
	Date createdDate
	
	DummyUser lastEditedBy
	Date lastEditedDate
	
	List stockOrderItems
	
	static hasMany = [stockOrderItems: StockOrder]
	
	static constraints = {
		machine(blank:false)
		wireBrand(blank:false)
		noOfManufactured(blank:false)
		noOfInStock(blank:false)
		sheetSpec(blank:false)
		//stockManufacturedTime(min:new Date())
		comments(maxLength:500,blank:true,nullable:true)
		stockId(blank:true,nullable:true)
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		lastEditedDate(blank:true,nullable:true)
	}
	
	def beforeUpdate = {
		lastEditedBy = new DummyUser(username:"system")
		lastEditedDate = new Date()
	}
	
	def beforeInsert = {
		availabilityStatus = true
		createdBy = new DummyUser(username:"system")
		createdDate = new Date()
		stockId = 'ST'+new Date().format("ddMMyyhhmm")
	}
    
	@Override
	public String toString() {
		return "Stock [machine=" + machine + ", sheetSpec=" + sheetSpec
				+ ", wireBrand=" + wireBrand + ", noOfManufactured="
				+ noOfManufactured + ", noOfInStock=" + noOfInStock
				+ ", stockManufacturedTime=" + stockManufacturedTime
				+ ", stockId=" + stockId + ", availabilityStatus="
				+ availabilityStatus + "]";
	}
}
