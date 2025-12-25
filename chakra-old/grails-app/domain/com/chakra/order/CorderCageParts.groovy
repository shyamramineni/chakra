package com.chakra.order

import java.util.Date;
import com.chakra.config.CagePartSpecFormula;

class CorderCageParts {
	
	Corder corder
	CagePartSpecFormula cagePartSpecFormula
	BigDecimal noOfCageParts
	BigDecimal noOfBlocked = 0.0
	BigDecimal noOfShipped = 0.0
	BigDecimal priceOfEachCagePart
	BigDecimal costOfCagePart
		
	static constraints = {
		
		cagePartSpecFormula(nullable:true)
		noOfCageParts(nullable:true)
		noOfBlocked(nullable:true)
		noOfShipped(nullable:true)
		priceOfEachCagePart(scale:5,nullable:true)
		costOfCagePart(scale:5,nullable:true)
				
	}
	
	String toString() {
		
		return "CagePart -${cagePartSpecFormula} -NoOfCageParts -${noOfCageParts}"
	}
		    
}
