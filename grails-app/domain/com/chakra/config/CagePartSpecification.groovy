package com.chakra.config

class CagePartSpecification {
	
	
	String cagePartSpecification
	CagePartType cagePartType
	String description
	
	static hasMany = [cagePartSpecFormulaList: CagePartSpecFormula]
	static belongsTo = [cagePartType:CagePartType]
	
    static constraints = {
		description(maxLength:500,blank:true,nullable:true)
    }

	@Override
	public String toString() {
		return cagePartSpecification
	}
	
	
	
}
