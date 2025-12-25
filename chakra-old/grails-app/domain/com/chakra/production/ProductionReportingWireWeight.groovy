package com.chakra.production

import com.chakra.config.WireBrand
import com.chakra.rawmaterial.WireReceiptReporting

class ProductionReportingWireWeight {
	
	WireBrand wireBrand
	BigDecimal diameter
	BigDecimal weight
	Date wireConsumptionDate
	//String comments
	
	ProductionReporting productionReporting
	WireReceiptReporting wireReceiptReporting
	
    static constraints = {
		
		productionReporting(nullable:false)
		wireReceiptReporting(nullable:false)
    }
}
