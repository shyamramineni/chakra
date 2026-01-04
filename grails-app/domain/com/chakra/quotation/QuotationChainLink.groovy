package com.chakra.quotation

import java.util.Date;

import com.chakra.config.LinkMesh;
import com.chakra.config.WireBrand;

class QuotationChainLink {
	
	LinkMesh linkMesh
	WireBrand wireBrand
	
	BigDecimal length
	BigDecimal height
	BigDecimal noOfPieces
	BigDecimal squareFeets
	BigDecimal pricePerSqFt
	BigDecimal chainLinkItemCost
	
	String createdBy
	Date createdDate
	
	String lastEditedBy
	Date editedDate
	
	static belongsTo = [QuotationChainLinkModel]
	

    static constraints = {
		linkMesh(blank:false)
		wireBrand(blank:false)
		length(balnk:false, nullable:false)
		height(balnk:false, nullable:false)
		noOfPieces(balnk:false, nullable:false)
		squareFeets(scale:5, nullable:false)
		pricePerSqFt(scale:5, nullable:false)
		chainLinkItemCost(scale:5, nullable:false)
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		editedDate(blank:true,nullable:true)
    }
	
	String toString() {"${this.linkMesh}"}
}
