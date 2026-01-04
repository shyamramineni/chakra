package com.chakra.stock

import java.util.Date
import com.chakra.order.Corder
import com.chakra.security.DummyUser

class ChainLinkStockOrder {

    Corder corder
    ChainLinkStock chainLinkStock
    BigDecimal chainLinkStockForOrder
    Date chainLinkStockOrderBlockTime
    String comments
    
    DummyUser createdBy
    Date createdDate
    
    DummyUser lastEditedBy
    Date lastEditedDate
    
    static belongsTo = [ChainLinkStock]
    
    static constraints = {
        comments(maxLength:500,blank:true,nullable:true)
        createdBy(blank:true,nullable:true)
        createdDate(blank:true,nullable:true)
        lastEditedBy(blank:true,nullable:true)
        lastEditedDate(blank:true,nullable:true)
    }
    
    def beforeUpdate = {
        lastEditedBy = new DummyUser(username:"system")
        lastEditedDate = new Date()
    }
    
    def beforeInsert = {
        createdBy = new DummyUser(username:"system")
        createdDate = new Date()
    }
        
    @Override
    public String toString() {
        return "ChainLinkStockOrder [corder=" + corder?.id + ", chainLinkStock=" + chainLinkStock?.id+ ", chainLinkStockForOrder=" + chainLinkStockForOrder + "]";
    }
}
