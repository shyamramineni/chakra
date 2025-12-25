package com.chakra.production

import java.util.Date;
import java.util.List;

import com.chakra.config.SideMesh;
import com.chakra.config.Machine;
import com.chakra.config.WireBrand;
import com.chakra.stock.WeldSideMeshStock;

class WeldSideMeshReporting {

    def springSecurityService
	
	Machine machine
	SideMesh sideMesh
	WireBrand wireBrand
	WeldSideMeshStock weldSideMeshStock
	
	BigDecimal totalQuantity
	Date stockManufacturedTime
	String comments
	
	String createdBy
	Date createdDate
	
	String lastEditedBy
	Date editedDate
	
	List weldSideMeshReportingWireWeightList
		
	static hasMany = [weldSideMeshReportingWireWeightList : WeldSideMeshReportingWireWeight]

	static constraints = {
	
		machine(blank:false)
		sideMesh(blank:false)
		wireBrand(blank:false)
		weldSideMeshStock(nullable:true)
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
