package com.chakra.config

class CagePartType {
        
        String cagePartType
        String description
        
        static hasMany = [cagePartSpecifications:CagePartSpecification]

    static constraints = {
                
                description(maxLength:500,blank:true,nullable:true)
    }
        
        String toString() {"${this.cagePartType}"}      
}
