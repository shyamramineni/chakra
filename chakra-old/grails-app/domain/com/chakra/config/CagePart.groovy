package com.chakra.config

class CagePart {
	
	String cagePart
	String cagePartCode
	byte[] cagePartImage
	byte[] cagePartThumbnail
	String description
	
	CagePart parentCagePart
	String formula

    static constraints = {
		cagePart(blank:false,nullable:false)
		cagePartCode(blank:true,nullable:true)
		cagePartImage(size:0..2000000,blank:true,nullable:true)
		cagePartThumbnail(size:0..1000000,blank:true,nullable:true)
		description(maxLength:500,blank:true,nullable:true)
		parentCagePart(nullable:true)
		formula(nullable:true)
    }
	
	String toString() {"${this.cagePart}"}
}
