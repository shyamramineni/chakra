package com.chakra.notifications

import com.chakra.security.User

class Notification {
	
	private static final NOTIFTYPE_APP = "APP"
	private static final NOTIFTYPE_EMAIL = "EMAIL"
	private static final NOTIFTYPE_SMS = "SMS"
	
	private static final NOTIFMSG_ENQUIRY_UNASSIGNED = "ENQUIRY UNASSIGNED"
	private static final NOTIFMSG_ENQUIRY_ASSIGNED = "NEW ENQUIRY"
	private static final NOTIFMSG_ENQUIRY_REASSIGNED = "ENQUIRY ASSIGNED"
	private static final NOTIFMSG_ENQUIRY_ACCEPTED = "ENQUIRY ACCEPTED"
	private static final NOTIFMSG_ENQUIRY_REQUEST_REASSIGN = "REQUEST REASSIGN"
	private static final NOTIFMSG_ENQUIRY_REQUEST_DENIED = "REQUEST DENIED"
	private static final NOTIFMSG_QUOTATION_GENERATED = "QUOTATION GENERATED"
	private static final NOTIFMSG_QUOTATION_FAILED = "QUOTATION FAILED"
	private static final NOTIFMSG_REALIZED = "QUOTATION REALIZED"
	private static final NOTIFMSG_BLOCKSTOCK = "STOCK BLOCKED"
	private static final NOTIFMSG_ORDER_CREATED = "ORDER CREATED"
	private static final NOTIFMSG_ORDER_PAYMENT = "ORDER PAYMENT"
	private static final NOTIFMSG_ENQUIRY_PASTDUE = "ENQUIRY PASTDUE"
	private static final NOTIFMSG_QUOTATION_EXPIRED = "QUOTATION EXPIRED"
	private static final NOTIFMSG_QUOTATION_CANCELLED ="QUOTATION CANCELLED"
	private static final NOTIFMSG_PROD_WORNG_REPORT ="ORDER CANNOT UNBLOCK"
	
	private static final NOTIFMSG_SMS_ENQUIRY_RECEIVED = "RECEIVED ENQUIRY WILL BE ATTENDED BY"
	private static final NOTIFMSG_SMS_QUOTATION_CREATED = "QUOTATION CREATED FOR YOUR ENQUIRY WITH QUOTAITION ID"
	private static final NOTIFMSG_SMS_ORDER_CONFIRM = "THANK YOU FOR YOUR ORDER CONFIRMATION:"
	private static final NOTIFMSG_SMS_ORDER_PAYMENT = "RECIEVED Rs."
	private static final NOTIFMSG_SMS_ORDER_SHIPPED = "YOUR ORDER HAS BEEN SHIPPED"
	
	private static final NOTIFMSG_SMS_ORDER_PAYMENT_DONE = "PAYMENT DONE"
	
	private static final NOTIFMSG_NEW_CAGEDESIGN = "NEW CAGEDESIGN CREATED"
	private static final NOTIFMSG_UPDATE_CAGEDESIGN = "CAGEDESIGN UPDATED"
	private static final NOTIFMSG_DELETE_CAGEDESIGN = "CAGEDESIGN DELETED"
	
	private static final NOTIFMSG_NEW_CAGEDESIGN_SHEETSPEC = "NEW CAGEDESIGN SHEETSPEC CREATED"
	private static final NOTIFMSG_UPDATE_CAGEDESIGN_SHEETSPEC = "CAGEDESIGN SHEETSPEC UPDATED"
	private static final NOTIFMSG_DELETE_CAGEDESIGN_SHEETSPEC = "CAGEDESIGN SHEETSPEC DELETED"
	
	private static final NOTIFMSG_NEW_CAGEPART_PRICE = "NEW CAGEPART PRICE CREATED"
	private static final NOTIFMSG_UPDATE_CAGEPART_PRICE = "CAGEPART PRICE UPDATED"
	private static final NOTIFMSG_DELETE_CAGEPART_PRICE = "CAGEPART PRICE DELETED"
	
	private static final NOTIFMSG_NEW_CAGEPART_SPECFORM = "NEW CAGEPART SPECFORM CREATED"
	private static final NOTIFMSG_UPDATE_CAGEPART_SPECFORM = "CAGEPART SPECFORM UPDATED"
	private static final NOTIFMSG_DELETE_CAGEPART_SPECFORM = "CAGEPART SPECFORM DELETED"
	
	private static final NOTIFMSG_NEW_CAGEPART_SPEC = "NEW CAGEPART SPEC CREATED"
	private static final NOTIFMSG_UPDATE_CAGEPART_SPEC = "CAGEPART SPEC UPDATED"
	private static final NOTIFMSG_DELETE_CAGEPART_SPEC = "CAGEPART SPEC DELETED"
	
	private static final NOTIFMSG_NEW_CAGEPART_TYPE = "NEW CAGEPART TYPE CREATED"
	private static final NOTIFMSG_UPDATE_CAGEPART_TYPE = "CAGEPART TYPE UPDATED"
	private static final NOTIFMSG_DELETE_CAGEPART_TYPE = "CAGEPART TYPE DELETED"
	
	private static final NOTIFMSG_NEW_MACHINE = "NEW MACHINE CREATED"
	private static final NOTIFMSG_UPDATE_MACHINE = "MACHINE UPDATED"
	private static final NOTIFMSG_DELETE_MACHINE = "MACHINE DELETED"
	
	private static final NOTIFMSG_NEW_SHEETSPECIFICATION = "NEW SHEETSPECIFICATION CREATED"
	private static final NOTIFMSG_UPDATE_SHEETSPECIFICATION = "SHEETSPECIFICATION UPDATED"
	private static final NOTIFMSG_DELETE_SHEETSPECIFICATION = "SHEETSPECIFICATION DELETED"
	
	private static final NOTIFMSG_NEW_CAGEPART_REPORTING = "NEW CAGEPART REPORTED"
	private static final NOTIFMSG_NEW_CAGEPART = "NEW CAGEPART"
			
	String userName
	String notifMsg
	Boolean notifDisplay 
	String notifUrl
	String phoneNumber
	Date createdDate
	String notifType 
	String email
	String errorMessage 	

    static constraints = {
		
		userName(nullable:true)
		notifUrl(nullable:true)
		phoneNumber(blank:true,nullable:true)
		createdDate(timeStamp:true)
		email(blank:true,nullable:true)
		errorMessage(blank:true,nullable:true)
			
    }
}
