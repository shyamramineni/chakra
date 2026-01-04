package com.chakra.security

class DummyUser {
    String username
    
    static constraints = {
        username nullable: true
    }

    String toString() {
        return username
    }
}
