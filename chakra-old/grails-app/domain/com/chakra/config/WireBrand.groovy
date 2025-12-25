package com.chakra.config

class WireBrand {
	
	String wireBrand
	String description
	
	static constraints = {
		
		wireBrand(maxLength:80,blank:false,nullable:false)
		description(maxLength:500,blank:true,nullable:true)
    }
	String toString() {"${this.wireBrand}"}
}
