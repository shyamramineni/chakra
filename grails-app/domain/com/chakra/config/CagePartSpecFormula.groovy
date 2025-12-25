package com.chakra.config

class CagePartSpecFormula {
                
        CagePartSpecification cagePartSpecification
        CagePart cagePart
        String formula
        String description

    static constraints = {
                
                description(maxLength:500,blank:true,nullable:true)
    }
        
        String toString() {"${this.cagePart}"}
}
