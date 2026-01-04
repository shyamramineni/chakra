package com.chakra.production

import java.util.Date;

import com.chakra.config.WireBrand;
import com.chakra.rawmaterial.WireReceiptReporting;

class ChainLinkReportingWireWeight {

    WireBrand wireBrand
	BigDecimal diameter
	BigDecimal weight
	Date wireConsumptionDate
		
	ChainLinkReporting chainLinkReporting
	WireReceiptReporting wireReceiptReporting
	
    static constraints = {
		
		chainLinkReporting(nullable:false)
		wireReceiptReporting(nullable:false)
    }
}
