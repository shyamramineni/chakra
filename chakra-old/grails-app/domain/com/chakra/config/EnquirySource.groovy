package com.chakra.config

class EnquirySource {
	
	String enquirySource
	String description

    static constraints = {
		enquirySource(maxLength:100,blank:false,nullable:false)
		description(maxLength:255,blank:true,nullable:true)
    }
	String toString() {"${this.enquirySource}"}
}
