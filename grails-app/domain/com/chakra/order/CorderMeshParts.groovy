package com.chakra.order

import com.chakra.config.*
import com.chakra.order.Corder

class CorderMeshParts {
	
	Corder corder
	SheetSpecification sheetSpecification
	WireBrand wireBrand
	BigDecimal noOfMeshParts
	BigDecimal noOfBlocked = 0.0
	BigDecimal noOfShipped = 0.0
	BigDecimal meshCost = 0.0
		
	static constraints = {
		
		sheetSpecification(nullable:true)
		wireBrand(nullable:true)
		noOfMeshParts(scale:5,nullable:true)
		noOfBlocked(nullable:true)
		noOfShipped(nullable:true)
		meshCost(scale:5,nullable:true)
		
    }
	
	String toString() {
		//return "Order -${corder.id} -SheetSpec -${sheetSpecification} -WireBrand -${wireBrand} -No -${noOfMeshParts}"
		return "SheetSpec -${sheetSpecification} -WireBrand -${wireBrand} -No -${noOfMeshParts}"
	}
}
