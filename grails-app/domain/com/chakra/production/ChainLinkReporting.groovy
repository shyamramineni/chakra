package com.chakra.production

import java.util.Date;
import java.util.List;

import com.chakra.config.Machine;
import com.chakra.config.LinkMesh;
import com.chakra.config.WireBrand;
import com.chakra.stock.ChainLinkStock;
import com.chakra.security.DummyUser

class ChainLinkReporting {
	
	Machine machine
	LinkMesh linkMesh
	WireBrand wireBrand
	ChainLinkStock chainLinkStock
	
	BigDecimal totalQuantity
	Date stockManufacturedTime
	String comments
	
	String createdBy
	Date createdDate
	
	String lastEditedBy
	Date editedDate
	
	List chainLinkReportingWireWeightList
		
	static hasMany = [chainLinkReportingWireWeightList : ChainLinkReportingWireWeight]

	static constraints = {
	
		machine(blank:false)
		linkMesh(blank:false)
		wireBrand(blank:false)
		chainLinkStock(nullable:true)
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
