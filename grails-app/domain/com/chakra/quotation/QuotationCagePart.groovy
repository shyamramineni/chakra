package com.chakra.quotation

import com.chakra.config.CagePartSpecFormula
import com.chakra.order.Corder;

class QuotationCagePart {
	
	CagePartSpecFormula cagePartSpecFormula
	BigDecimal noOfCageParts
	BigDecimal priceOfEachCagePart
	BigDecimal costOfCagePart
			
	static belongsTo = [quotationModel: QuotationModel]
	
    static constraints = {
		
		cagePartSpecFormula(nullable:true)
		noOfCageParts(scale:5,nullable:true)
		priceOfEachCagePart(nullable:true)
		costOfCagePart(scale:5,nullable:true)
				
    }
	
	String toString() {"${this.cagePartSpecFormula}"}
}
