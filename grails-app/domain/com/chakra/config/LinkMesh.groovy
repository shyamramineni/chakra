package com.chakra.config

class LinkMesh {
	
	String holeSize
	BigDecimal wireDiameter
	BigDecimal weight
	String description

    static constraints = {
		
		holeSize(blank:false,nullable:false)
		wireDiameter(blank:false,nullable:false)
		weight(scale:5,blank:false,nullable:false)
		description(maxLength:500,blank:true,nullable:true)
    }
	
	String toString() {"${this.holeSize} - WireDiameter ${this.wireDiameter}"}
}
