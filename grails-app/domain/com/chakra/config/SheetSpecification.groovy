package com.chakra.config

class SheetSpecification {
        
        String sheetName
        
        BigDecimal projection
        BigDecimal width
        BigDecimal length
        BigDecimal pitch
        
        BigDecimal crossWireDiameter
        BigDecimal lineWireDiameter1
        BigDecimal lineWireDiameter2
        
        BigDecimal noOfLineWires1
        BigDecimal noOfLineWires2
        
        BigDecimal noOfCrossWires
        BigDecimal sheetWeight
                
        String description
        String sheetSpecId
        
        String textual
        String factoryPitch
                
        static constraints = {
                
                sheetName(blank:false,nullable:false)
                projection(blank:false,nullable:false)
                width(blank:false,nullable:false)
                length(blank:false,nullable:false)
                pitch(blank:false,nullable:false)
                crossWireDiameter(blank:false,nullable:false)
                lineWireDiameter1(blank:false,nullable:false)
                lineWireDiameter2(blank:false,nullable:false)
                noOfLineWires1(blank:false,nullable:false)
                noOfLineWires2(blank:false,nullable:false)
                description(maxLength:500,blank:true,nullable:true)
                textual(maxLength:255)
                factoryPitch(maxLength:255)
                sheetWeight(scale:5)
    }
        
        String toString() {"${this.sheetName} - Pitch ${this.pitch} - Width ${this.width} - Length ${this.length} - WireDiameter ${this.crossWireDiameter}"}
}
