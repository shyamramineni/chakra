package com.chakra.quotation

import java.util.List;

import com.chakra.config.CageDesign;

class QuotationCagePartModel {
	
	CageDesign cageDesign
	
	//List quotationCageParts
	List quotationCagePartSpecs
	
	BigDecimal costPerBird = 0.0
	BigDecimal noOfBirds = 0.0
	BigDecimal cagePartCost = 0.0
	BigDecimal cagePartTax = 0.0
	
	static belongsTo = [QuotationModel]
	static hasMany = [quotationCagePartSpecs: QuotationCagePartSpecification]

    static constraints = {
		
		cageDesign(nullable:true)
		costPerBird(scale:5,nullable:true)
		noOfBirds(scale:5,nullable:true)
		cagePartCost(scale:5,nullable:true)
		cagePartTax(scale:5,nullable:true)
    }
}
