package com.chakra.order

import com.chakra.config.LinkMesh;
import com.chakra.config.WireBrand;

class CorderChainLink {
	
	Corder corder
	LinkMesh linkMesh
	WireBrand wireBrand
	
	BigDecimal length
	BigDecimal height
	BigDecimal noOfPieces
	BigDecimal noOfBlocked = 0.0
	BigDecimal noOfShipped = 0.0
	BigDecimal squareFeets = 0.0
	BigDecimal pricePerSqFt = 0.0
	BigDecimal chainLinkItemCost = 0.0

    static constraints = {
		
		linkMesh(nullable:true)
		wireBrand(nullable:true)
		length(nullable:true)
		height(nullable:true)
		noOfPieces(nullable:true)
		noOfBlocked(nullable:true)
		noOfShipped(nullable:true)
		squareFeets(scale:5, nullable:true)
		pricePerSqFt(scale:5, nullable:true)
		chainLinkItemCost(scale:5, nullable:true)
    }
	
	String toString() {
		
		return "ChainLink -${linkMesh} -WireBrand -${wireBrand} -SquareFeets -${squareFeets}"
	}
	
}
