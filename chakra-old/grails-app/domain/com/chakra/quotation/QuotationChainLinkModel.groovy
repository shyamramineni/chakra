package com.chakra.quotation

import java.util.List;

class QuotationChainLinkModel {
	
	BigDecimal chainLinkCost = 0.0 
	BigDecimal chainLinkDiscount = 0.0 
	BigDecimal chainLinkDiscountPercent = 0.0 
	BigDecimal netChainLinkCost = 0.0 
	BigDecimal chainLinkTax = 0.0
			
	BigDecimal addValue
	String	description
	
	List quotationChainLinkItems
	
	static belongsTo = [QuotationModel]
	static hasMany = [quotationChainLinkItems: QuotationChainLink]

    static constraints = {
		chainLinkCost(scale:5,nullable:true)
		chainLinkDiscount(scale:5,nullable:true)
		chainLinkDiscountPercent(scale:5,nullable:true)
		netChainLinkCost(scale:5,nullable:true)
		addValue(nullable:true)
		description(nullable:true)
		chainLinkTax(scale:5,nullable:true)
    }
}
