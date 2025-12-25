package com.chakra.config

class SideMesh {

    String holeSize
        BigDecimal wireDiameter
        BigDecimal weight
        String description

    static constraints = {
                
                holeSize(blank:false,nullable:false)
                wireDiameter(blank:false,nullable:false)
                weight(blank:false,nullable:false)
                description(maxLength:500,blank:true,nullable:true)
    }
        
        String toString() {"${this.holeSize} - WireDiameter ${this.wireDiameter}"}
}
