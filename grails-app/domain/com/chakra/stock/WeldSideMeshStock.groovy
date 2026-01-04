package com.chakra.stock

import java.util.Date
import java.util.List
import com.chakra.config.Machine
import com.chakra.config.SideMesh
import com.chakra.config.WireBrand
import com.chakra.security.DummyUser

class WeldSideMeshStock {

	Machine machine
	SideMesh sideMesh
		
	WireBrand wireBrand
	BigDecimal noOfManufactured
	BigDecimal noOfInStock = 0.0
	Date stockManufacturedTime
	String weldSideMeshStockId
	Boolean availabilityStatus
	String comments
	
	DummyUser createdBy
	Date createdDate
	
	DummyUser lastEditedBy
	Date lastEditedDate
	
	List weldSideMeshStockOrderItems
	
	static hasMany = [weldSideMeshStockOrderItems: WeldSideMeshStockOrder]

	static constraints = {
		machine(blank:false)
		wireBrand(blank:false)
		noOfManufactured(blank:false)
		noOfInStock(blank:false)
		sideMesh(blank:false)
		//stockManufacturedTime(min:new Date())
		comments(maxLength:500,blank:true,nullable:true)
		weldSideMeshStockId(blank:true,nullable:true)
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
		weldSideMeshStockId = 'WSS'+new Date().format("ddMMyyhhmm")
	}
	
	@Override
	public String toString() {
		return "WeldSideMeshStock [machine=" + machine + ", sideMesh=" + sideMesh
				+ ", wireBrand=" + wireBrand + ", noOfManufactured="
				+ noOfManufactured + ", noOfInStock=" + noOfInStock
				+ ", stockManufacturedTime=" + stockManufacturedTime
				+ ", weldSideMeshkStockId=" + weldSideMeshStockId + ", availabilityStatus="
				+ availabilityStatus + "]";
	}
}
