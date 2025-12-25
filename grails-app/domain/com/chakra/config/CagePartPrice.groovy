package com.chakra.config

class CagePartPrice {
        
        CagePart cagePart
        BigDecimal price
        String description
        Date startDate
        Date endDate
        
        static constraints = {
                
                description(maxLength:500,blank:true,nullable:true)
    }
}
