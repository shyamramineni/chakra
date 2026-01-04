package com.chakra.config

class CageDesign {

    String cageDesign
	BigDecimal sheetLength
	BigDecimal noOfBirdsPerCageSingleBox
	BigDecimal noOfBirdsPerCageDoubleBox
	BigDecimal noOfPartitionsPerSheetLength
	BigDecimal noOfSingleBottomsPerSheet
	BigDecimal bottomDepth
	BigDecimal topDepth
	BigDecimal cageHeight
	BigDecimal cageFront
	String description
	List childCageDesign
	
	String designType
	Boolean isCustom
	Boolean doubleBottomCentreIncluded
	
	static hasMany = [cageDesignSheetSpecFormula: CageDesignSheetSpecFormula, childCageDesign: CageDesign]
	static constraints = {
		
		cageDesign(blank:false,nullable:false)
		sheetLength(blank:false,nullable:false)
		noOfBirdsPerCageSingleBox(blank:false,nullable:false)
		noOfBirdsPerCageDoubleBox(blank:false,nullable:false)
		noOfPartitionsPerSheetLength(blank:false,nullable:false)
		noOfSingleBottomsPerSheet(blank:false,nullable:false)
		description(maxLength:500,blank:true,nullable:true)
		designType(inList:['Chick', 'Chick-Grower', 'Grower', 'Grower-Layer', 'Layer'],blank:false)
		isCustom(blank:true,nullable:true)
			
    }
	
	String toString() {"${this.cageDesign}"}
}
