package com.chakra.stock

import com.chakra.order.Corder;
import com.chakra.security.User;

class CageStockOrder {

    def springSecurityService
	
	Corder corder
	CageStock cageStock
	BigDecimal cageStockForOrder
	Date cageStockOrderBlockTime
	String comments
	
	User createdBy
	Date createdDate
	
	User lastEditedBy
	Date lastEditedDate
	
	static belongsTo = [CageStock]
	
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
		return "CageStockOrder [corder=" + corder.id + ", cageStock=" + cageStock.id+ ", cageStockForOrder=" + cageStockForOrder + "]";
	}
}
