package com.chakra.quotation

import com.chakra.config.*

class QuotationModel {
	
	CageDesign cageDesign
	Taxation taxation
		
	QuotationMeshModel quotationMeshModel
	QuotationCagePartModel quotationCagePartModel
	QuotationChainLinkModel quotationChainLinkModel
	QuotationWeldSideModel quotationWeldSideModel
			
	BigDecimal noOfBirds
	BigDecimal cost
	BigDecimal tax
	BigDecimal costPerBird
	BigDecimal totalCost
	
	static hasMany = [quotationCageParts: QuotationCagePart]
	
	static belongsTo = [Quotation]
	
    static constraints = {
		
		cageDesign(blank:false,nullable:true)
		quotationMeshModel(nullable:true)
		quotationCagePartModel(nullable:true)
		quotationChainLinkModel(nullable:true)
		quotationWeldSideModel(nullable:true)
		noOfBirds(scale:2,nullable:true)
		cost(scale:5)
		tax(scale:5)
		costPerBird(scale:5,nullable:true)
		totalCost(scale:5)
		
    }
	
	String toString() {
		return "${cageDesign} - ${costPerBird} - ${noOfBirds} - ${tax} - ${totalCost}"
	}
}
