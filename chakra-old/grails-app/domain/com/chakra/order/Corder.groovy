package com.chakra.order

import com.chakra.security.User

import java.util.List;

import com.chakra.config.CageDesign;
import com.chakra.config.Taxation;
import com.chakra.config.WireBrand;
import com.chakra.customer.Customer;
import com.chakra.quotation.Quotation;

class Corder {
	
	def springSecurityService
	
	private static final STATUS_NEW = "NEW"
	private static final STATUS_DUE = "DUE"
	private static final STATUS_CONFIRMED = "CONFIRMED"
	private static final STATUS_PENDING = "PENDING"
	private static final STATUS_ALLOCATED = "ALLOCATED"
	private static final STATUS_SHIPPED = "SHIPPED"
	
	List corderMeshParts
	List corderCageParts
	List corderPayments
	List corderChainLinkItems
	List corderWeldSideItems
	
	Quotation quotation
	Customer customer
	
	BigDecimal cageLength
	BigDecimal fulls
	BigDecimal halfs
	BigDecimal tiers
	BigDecimal noOfCuttingsInShed
	BigDecimal noOfSheds
	
	CageDesign cageDesign
	Taxation taxation
	BigDecimal noOfBirds
	BigDecimal cost
	BigDecimal tax
	BigDecimal costPerBird
	BigDecimal totalCost
	
	WireBrand wireBrand
	BigDecimal doubleBox
	BigDecimal singleBox
	
	BigDecimal meshCost = 0.0
	BigDecimal cagePartCost = 0.0
	BigDecimal chainLinkCost = 0.0
	BigDecimal weldSideCost = 0.0
	
	BigDecimal meshDiscount = 0.0
	BigDecimal meshDiscountPercent = 0.0
	BigDecimal netMeshCost = 0.0
	
	BigDecimal chainLinkDiscount = 0.0
	BigDecimal chainLinkDiscountPercent = 0.0
	BigDecimal netChainLinkCost = 0.0
	
	BigDecimal weldSideDiscount = 0.0
	BigDecimal weldSideDiscountPercent = 0.0
	BigDecimal netWeldSideCost = 0.0
			
	BigDecimal balance
	
	String status
	String paymentStatus
	String shippingStatus
	
	String comments
	
	Date deliveryDate
	Date paymentDueDate
	
	User createdBy
	Date createdDate
	
	User lastEditedBy
	Date lastEditedDate
	
	String orderId
	
	Boolean isMeshOrder
	Boolean isCageOrder
	Boolean isChainLinkOrder
	Boolean isWeldSideMeshOrder
	
	static hasMany = [corderMeshParts: CorderMeshParts, corderCageParts: CorderCageParts, corderPayments: CorderPayment, corderChainLinkItems: CorderChainLink, corderWeldSideItems: CorderWeldSide]
	
	static constraints = {
		
		createdBy(blank:true,nullable:true)
		createdDate(blank:true,nullable:true)
		lastEditedBy(blank:true,nullable:true)
		lastEditedDate(blank:true,nullable:true)
		cageLength(nullable:true)
		fulls(nullable:true)
		halfs(nullable:true)
		tiers(nullable:true)
		noOfCuttingsInShed(nullable:true)
		cageDesign(nullable:true)
		noOfBirds(nullable:true)
		noOfSheds(nullable:true)
		orderId(blank:true,nullable:true)
		comments(maxLength:500,blank:true,nullable:true)
		wireBrand(blank:true,nullable:true)
		doubleBox(scale:2,blank:true,nullable:true)
		singleBox(scale:2,blank:true,nullable:true)
		meshCost(scale:5,blank:true,nullable:true)
		cagePartCost(scale:5,blank:true,nullable:true)
		chainLinkCost(scale:5,blank:true,nullable:true)
		weldSideCost(scale:5,blank:true,nullable:true)
		balance(scale:5)
		isMeshOrder(nullable:true)
		isCageOrder(nullable:true)
		isChainLinkOrder(nullable:true)
		isWeldSideMeshOrder(nullable:true)
    
	}
	
	def beforeUpdate = {
		
		
		lastEditedBy = springSecurityService.currentUser
		lastEditedDate = new Date()
		
	}
	
	def beforeInsert = {
		createdBy = springSecurityService.currentUser
		shippingStatus = STATUS_NEW
		paymentStatus = STATUS_DUE
		createdDate = new Date()
		String user = springSecurityService.currentUser.toString()
		user = user.toUpperCase()
		orderId = user.substring(0, 2)+"O"+new Date().format("ddMMyyHHmm")
		
	}
}
