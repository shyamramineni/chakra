package com.chakra.production

import java.util.Date;

import com.chakra.config.WireBrand;
import com.chakra.rawmaterial.WireReceiptReporting;

class WeldSideMeshReportingWireWeight {

    WireBrand wireBrand
	BigDecimal diameter
	BigDecimal weight
	Date wireConsumptionDate
		
	WeldSideMeshReporting weldSideMeshReporting
	WireReceiptReporting wireReceiptReporting
	
    static constraints = {
		
		weldSideMeshReporting(nullable:false)
		wireReceiptReporting(nullable:false)
    }
}
