package com.chakra.quotation

import java.util.List;

import com.chakra.config.CageDesign;
import com.chakra.config.WireBrand;

class QuotationMeshModel {
	
	CageDesign cageDesign
	WireBrand wireBrand
	
	List quotationMeshParts
		
	BigDecimal doubleBox
	BigDecimal singleBox
	BigDecimal costPerBird
	BigDecimal noOfBirds
	BigDecimal meshCost = 0.0
	BigDecimal meshDiscount = 0.0 
	BigDecimal meshDiscountPercent = 0.0 
	BigDecimal netMeshCost = 0.0
	BigDecimal meshTax = 0.0
		
	BigDecimal addValue = 0.0
	String	description
	
	
	static belongsTo = [QuotationModel]
	static hasMany = [quotationMeshParts: QuotationMeshPart]

    static constraints = {
		
	cageDesign(nullable:true)
	wireBrand(nullable:true)
	doubleBox(scale:2,nullable:true)
	singleBox(scale:2,nullable:true)
	costPerBird(scale:5,nullable:true)
	noOfBirds(scale:5,nullable:true)
	meshCost(scale:5,nullable:true)
	meshDiscount(scale:5,nullable:true)
	meshDiscountPercent(scale:5,nullable:true)
	netMeshCost(scale:5,nullable:true)
	addValue(nullable:true)
	description(nullable:true)
	meshTax(scale:5,nullable:true)
	
    }
}
