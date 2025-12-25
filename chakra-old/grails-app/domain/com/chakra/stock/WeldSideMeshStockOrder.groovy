package com.chakra.stock

import java.util.Date;

import com.chakra.order.Corder;
import com.chakra.security.User;

class WeldSideMeshStockOrder {

    def springSecurityService
	
	Corder corder
	WeldSideMeshStock weldSideMeshStock
	BigDecimal weldSideMeshStockForOrder
	Date weldSideMeshStockOrderBlockTime
	String comments
	
	User createdBy
	Date createdDate
	
	User lastEditedBy
	Date lastEditedDate
	
	static belongsTo = [WeldSideMeshStock]
	
	static constraints = {
		
		comments(maxLength:500,blank:true,nullable:true)
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
		createdBy = springSecurityService.currentUser
		createdDate = new Date()
		
	}
		

    @Override
	public String toString() {
		return "WeldSideMeshStockOrder [corder=" + corder.id + ", weldSideMeshStock=" + weldSideMeshStock.id+ ", weldSideMeshStockForOrder=" + weldSideMeshStockForOrder + "]";
	}
}
