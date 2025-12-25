package com.chakra.config

class CageDesignSheetSpecFormula {
	
	CageDesign cageDesign
	SheetSpecification sheetSpecification
	String formula
	String description
	
	static constraints = {
		
		sheetSpecification(blank:false,nullable:false)
		cageDesign(blank:false,nullable:false)
		formula(blank:false,nullable:false)
		description(maxLength:500,blank:true,nullable:true)
		
    }

	@Override
	public String toString() {
		return sheetSpecification.sheetName+" "+formula;
	}
	
	
	
	
}
