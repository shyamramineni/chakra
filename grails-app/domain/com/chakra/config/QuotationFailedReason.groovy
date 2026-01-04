package com.chakra.config

class QuotationFailedReason {
	
	String quotationFailedReason
	String description

    static constraints = {
		quotationFailedReason(blank:false,nullable:false)
		description(maxLength:500,blank:true,nullable:true)
    }
	
	String toString() {"${this.quotationFailedReason}"}
}
