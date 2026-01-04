package com.chakra.quotation

import java.util.List;

class QuotationWeldSideModel {

    BigDecimal weldSideCost = 0.0
	BigDecimal weldSideDiscount = 0.0
	BigDecimal weldSideDiscountPercent = 0.0
	BigDecimal netWeldSideCost = 0.0
	BigDecimal weldSideTax = 0.0
	
	List quotationWeldSideItems
	
	static belongsTo = [QuotationModel]
	static hasMany = [quotationWeldSideItems: QuotationWeldSide]

    static constraints = {
		weldSideCost(scale:5,nullable:true)
		weldSideDiscount(scale:5,nullable:true)
		weldSideDiscountPercent(scale:5,nullable:true)
		netWeldSideCost(scale:5,nullable:true)
		weldSideTax(scale:5,nullable:true)
    }
}
