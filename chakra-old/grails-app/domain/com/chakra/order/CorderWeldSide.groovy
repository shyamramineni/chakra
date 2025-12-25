package com.chakra.order

import com.chakra.config.SideMesh;
import com.chakra.config.WireBrand;

class CorderWeldSide {
	
	Corder corder
	SideMesh sideMesh
	WireBrand wireBrand
	
	BigDecimal length
	BigDecimal height
	BigDecimal noOfPieces
	BigDecimal noOfBlocked = 0.0
	BigDecimal noOfShipped = 0.0
	BigDecimal squareFeets = 0.0
	BigDecimal pricePerSqFt = 0.0
	BigDecimal weldSideItemCost = 0.0

    static constraints = {
		
		sideMesh(nullable:true)
		wireBrand(nullable:true)
		length(nullable:true)
		height(nullable:true)
		noOfPieces(nullable:true)
		noOfBlocked(nullable:true)
		noOfShipped(nullable:true)
		squareFeets(scale:2, nullable:true)
		pricePerSqFt(scale:2, nullable:true)
		weldSideItemCost(scale:2, nullable:true)
    }
	
	String toString() {
		
		return "WeldSide -${sideMesh} -WireBrand -${wireBrand} -SquareFeets -${squareFeets}"
	}
}
