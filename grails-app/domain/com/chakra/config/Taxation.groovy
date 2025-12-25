package com.chakra.config

class Taxation {
        
        String taxation
        BigDecimal percent
        String description

    static constraints = {
                taxation(maxLength:80,blank:false,nullable:false)
                percent(scale:5,blank:false,nullable:false)
                description(maxLength:500,blank:true,nullable:true)
    }
        
        String toString() {"${this.taxation}"}
}
