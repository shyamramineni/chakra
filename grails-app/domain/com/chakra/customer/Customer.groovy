package com.chakra.customer

class Customer {
	
	String customerName
	String companyName
	String phoneNumber
	String mobileNumber
	String address
	String email
	String fax
	String comments
		
	String customerId
	
	static optionals = ["address","phoneNo","fax"]
    static constraints = {
		customerName(maxLength:30,blank:false)
		companyName(maxLength:50,blank:false)
		mobileNumber(maxLength:15,blank:false)
		address(maxLength:500,blank:false)
		phoneNumber(maxLength:15,blank:true,nullable:true)
		email(maxLength:30,email:true,blank:true,nullable:true)
		fax(maxLength:15,blank:true,nullable:true)
		customerId(blank:true,nullable:true)
		comments(maxLength:1000,blank:true,nullable:true)
		
    }
		
	def beforeInsert = {
		customerId = 'CUS'+new Date().format("ddMMyyHHmm")
	}
	
	String toString() {
		//"${this.customerName} - ${this.companyName}"
		this.customerName
	}
}
