package com.chakra.registry

class Registry {
	
	String entryName
	Integer entryValue

    static constraints = {
		entryName(blank:false,nullable:false)
		entryValue(blank:false,nullable:false)
    }
}
