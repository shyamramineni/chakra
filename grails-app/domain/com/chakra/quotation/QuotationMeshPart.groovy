package com.chakra.quotation

import java.util.Date;

import com.chakra.config.SheetSpecification;
import com.chakra.config.WireBrand;

class QuotationMeshPart {
	
	SheetSpecification sheetSpecification
	WireBrand wireBrand
	BigDecimal noOfMeshParts
	BigDecimal meshCost
	
	String createdBy
	Date createdDate
	
	String lastEditedBy
	Date editedDate
	
	static belongsTo = [QuotationMeshModel]

    static constraints = {
		
		sheetSpecification(blank:false)
		wireBrand(blank:false)
		noOfMeshParts(scale:5,blank:true,nullable:true)
		meshCost(scale:5,blank:true,nullable:true)
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		editedDate(blank:true,nullable:true)		
    }
	
	String toString() {"${this.sheetSpecification}"} 
}
