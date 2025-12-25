package com.chakra.stock

import java.util.Date;
import java.util.List;

import com.chakra.config.Machine;
import com.chakra.config.LinkMesh;
import com.chakra.config.WireBrand;
import com.chakra.security.User;

class ChainLinkStock {
	
	def springSecurityService
	
	Machine machine
	LinkMesh linkMesh
		
	WireBrand wireBrand
	BigDecimal noOfManufactured
	BigDecimal noOfInStock = 0.0
	Date stockManufacturedTime
	String chainLinkStockId
	Boolean availabilityStatus
	String comments
	
	User createdBy
	Date createdDate
	
	User lastEditedBy
	Date lastEditedDate
	
	List chainLinkStockOrderItems
	
	static hasMany = [chainLinkStockOrderItems: ChainLinkStockOrder]
	

	static constraints = {
		
		machine(blank:false)
		wireBrand(blank:false)
		noOfManufactured(blank:false)
		noOfInStock(blank:false)
		linkMesh(blank:false)
		//stockManufacturedTime(min:new Date())
		comments(maxLength:500,blank:true,nullable:true)
		chainLinkStockId(blank:true,nullable:true)
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
		availabilityStatus = true
		createdBy = springSecurityService.currentUser
		createdDate = new Date()
		chainLinkStockId = 'CLST'+new Date().format("ddMMyyhhmm")
		
	}
	
	
	@Override
	public String toString() {
		return "ChainLinkStock [machine=" + machine + ", linkMesh=" + linkMesh
				+ ", wireBrand=" + wireBrand + ", noOfManufactured="
				+ noOfManufactured + ", noOfInStock=" + noOfInStock
				+ ", stockManufacturedTime=" + stockManufacturedTime
				+ ", chainLinkStockId=" + chainLinkStockId + ", availabilityStatus="
				+ availabilityStatus + "]";
	}

}
