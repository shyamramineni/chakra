package com.chakra.config

class WirePrice {
        
        WireBrand wireBrand
        BigDecimal wireDiameter
        BigDecimal price
        BigDecimal wirePriceTrending
        BigDecimal conversion
        BigDecimal wastage
        BigDecimal freightHandlingPerMetricTon
        BigDecimal wirePrice
        Date startDate
        Date endDate
        BigDecimal sheetSpecDiscount
        BigDecimal chainLinkDiscount
        BigDecimal weldSideMeshDiscount
        String description
        
        static belongsTo = [WireBrand]
        
    static constraints = {
                
                wireBrand(blank:false,nullable:false)
                wireDiameter(blank:false,nullable:false)
                price(blank:false,nullable:false)
                description(maxLength:500,blank:true,nullable:true)
                price(scale:5)
                wirePrice(scale:5)
                wastage(scale:5)
                sheetSpecDiscount(blank:true,nullable:true)
                chainLinkDiscount(blank:true,nullable:true)
                weldSideMeshDiscount(blank:true,nullable:true)
    }
}
