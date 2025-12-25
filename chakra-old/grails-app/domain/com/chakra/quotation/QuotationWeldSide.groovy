package com.chakra.quotation

import java.util.Date;

import com.chakra.config.SideMesh;
import com.chakra.config.WireBrand;

class QuotationWeldSide {
	
	
	def springSecurityService
	
	SideMesh sideMesh
	WireBrand wireBrand
	
	BigDecimal length
	BigDecimal height
	BigDecimal noOfPieces
	BigDecimal squareFeets
	BigDecimal pricePerSqFt
	BigDecimal weldSideItemCost = 0.0
	BigDecimal weldSideTax = 0.0
	
	String createdBy
	Date createdDate
	
	String lastEditedBy
	Date editedDate
	
	static belongsTo = [QuotationWeldSideModel]
	

	static constraints = {
		sideMesh(blank:false)
		wireBrand(blank:false)
		length(balnk:false, nullable:false)
		height(balnk:false, nullable:false)
		noOfPieces(balnk:false, nullable:false)
		squareFeets(scale:5, nullable:false)
		pricePerSqFt(scale:5, nullable:false)
		weldSideItemCost(scale:5, nullable:false)
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		editedDate(blank:true,nullable:true)
		weldSideTax(scale:5, nullable:true)
	}
	
	String toString() {"${this.sideMesh}"}
    

}
