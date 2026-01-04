package com.chakra.quotation

import com.chakra.config.CagePartSpecification;
import java.util.List

class QuotationCagePartSpecification {
	
	List quotationCageParts
	
	CagePartSpecification cagePartSpecification
	BigDecimal cagePartSpecCost = 0.0
	BigDecimal costPerBird = 0.0
	
	static hasMany = [quotationCageParts: QuotationCagePart]
	static belongsTo = [QuotationCagePartModel]

    static constraints = {
		//cagePartSpecification(nullable:true)
		//cagePartSpecCost(5,nullable:true)
		//costPerBird(2,nullable:true)
		costPerBird(scale:2,nullable:true)
		cagePartSpecCost(scale:5,nullable:true)
		cagePartSpecification(scale:5,nullable:true)
    }
}
