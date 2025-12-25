package com.chakra.config

class Machine {
        
        String machineName
        String description
        
        static constraints = {
                
                machineName(blank:false,nullable:false)
                description(maxLength:255,blank:true,nullable:true)
    }
        
        String toString() {"${this.machineName}"}
}
