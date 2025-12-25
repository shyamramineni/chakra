package com.chakra.order

import grails.plugins.springsecurity.Secured

import com.chakra.config.*
import com.chakra.notifications.Notification
import com.chakra.quotation.Quotation
import com.chakra.quotation.QuotationModel
import com.chakra.rawmaterial.WireReceiptReporting
import com.chakra.security.User
import com.chakra.service.NotificationService
import com.chakra.stock.CageStock
import com.chakra.stock.CageStockOrder
import com.chakra.stock.ChainLinkStock
import com.chakra.stock.ChainLinkStockOrder
import com.chakra.stock.Stock
import com.chakra.stock.StockOrder
import com.chakra.stock.WeldSideMeshStock
import com.chakra.stock.WeldSideMeshStockOrder
import com.chakra.registry.Registry

import org.springframework.dao.DataIntegrityViolationException

class CorderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService
	def corderService

	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def index() {
        redirect(action: "list", params: params)
    }

	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [corderInstanceList: Corder.list(params), corderInstanceList: Corder.findAllByShippingStatus(Corder.STATUS_NEW), corderInstanceTotal: Corder.count()]
    }
	
	@Secured(['ROLE_ADMIN', 'ROLE_PRODMANAGER'])
	def blockedOrders() {
		List corderInstanceList = Corder.findAllByShippingStatus(Corder.STATUS_ALLOCATED)
		[corderInstanceList: corderInstanceList, corderInstanceTotal: corderInstanceList.size()]
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_PRODMANAGER'])
	def shippedOrders() {
		List corderInstanceList = Corder.findAllByShippingStatus(Corder.STATUS_SHIPPED)
		[corderInstanceList: corderInstanceList, corderInstanceTotal: corderInstanceList.size()]
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
    def create() {
		
		log.debug "Corder create";
		
		def corderInstance = new Corder()
		
		/*corderInstance.properties = params
		if(!corderInstance.customer) {
			flash.message = "Customer is not set"
			redirect(controller: "customer", action: "list")
		} 
			*/	
		def quotationInstance = Quotation.get(params.quotation.id)
		def quotationModelInstance = QuotationModel.get(params.quotationModel.id)
		
		log.debug "quotationInstance "+quotationInstance.id
		log.debug "quotationModelInstance "+quotationModelInstance.id
		
		//def corderInstance = new Corder()
		
		def registry = Registry.findAll()
		def days = registry.entryValue[0]
		log.debug'days '+days
		Date now = new Date()
		Date deliveryDate = now.plus(days)
		
		log.debug'deliveryDate'+deliveryDate
		
		corderInstance.deliveryDate = deliveryDate
		corderInstance.customer = quotationInstance.customer
		corderInstance.quotation = quotationInstance
		corderInstance.status = Corder.STATUS_NEW
		corderInstance.cageDesign = quotationModelInstance.cageDesign
		corderInstance.wireBrand = quotationModelInstance?.quotationMeshModel?.wireBrand
						
		corderInstance.cageLength = quotationInstance.cageLength
		corderInstance.fulls = quotationInstance.fulls
		corderInstance.halfs = quotationInstance.halfs
		corderInstance.tiers = quotationInstance.tiers
		corderInstance.noOfCuttingsInShed = quotationInstance.noOfCuttingsInShed
		corderInstance.noOfSheds = quotationInstance.noOfSheds
		
		corderInstance.isMeshOrder = quotationInstance.isMeshQuotation
		corderInstance.isCageOrder = quotationInstance.isCageQuotation
		corderInstance.isChainLinkOrder = quotationInstance.isChainLinkQuotation
		corderInstance.isWeldSideMeshOrder = quotationInstance.isWeldSideMeshQuotation
								
		corderInstance.singleBox = quotationModelInstance?.quotationMeshModel?.singleBox
		corderInstance.doubleBox = quotationModelInstance?.quotationMeshModel?.doubleBox
		corderInstance.noOfBirds = quotationModelInstance.noOfBirds
		corderInstance.costPerBird = quotationModelInstance.costPerBird
		corderInstance.cost = quotationModelInstance.cost
		corderInstance.taxation = quotationModelInstance.taxation
		corderInstance.tax = quotationModelInstance.tax
		corderInstance.meshCost = quotationModelInstance?.quotationMeshModel?.meshCost
		corderInstance.cagePartCost = quotationModelInstance?.quotationCagePartModel?.cagePartCost
		corderInstance.chainLinkCost = quotationModelInstance?.quotationChainLinkModel?.chainLinkCost
		corderInstance.weldSideCost = quotationModelInstance?.quotationWeldSideModel?.weldSideCost
		corderInstance.totalCost = quotationModelInstance.totalCost
		
		corderInstance.corderMeshParts = quotationModelInstance?.quotationMeshModel?.quotationMeshParts
		corderInstance.corderCageParts = quotationModelInstance?.quotationCagePartModel?.quotationCageParts
		corderInstance.corderChainLinkItems = quotationModelInstance?.quotationChainLinkModel?.quotationChainLinkItems
		corderInstance.corderWeldSideItems = quotationModelInstance?.quotationWeldSideModel?.quotationWeldSideItems
		
		[corderInstance: corderInstance]
				
        //[corderInstance: new Corder(params)]
    }

	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def save() {
        
		//def corderInstance.properties = params
		NotificationService notificationService = new NotificationService()
		
		def corderInstance = new Corder(params)
		log.debug'params'+params
		log.debug'customer'+corderInstance.customer.id
		log.debug'quotation'+corderInstance.quotation.id
		def orderMeshPartsList = corderInstance.corderMeshParts
		def orderCagePartsList = corderInstance.corderCageParts
		def orderChainLinkList = corderInstance.corderChainLinkItems
		def orderWeldSideList = corderInstance.corderWeldSideItems
		def taxPercent = corderInstance.taxation.percent
		log.debug'orderMeshPartsList '+orderMeshPartsList
		log.debug'orderCagePartsList '+orderCagePartsList
		log.debug'orderChainLinkList '+orderChainLinkList
		log.debug'orderWeldSideList '+orderWeldSideList
		log.debug'taxation'+taxPercent
		
		BigDecimal meshCost = 0
		BigDecimal meshSheetCost = 0
		def sheetSpecDiscount = 0
		def totSheetSpecDiscount = 0
		def meshDiscountPercent = 0 
		
		log.debug'MeshList '+orderMeshPartsList?.noOfMeshParts
		if(orderMeshPartsList != null) {
			orderMeshPartsList.each { meshPart ->
				def wireBrandInstance = meshPart.wireBrand
				def noOfMeshPart = meshPart.noOfMeshParts
				//def meshPartWeight = meshPart.sheetSpecification.sheetWeight
				//println'meshPartWeight'+meshPartWeight
				//meshCost += (noOfMeshPart*meshPartWeight*meshPart.wirePrice)
				//println'meshCost'+meshCost
				
				BigDecimal noOfCrossWires = (meshPart.sheetSpecification.length/meshPart.sheetSpecification.pitch)+1
				BigDecimal crossWireLength = noOfCrossWires*(meshPart.sheetSpecification.width+(2*meshPart.sheetSpecification.projection))
				BigDecimal lineWireLength1 = (meshPart.sheetSpecification.length+meshPart.sheetSpecification.pitch)*meshPart.sheetSpecification.noOfLineWires1
				BigDecimal lineWireLength2 = (meshPart.sheetSpecification.length+meshPart.sheetSpecification.pitch)*meshPart.sheetSpecification.noOfLineWires2
				
				BigDecimal crossWireWeight = ((crossWireLength/6588)*(meshPart.sheetSpecification.crossWireDiameter*meshPart.sheetSpecification.crossWireDiameter))
				BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(meshPart.sheetSpecification.lineWireDiameter1*meshPart.sheetSpecification.lineWireDiameter1))
				BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(meshPart.sheetSpecification.lineWireDiameter2*meshPart.sheetSpecification.lineWireDiameter2))
								
				def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, meshPart.sheetSpecification.crossWireDiameter)
				def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, meshPart.sheetSpecification.lineWireDiameter1)
				def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, meshPart.sheetSpecification.lineWireDiameter2)
				
				if(meshPart.sheetSpecification.lineWireDiameter1 > 0 && meshPart.sheetSpecification.lineWireDiameter2 > 0) {
					
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)) * noOfMeshPart)
					log.debug'meshSheetCost '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshPart)*(crossWirePrice.sheetSpecDiscount/100)) +(((lineWireWeight2*lineWirePrice2.price)*noOfMeshPart)*(lineWirePrice2.sheetSpecDiscount/100))
				} else if(meshPart.sheetSpecification.lineWireDiameter1 > 0) {
				
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshPart)
					log.debug'meshSheetCost '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshPart) * (crossWirePrice.sheetSpecDiscount/100))
				} else {
				
				meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice2.price)) * noOfMeshPart)
				log.debug'meshSheetCost '+meshSheetCost
				}
				meshCost += meshSheetCost
				totSheetSpecDiscount += sheetSpecDiscount
			}
			log.debug'meshCost'+meshCost
			
			if(corderInstance?.quotation?.noOfSheds != null) {
				meshCost = (meshCost*corderInstance?.quotation?.noOfSheds)
				log.debug'Mesh cost: '+meshCost
			}
			
			meshDiscountPercent = ((totSheetSpecDiscount*100)/meshCost)
			
		}
		
		BigDecimal totalCagePartCost = 0
		if(orderCagePartsList != null) {
			orderCagePartsList.each { cagePart ->
				def noOfCagePart = cagePart.noOfCageParts
				def cagePartCost = cagePart.priceOfEachCagePart
				log.debug'noOfCagePart'+noOfCagePart
				log.debug'cagePartCost'+cagePartCost
				totalCagePartCost += (noOfCagePart*cagePartCost)
				log.debug'totalCagePartCost'+totalCagePartCost
							
			}
			if(corderInstance?.quotation?.noOfSheds != null) {
				totalCagePartCost = (totalCagePartCost*corderInstance?.quotation?.noOfSheds)
				log.debug'totalCagePartCost: '+totalCagePartCost
			}
			
		}
		
		BigDecimal chainLinkCost = 0
		BigDecimal chainLinkDiscount = 0
		def  chainLinkDiscountPercent = 0
		
		if(orderChainLinkList != null) {		
			orderChainLinkList.each { chainLink ->
				def squareFeets = chainLink.squareFeets
				def pricePerSqFt = chainLink.pricePerSqFt
				def wireBrand = chainLink.wireBrand
				def linkMesh = chainLink.linkMesh
				//def wireBrandInstance = WireBrand.get(wireBrand)
				//def linkMeshInstance = LinkMesh.get(linkMesh)
				def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrand, linkMesh.wireDiameter)
				chainLinkCost += (squareFeets*pricePerSqFt)
				log.debug'chainLinkCost '+chainLinkCost
				chainLinkDiscount += (wirePrice.chainLinkDiscount/100)*(squareFeets*pricePerSqFt)
			}
			
			chainLinkDiscountPercent = ((chainLinkDiscount*100)/chainLinkCost)
		}
		
		BigDecimal weldSideCost = 0
		BigDecimal weldSideDiscount = 0
		def weldSideDiscountPercent = 0
		
		if(orderWeldSideList != null) {
			orderWeldSideList.each { weldSide ->
				def squareFeets = weldSide.squareFeets
				def pricePerSqFt = weldSide.pricePerSqFt
				def wireBrand = weldSide.wireBrand
				def sideMesh = weldSide.sideMesh
				//def wireBrandInstance = WireBrand.get(wireBrand)
				//def sideMeshInstance = LinkMesh.get(linkMesh)
				def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrand, sideMesh.wireDiameter)
				weldSideCost += (squareFeets*pricePerSqFt)
				println'weldSideCost '+weldSideCost
				println'weldSideMeshDiscount'+wirePrice?.weldSideMeshDiscount
				weldSideDiscount += (wirePrice?.weldSideMeshDiscount/100)*(squareFeets*pricePerSqFt)
			}
			weldSideDiscountPercent = ((weldSideDiscount*100)/weldSideCost)
		}
		
		BigDecimal cost = (meshCost-totSheetSpecDiscount)+totalCagePartCost+(chainLinkCost-chainLinkDiscount)+(weldSideCost-weldSideDiscount)
		log.debug'cost '+cost
				
		def tax = ((taxPercent/100)*cost)
		log.debug'tax '+tax
		BigDecimal totalCost = cost+tax
		log.debug'totalCost '+totalCost
		
		BigDecimal costPerBird = 0
		if(((meshCost+totalCagePartCost) > 0) && (corderInstance?.noOfBirds)) {
			def tax_1 = ((taxPercent/100)*(meshCost+totalCagePartCost))
			costPerBird = ((meshCost+totalCagePartCost+tax_1)/(corderInstance?.noOfBirds))
		}
								
		corderInstance.isMeshOrder = corderInstance?.quotation?.isMeshQuotation
		corderInstance.isCageOrder = corderInstance?.quotation?.isCageQuotation
		corderInstance.isChainLinkOrder = corderInstance?.quotation?.isChainLinkQuotation
		corderInstance.isWeldSideMeshOrder = corderInstance?.quotation?.isWeldSideMeshQuotation
		
		corderInstance.status = Corder.STATUS_CONFIRMED
		corderInstance.paymentStatus = Corder.STATUS_PENDING
		corderInstance.shippingStatus = Corder.STATUS_PENDING

		corderInstance.cageLength = corderInstance.quotation?.cageLength
		corderInstance.fulls = corderInstance.quotation?.fulls
		corderInstance.halfs = corderInstance.quotation?.halfs
		corderInstance.tiers = corderInstance.quotation?.tiers
		corderInstance.noOfCuttingsInShed = corderInstance?.quotation?.noOfCuttingsInShed
		corderInstance.noOfSheds = corderInstance?.quotation?.noOfSheds
		corderInstance.costPerBird = costPerBird
		corderInstance.meshCost = meshCost
		corderInstance.cost = cost
		corderInstance.cagePartCost = totalCagePartCost
		corderInstance.chainLinkCost = chainLinkCost
		corderInstance.weldSideCost = weldSideCost
		corderInstance.meshDiscount = totSheetSpecDiscount
		corderInstance.meshDiscountPercent = meshDiscountPercent
		corderInstance.netMeshCost = (meshCost-totSheetSpecDiscount)
		corderInstance.chainLinkDiscount = chainLinkDiscount
		corderInstance.chainLinkDiscountPercent =  chainLinkDiscountPercent
		corderInstance.netChainLinkCost = (chainLinkCost-chainLinkDiscount)
		corderInstance.weldSideDiscount = weldSideDiscount
		corderInstance.weldSideDiscountPercent =  weldSideDiscountPercent
		corderInstance.netWeldSideCost = (weldSideCost-weldSideDiscount)
		corderInstance.tax = tax
		corderInstance.totalCost = totalCost
		corderInstance.balance = totalCost
				
        if (!corderInstance.save(flush: true)) {
			render(view: "create", model: [corderInstance: corderInstance])
			return
		 } else  {
			def quotationInstance = Quotation.get(corderInstance.quotation.id)
			quotationInstance.status = Quotation.STATUS_REALIZED
			quotationInstance.comments = corderInstance.orderId+" "+ new Date().format("dd/MM/yy-hh:mm")+"\n";
			corderInstance.comments = params.comments+" "+"Created By "+springSecurityService.currentUser.toString()+new Date().format("dd/MM/yy-hh:mm")+"</br>"
			if (!quotationInstance.save(flush: true))  {
				render(view: "create", model: [corderInstance: corderInstance])
				return
			}
			notificationService.addSmsNotification(springSecurityService.currentUser.toString(), Notification.NOTIFMSG_SMS_ORDER_CONFIRM+corderInstance.orderId+", DATE OF DELIVERY: "+corderInstance.deliveryDate.format("dd/MM/yyyy")+", BALANCE TO BE PAID Rs."+corderInstance.balance, true, Notification.NOTIFTYPE_SMS, corderInstance.customer.mobileNumber)
			notificationService.addNotification(springSecurityService.currentUser.toString(), Notification.NOTIFMSG_REALIZED, true, ""+g.link(action:"show", controller:"quotation", id: quotationInstance.id) { corderInstance.orderId+"-"+quotationInstance.quotationId }, Notification.NOTIFTYPE_APP)
			
		}
		if(corderInstance.quotation?.enquiry?.enquiryId != null) {
			notificationService.addNotification(springSecurityService.currentUser.toString(),Notification.NOTIFMSG_ORDER_CREATED, true, ""+g.link(action:"show", controller:"corder", id: corderInstance.id) { corderInstance.orderId+"-"+corderInstance.quotation.quotationId+"-"+corderInstance.quotation?.enquiry?.enquiryId }, Notification.NOTIFTYPE_APP)
		} else {
			notificationService.addNotification(springSecurityService.currentUser.toString(),Notification.NOTIFMSG_ORDER_CREATED, true, ""+g.link(action:"show", controller:"corder", id: corderInstance.id) { corderInstance.orderId+"-"+corderInstance.quotation.quotationId+"- From Planner" }, Notification.NOTIFTYPE_APP)
		}
		flash.message = message(code: 'default.created.message', args: [message(code: 'corder.label', default: 'Corder'), corderInstance.id])
        redirect(action: "show", id: corderInstance.id)
    }
	
	@Secured(['ROLE_ADMIN'])
	def blockStock() {
		
		def corder = Corder.get(params.id)
		boolean	stockAvailable
		String stockAvailableMsg =""
				
		stockAvailable = corderService.corderStockAvailable(corder, stockAvailableMsg)
		
		println 'stockAvailableMsg '+session.stockAvailableMsg
		println'corder '+corder
		println'stockAvailable '+stockAvailable
		if(!stockAvailable) {
			println"in If"
			//flash.message = ("Stock not available for "+corder.orderId+" order")
			flash.message = session.stockAvailableMsg
			session.stockAvailableMsg = null
			redirect(action: "show", id: corder.id)
			
		} else {
			
			corderService.corderBlockStock(corder)
			corder.shippingStatus = Corder.STATUS_ALLOCATED
			NotificationService notificationService = new NotificationService()
			notificationService.addNotification(springSecurityService.currentUser.toString(), Notification.NOTIFMSG_BLOCKSTOCK, true, ""+g.link(action:"show", controller:"corder", id: corder.id) { corder.orderId }, Notification.NOTIFTYPE_APP)
			flash.message = ("Stock blocked for "+corder.orderId+" order")
			redirect(action: "show", id: corder.id)
		
		}
		
	}

	def partLoad() {
		def corderInstance = Corder.get(params.id)
		def meshPartList = corderInstance.corderMeshParts
		println'meshPartList '+meshPartList
		def cagePartList = corderInstance.corderCageParts
		println'cagePartList '+cagePartList
		def chainLinkList = corderInstance.corderChainLinkItems
		println'chainLinkList '+chainLinkList
		def weldSideList = corderInstance.corderWeldSideItems
		println'weldSideList '+weldSideList
		def wireBrandInstance = corderInstance.wireBrand
		println'wireBrandInstance '+wireBrandInstance
		println corderInstance.isMeshOrder
		
		def strArray1
		def strArray2
		def strArray3
		def strArray4
		def noOfMeshPartsReq = [:]
		def noOfCagePartsReq = [:]
		def noOfChainLinksReq = [:]
		def noOfWeldSidesReq = [:]
		
		if(corderInstance.isMeshOrder) {
			meshPartList.each { meshPart ->
				def stock = Stock.findAllBySheetSpecAndWireBrandAndAvailabilityStatus(meshPart.sheetSpecification, wireBrandInstance, true)
				strArray1 = new ArrayList()
				strArray1[0] = meshPart.sheetSpecification
				strArray1[1] = meshPart.noOfMeshParts
				strArray1[2] = stock.noOfInStock[0]
				strArray1[3] = meshPart.noOfBlocked
				strArray1[4] = meshPart.noOfShipped
				def key = meshPart.sheetSpecification 
				noOfMeshPartsReq.put(key, strArray1)
				
			}
			println'noOfMeshPartsReq '+noOfMeshPartsReq
		}
		if(corderInstance.isCageOrder) {
			cagePartList.each { cagePart ->
				def cageStock = CageStock.findAllByCagePartSpecFormulaAndAvailabilityStatus(cagePart.cagePartSpecFormula, true)
				strArray2 = new ArrayList()
				strArray2[0] = cagePart.cagePartSpecFormula
				strArray2[1] = cagePart.noOfCageParts
				strArray2[2] = cageStock.noOfInStock[0]
				strArray2[3] = cagePart.noOfBlocked
				strArray2[4] = cagePart.noOfShipped
				def key = cagePart.cagePartSpecFormula
				noOfCagePartsReq.put(key, strArray2)
				
			}
		}
		if(corderInstance.isChainLinkOrder) {
			chainLinkList.each { chainLink ->
				def chainLinkStock = ChainLinkStock.findAllByLinkMeshAndWireBrandAndAvailabilityStatus(chainLink.linkMesh, wireBrandInstance, true)
				strArray3 = new ArrayList()
				strArray3[0] = chainLink.linkMesh
				strArray3[1] = chainLink.squareFeets
				strArray3[2] = chainLinkStock.noOfInStock[0]
				strArray3[3] = chainLink.noOfBlocked
				strArray3[4] = chainLink.noOfShipped
				def key = chainLink.linkMesh
				noOfChainLinksReq.put(key, strArray3)
				
			}
		}
		if(corderInstance.isWeldSideMeshOrder) {
			weldSideList.each { weldSide ->
				def weldSideStock = WeldSideMeshStock.findAllBySideMeshAndWireBrandAndAvailabilityStatus(weldSide.sideMesh, wireBrandInstance, true)
				strArray4 = new ArrayList()
				strArray4[0] = weldSide.sideMesh
				strArray4[1] = weldSide.squareFeets
				strArray4[2] = weldSideStock.noOfInStock[0]
				strArray4[3] = weldSide.noOfBlocked
				strArray4[4] = weldSide.noOfShipped
				def key = weldSide.sideMesh
				noOfWeldSidesReq.put(key, strArray4)
				
			}
		}
		
		
		[corderInstance: corderInstance, corderMeshPartInstanceList: noOfMeshPartsReq.values(), corderCagePartInstanceList: noOfCagePartsReq.values(), corderChainLinkInstanceList: noOfChainLinksReq.values(), corderWeldSideInstanceList: noOfWeldSidesReq.values()]
	}
	
	def partBlock() {
		
		
		println'params '+params
		def corderInstance = Corder.get(params.corder.id)
		println'corderInstance '+corderInstance
		//def wireBrandInstance = WireBrand.get(params.wireBrand.id)
		//println'wireBrandInstance '+wireBrandInstance
		def corderMeshPartInstance
		boolean stockAvailable = true
		String availabilityMesh
		
		def corderCagePartInstance
		boolean cageStockAvailable = true
		String availabilityCage
		
		def corderChainLinkInstance
		boolean chainLinkStockAvailable = true
		String availabilityChainLink
		
		def corderWeldSideInstance
		boolean weldSideStockAvailable = true
		String availabilityWeldSide

		for(int i=0; i<=10; i++) { 
			log.debug''+params.('meshParts['+i+']')			
			def temp = params.('meshParts['+i+']')
			log.debug'temp '+temp
			if(temp!=null && temp.('noOfBlockedParts')!=''){
				//println temp.('id')
				//println temp.('noOfBlockedParts')
				def corderMeshPart = temp.('id').toBigDecimal()
				log.debug'corderMeshPart '+corderMeshPart
				def sheetSpecInstance =SheetSpecification.get(corderMeshPart)
				corderMeshPartInstance = CorderMeshParts.findByCorderAndSheetSpecification(corderInstance,sheetSpecInstance)
				log.debug'corderMeshPartInstance '+corderMeshPartInstance
				//println'cageDesignSheetSpecFormulaInstance '+cageDesignSheetSpecFormulaInstance
				def noOfBlockedMeshParts = temp.('noOfBlockedParts')
				def stockForBlock = 0
				BigDecimal noOfMeshParts = temp.('noOfBlockedParts').toBigDecimal()
				def noOfMeshParts_1=noOfMeshParts
				def s = Stock.createCriteria()
				def stockList = s.list {
					eq("availabilityStatus", true)
					eq("sheetSpec", corderMeshPartInstance.sheetSpecification)
					eq("wireBrand", corderMeshPartInstance.wireBrand)
				
					projections {
						groupProperty("id")
						groupProperty("sheetSpec")
						groupProperty("wireBrand")
						sum("noOfInStock")							
						
					}
				}
				log.debug'stockList '+stockList				 
				
				stockList.each { stock ->
					log.debug'stock'+stock
					//println'stock'+stock.id
					def stockInstance = Stock.get(stock[0])
					log.debug'stockInstance '+stockInstance
					log.debug"noOfMeshParts "+noOfMeshParts
					if (noOfMeshParts == 0) {
						log.debug "stock already Identified so returning"
						return
					}
					
					if (stockInstance.noOfInStock > 0) {
									
						if (stockInstance.noOfInStock  >= noOfMeshParts_1) {
							//stockForOrder = noOfMeshParts - stockInstance.noOfInStock
							stockForBlock += noOfMeshParts_1
							noOfMeshParts_1=0
						}  else if (stockInstance.noOfInStock > 0) {
							noOfMeshParts_1 = noOfMeshParts_1 - stockInstance.noOfInStock
							stockForBlock+=stockInstance.noOfInStock
						}
						log.debug"stockForBlock "+stockForBlock
					}
					log.debug"after each iteration of stock orderMeshPart "+noOfMeshParts
					
				}
				
				noOfMeshParts = noOfMeshParts - stockForBlock
				
				if (noOfMeshParts > 0) {
					if(availabilityMesh) {
						availabilityMesh += "There is no enough stock for "+corderMeshPartInstance.sheetSpecification +"</br>"
					} else {
						availabilityMesh = "There is no enough stock for "+corderMeshPartInstance.sheetSpecification +"</br>"
					}
					stockAvailable = false
				
				}
				
			}
			
			def temp1 = params.('cageParts['+i+']')
			println'temp1 '+temp1
			
			if(temp1!=null && temp1.('noOfBlockedCageParts')!=''){
				//println temp.('id')
				println'blockedCageParts'+temp1.('noOfBlockedCageParts')
				def corderCagePart = temp1.('id').toBigDecimal()
				println'corderCagePart '+corderCagePart
				def cagePartSpecInstance =CagePartSpecFormula.get(corderCagePart)
				corderCagePartInstance = CorderCageParts.findByCorderAndCagePartSpecFormula(corderInstance,cagePartSpecInstance)
				println'corderCagePartInstance '+corderCagePartInstance
				def noOfBlockedCageParts = temp1.('noOfBlockedCageParts')
				def stockForBlock = 0
				BigDecimal noOfCageParts = temp1.('noOfBlockedCageParts').toBigDecimal()
				def noOfCageParts_1=noOfCageParts
				def cs = CageStock.createCriteria()
				def cageStockList = cs.list {
					eq("availabilityStatus", true)
					eq("cagePartSpecFormula", corderCagePartInstance.cagePartSpecFormula)
									
					projections {
						groupProperty("id")
						groupProperty("cagePartSpecFormula")
						sum("noOfInStock")
						
					}
				}
				println'cageStockList '+cageStockList
				
				cageStockList.each { cageStock ->
					println'cageStock'+cageStock
					def cageStockInstance = CageStock.get(cageStock[0])
					println'cageStockInstance '+cageStockInstance
					println"noOfCageParts "+noOfCageParts
					if (noOfCageParts == 0) {
						println "stock already Identified so returning"
						return
					}
					
					if (cageStockInstance.noOfInStock > 0) {
									
						if (cageStockInstance.noOfInStock  >= noOfCageParts_1) {
							//stockForOrder = noOfMeshParts - stockInstance.noOfInStock
							stockForBlock += noOfCageParts_1
							noOfCageParts_1=0
						}  else if (cageStockInstance.noOfInStock > 0) {
							noOfCageParts_1 = noOfCageParts_1 - cageStockInstance.noOfInStock
							stockForBlock+=cageStockInstance.noOfInStock
						}
						println"stockForBlock "+stockForBlock
					}
					println"after each iteration of stock orderCagePart "+noOfCageParts
					
				}
				
				noOfCageParts = noOfCageParts - stockForBlock
				
				if (noOfCageParts > 0) {
					if(availabilityCage) {
						availabilityCage += "There is no enough stock for "+corderCagePartInstance.cagePartSpecFormula +"</br>"
					} else {
						availabilityCage = "There is no enough stock for "+corderCagePartInstance.cagePartSpecFormula +"</br>"
					}
					cageStockAvailable = false
				
				}
				
			}
			
			def temp2 = params.('chainLink['+i+']')
			println'temp2 '+temp2
			
			if(temp2!=null && temp2.('blockedChainLinkSqfts')!=''){
				println'blockedChainLink'+temp2.('blockedChainLinkSqfts')
				def corderChainLink = temp2.('id').toBigDecimal()
				println'corderChainLink '+corderChainLink
				def linkMeshInstance =LinkMesh.get(corderChainLink)
				corderChainLinkInstance = CorderChainLink.findByCorderAndLinkMesh(corderInstance,linkMeshInstance)
				println'corderChainLinkInstance '+corderChainLinkInstance
				def blockedChainLinkSqfts = temp2.('blockedChainLinkSqfts')
				def stockForBlock = 0
				BigDecimal chainLinkSqfts = temp2.('blockedChainLinkSqfts').toBigDecimal()
				def chainLinkSqfts_1=chainLinkSqfts
				def cls = ChainLinkStock.createCriteria()
				def chainLinkStockList = cls.list {
					eq("availabilityStatus", true)
					eq("linkMesh", corderChainLinkInstance.linkMesh)
					eq("wireBrand",corderChainLinkInstance.wireBrand)
									
					projections {
						groupProperty("id")
						groupProperty("linkMesh")
						groupProperty("wireBrand")
						sum("noOfInStock")
						
					}
				}
				println'chainLinkStockList '+chainLinkStockList
				
				chainLinkStockList.each { chainLinkStock ->
					println'chainLinkStock'+chainLinkStock
					def chainLinkStockInstance = ChainLinkStock.get(chainLinkStock[0])
					println'chainLinkStockInstance '+chainLinkStockInstance
					println"chainLinkSqfts "+chainLinkSqfts
					if (chainLinkSqfts == 0) {
						println "stock already Identified so returning"
						return
					}
					
					if (chainLinkStockInstance.noOfInStock > 0) {
									
						if (chainLinkStockInstance.noOfInStock  >= chainLinkSqfts_1) {
							stockForBlock += chainLinkSqfts_1
							chainLinkSqfts_1=0
						}  else if (chainLinkStockInstance.noOfInStock > 0) {
							chainLinkSqfts_1 = chainLinkSqfts_1 - chainLinkStockInstance.noOfInStock
							stockForBlock+=chainLinkStockInstance.noOfInStock
						}
						println"stockForBlock "+stockForBlock
					}
					println"after each iteration of stock orderChainLink "+chainLinkSqfts
					
				}
				
				chainLinkSqfts = chainLinkSqfts - stockForBlock
				
				if (chainLinkSqfts > 0) {
					if(availabilityChainLink) {
						availabilityChainLink += "There is no enough stock for "+corderChainLinkInstance.linkMesh +"</br>"
					} else {
						availabilityChainLink = "There is no enough stock for "+corderChainLinkInstance.linkMesh +"</br>"
					}
					chainLinkStockAvailable = false
				
				}
				
			}
			
			def temp3 = params.('weldSide['+i+']')
			println'temp2 '+temp2
			
			if(temp3!=null && temp3.('blockedWeldSideSqfts')!=''){
				println'blockedWeldSide'+temp2.('blockedWeldSideSqfts')
				def corderWeldSide = temp3.('id').toBigDecimal()
				println'corderWeldSide '+corderWeldSide
				def sideMeshInstance =SideMesh.get(corderWeldSide)
				corderWeldSideInstance = CorderWeldSide.findByCorderAndSideMesh(corderInstance,sideMeshInstance)
				println'corderwelSideInstance '+corderWeldSideInstance
				def blockedWeldSideSqfts = temp3.('blockedWeldSideSqfts')
				def stockForBlock = 0
				BigDecimal weldSideSqfts = temp3.('blockedWeldSideSqfts').toBigDecimal()
				def weldSideSqfts_1=weldSideSqfts
				def wss = WeldSideMeshStock.createCriteria()
				def weldSideStockList = wss.list {
					eq("availabilityStatus", true)
					eq("sideMesh", corderWeldSideInstance.sideMesh)
					eq("wireBrand",corderWeldSideInstance.wireBrand)
									
					projections {
						groupProperty("id")
						groupProperty("sideMesh")
						groupProperty("wireBrand")
						sum("noOfInStock")
						
					}
				}
				println'weldSideStockList '+weldSideStockList
				
				weldSideStockList.each { weldSideStock ->
					println'weldSideStock'+weldSideStock
					def weldSideStockInstance = WeldSideMeshStock.get(weldSideStock[0])
					println'weldSideStockInstance '+weldSideStockInstance
					println"weldSideSqfts "+weldSideSqfts
					if (weldSideSqfts == 0) {
						println "stock already Identified so returning"
						return
					}
					
					if (weldSideStockInstance.noOfInStock > 0) {
									
						if (weldSideStockInstance.noOfInStock  >= weldSideSqfts_1) {
							stockForBlock += weldSideSqfts_1
							weldSideSqfts_1=0
						}  else if (weldSideStockInstance.noOfInStock > 0) {
							weldSideSqfts_1 = weldSideSqfts_1 - weldSideStockInstance.noOfInStock
							stockForBlock+=weldSideStockInstance.noOfInStock
						}
						println"stockForBlock "+stockForBlock
					}
					println"after each iteration of stock orderChainLink "+weldSideSqfts
					
				}
				
				weldSideSqfts = weldSideSqfts - stockForBlock
				
				if (weldSideSqfts > 0) {
					if(availabilityWeldSide) {
						availabilityWeldSide += "There is no enough stock for "+corderWeldSideInstance.sideMesh +"</br>"
					} else {
						availabilityWeldSide = "There is no enough stock for "+corderWeldSideInstance.sideMesh +"</br>"
					}
					weldSideStockAvailable = false
				
				}
				
			}
			
		}
		
		if(!stockAvailable) {
			log.debug "Stock Not available so returning"
			log.debug availabilityMesh
			flash.message = availabilityMesh;
			//render(view: "partLoad", model: [corderMeshPartInstance: corderMeshPartInstance])
			redirect(action: "partLoad", id: corderInstance.id)
			return
		}
		
					
		if(stockAvailable) {
			
			
			log.debug "Stock Available so allocating it"
			// Allocating stock for Order
			for(int i=0; i<=10; i++) { 
			log.debug''+params.('meshParts['+i+']')			
			def temp = params.('meshParts['+i+']')
				if(temp!=null && temp.('noOfBlockedParts')!=''){
					log.debug temp.('id')
					log.debug temp.('noOfBlockedParts')
					def corderMeshPart = temp.('id').toBigDecimal()
					//def cageDesignSheetSpecFormulaInstance = CageDesignSheetSpecFormula.get(sheetSpecification)
					//println'cageDesignSheetSpecFormulaInstance '+cageDesignSheetSpecFormulaInstance
					//corderMeshPartInstance = CorderMeshParts.get(corderMeshPart)
					def sheetSpecInstance =SheetSpecification.get(corderMeshPart)
					corderMeshPartInstance = CorderMeshParts.findByCorderAndSheetSpecification(corderInstance,sheetSpecInstance)
					log.debug'corderMeshPartInstance '+corderMeshPartInstance
					//def noOfBlockedMeshParts = temp.('noOfBlockedParts').toBigDecimal()
					//def stockForBlock = 0
					BigDecimal noOfMeshParts = temp.('noOfBlockedParts').toBigDecimal()
					def noOfMeshParts_1=noOfMeshParts
					//corderMeshPartInstance.noOfBlocked = corderMeshPartInstance.noOfBlocked + noOfMeshParts
					def s = Stock.createCriteria()
					def stockList = s.list {
						eq("availabilityStatus", true)
						eq("sheetSpec", corderMeshPartInstance.sheetSpecification)
						eq("wireBrand", corderMeshPartInstance.wireBrand)
					
						projections {
							groupProperty("id")
							groupProperty("sheetSpec")
							groupProperty("wireBrand")
							sum("noOfInStock")							
							
						}
					}
					log.debug'stockList '+stockList
					if(corderMeshPartInstance.noOfBlocked < corderMeshPartInstance.noOfMeshParts) {
						corderMeshPartInstance.noOfBlocked = corderMeshPartInstance.noOfBlocked + noOfMeshParts
						stockList.each { stock ->
							
							def stockInstance = Stock.get(stock[0])
							log.debug "stock "+stockInstance
							log.debug "noOfMeshParts "+noOfMeshParts
							if (noOfMeshParts == 0) {
								log.debug "stock already allocated so returning"
								return
							}
							
							def stockForOrder = 0
							if (stockInstance.noOfInStock > 0) {
											
								if (stockInstance.noOfInStock  >= noOfMeshParts_1) {
									//stockForOrder = noOfMeshParts - stockInstance.noOfInStock
									stockForOrder += noOfMeshParts_1
									noOfMeshParts_1=0
								}  else if (stockInstance.noOfInStock > 0) {
									noOfMeshParts_1 = noOfMeshParts_1 - stockInstance.noOfInStock
									stockForOrder+=stockInstance.noOfInStock
								}
								
								log.debug "stockForOrder "+stockForOrder
								
								//def stockOrder = new StockOrder(corder: corderInstance, stock: stockInstance, stockForOrder: stockForOrder)
								stockInstance.addToStockOrderItems(new StockOrder(corder: corderInstance, stock: stockInstance, stockForOrder: stockForOrder, stockOrderBlockTime: new Date()))
								stockInstance.noOfInStock =  stockInstance.noOfInStock - stockForOrder
								if (stockInstance.noOfInStock == 0) {
									stockInstance.availabilityStatus = false
								}
								
								log.debug "Adding StockOrder and updating stock"
								
								if (!stockInstance.save(flush: true)) {
									log.debug "There is some problem with updating stock when blocking stock for "+corderInstance.id
									stockInstance.errors.each {
										log.error it
									}
									flash.message = "There is some problem with updating stock when blocking stock for "+corderInstance.id
									render(view: "partLoad", model: [corderMeshPartInstance: corderMeshPartInstance])
									return
								}
							}
							noOfMeshParts = noOfMeshParts - stockForOrder
							log.debug "after each iteration of stock orderMeshPart "+noOfMeshParts
						}
											
						if (noOfMeshParts > 0) {
							flash.message = "There is no enough stock for "+corderMeshPartInstance.sheetSpecification
							render(view: "partLoad", model: [corderMeshPartInstance: corderMeshPartInstance])
							return
						}
						
					}
					
					if(!corderMeshPartInstance.save(flush: true)) {
						render(view: "partLoad", model: [corderMeshPartInstance: corderMeshPartInstance])
					}
					redirect(action: "partLoad", id: corderInstance.id)
					
				}
				
			
			}			
			
		}
		
		
		
		if(!cageStockAvailable) {
			println "Stock Not available so returning"
			println availabilityCage
			flash.message = availabilityCage
			//render(view: "partLoad", model: [corderCagePartInstance: corderCagePartInstance])
			redirect(action: "partLoad", id: corderInstance.id)
			return
		}
		
					
		if(cageStockAvailable) {
			
			
			println "Stock Available so allocating it"
			// Allocating stock for Order
			for(int i=0; i<=10; i++) {
			//println''+params.('meshParts['+i+']')
			def temp1 = params.('cageParts['+i+']')
				if(temp1!=null && temp1.('noOfBlockedCageParts')!=''){
					println temp1.('id')
					println temp1.('noOfBlockedCageParts')
					def corderCagePart = temp1.('id').toBigDecimal()
					def cagePartSpecInstance =CagePartSpecFormula.get(corderCagePart)
					corderCagePartInstance = CorderCageParts.findByCorderAndCagePartSpecFormula(corderInstance,cagePartSpecInstance)
					println'corderCagePartInstance '+corderCagePartInstance
					//def noOfBlockedMeshParts = temp.('noOfBlockedParts').toBigDecimal()
					//def stockForBlock = 0
					BigDecimal noOfCageParts = temp1.('noOfBlockedCageParts').toBigDecimal()
					def noOfCageParts_1=noOfCageParts
					//corderMeshPartInstance.noOfBlocked = corderMeshPartInstance.noOfBlocked + noOfMeshParts
					def cs = CageStock.createCriteria()
					def cageStockList = cs.list {
						eq("availabilityStatus", true)
						eq("cagePartSpecFormula", corderCagePartInstance.cagePartSpecFormula)
											
						projections {
							groupProperty("id")
							groupProperty("cagePartSpecFormula")
							sum("noOfInStock")
							
						}
					}
					println'cageStockList '+cageStockList
					if(corderCagePartInstance.noOfBlocked < corderCagePartInstance.noOfCageParts) {
						corderCagePartInstance.noOfBlocked = corderCagePartInstance.noOfBlocked + noOfCageParts
						cageStockList.each { cageStock ->
							
							def cageStockInstance = CageStock.get(cageStock[0])
							println "cageStockInstance "+cageStockInstance
							println "noOfCageParts "+noOfCageParts
							if (noOfCageParts == 0) {
								println "stock already allocated so returning"
								return
							}
							
							def stockForOrder = 0
							if (cageStockInstance.noOfInStock > 0) {
											
								if (cageStockInstance.noOfInStock  >= noOfCageParts_1) {
									stockForOrder += noOfCageParts_1
									noOfCageParts_1=0
								}  else if (cageStockInstance.noOfInStock > 0) {
									noOfCageParts_1 = noOfCageParts_1 - cageStockInstance.noOfInStock
									stockForOrder+=cageStockInstance.noOfInStock
								}
								
								println "stockForOrder "+stockForOrder
								
								cageStockInstance.addToCageStockOrderItems(new CageStockOrder(corder: corderInstance, cageStock: cageStockInstance, cageStockForOrder: stockForOrder, cageStockOrderBlockTime: new Date()))
								cageStockInstance.noOfInStock =  cageStockInstance.noOfInStock - stockForOrder
								if (cageStockInstance.noOfInStock == 0) {
									cageStockInstance.availabilityStatus = false
								}
								
								println "Adding StockOrder and updating stock"
								
								if (!cageStockInstance.save(flush: true)) {
									println "There is some problem with updating stock when blocking stock for "+corderInstance.id
									cageStockInstance.errors.each {
										log.error it
									}
									flash.message = "There is some problem with updating stock when blocking stock for "+corderInstance.id
									render(view: "partLoad", model: [corderCagePartInstance: corderCagePartInstance])
									return
								}
							}
							noOfCageParts = noOfCageParts - stockForOrder
							println "after each iteration of stock orderCagePart "+noOfCageParts
						}
											
						if (noOfCageParts > 0) {
							flash.message = "There is no enough stock for "+corderCagePartInstance.cagePartSpecFormula
							render(view: "partLoad", model: [corderCagePartInstance: corderCagePartInstance])
							return
						}
						
					}
					
					if(!corderCagePartInstance.save(flush: true)) {
						render(view: "partLoad", model: [corderCagePartInstance: corderCagePartInstance])
					}
					redirect(action: "partLoad", id: corderInstance.id)
					
				}
			
			}
			
		}
		
		if(!chainLinkStockAvailable) {
			println "Stock Not available so returning"
			println availabilityChainLink
			flash.message = availabilityChainLink
			//render(view: "partLoad", model: [corderChainLinkInstance: corderChainLinkInstance])
			redirect(action: "partLoad", id: corderInstance.id)
			return
		}
		
					
		if(chainLinkStockAvailable) {
			
			
			println "Stock Available so allocating it"
			// Allocating stock for Order
			for(int i=0; i<=10; i++) {
			//println''+params.('meshParts['+i+']')
			def temp2 = params.('chainLink['+i+']')
				if(temp2!=null && temp2.('blockedChainLinkSqfts')!=''){
					println temp2.('id')
					println temp2.('blockedChainLinkSqfts')
					def corderLinkMesh = temp2.('id').toBigDecimal()
					def linkMeshInstance =LinkMesh.get(corderLinkMesh)
					corderChainLinkInstance = CorderChainLink.findByCorderAndLinkMesh(corderInstance,linkMeshInstance)
					println'corderLinkMeshInstance '+corderChainLinkInstance
					BigDecimal linkMeshSqfts = temp2.('blockedChainLinkSqfts').toBigDecimal()
					def linkMeshSqfts_1=linkMeshSqfts
					
					def cls = ChainLinkStock.createCriteria()
					def chainLinkStockList = cls.list {
						eq("availabilityStatus", true)
						eq("linkMesh", corderChainLinkInstance.linkMesh)
						eq("wireBrand", corderChainLinkInstance.wireBrand)
											
						projections {
							groupProperty("id")
							groupProperty("linkMesh")
							groupProperty("wireBrand")
							sum("noOfInStock")
							
						}
					}
					println'chainLinkStockList '+chainLinkStockList
					if(corderChainLinkInstance.noOfBlocked < corderChainLinkInstance.squareFeets) {
						corderChainLinkInstance.noOfBlocked = corderChainLinkInstance.noOfBlocked + linkMeshSqfts
						chainLinkStockList.each { chainLinkStock ->
							
							def chainLinkStockInstance = ChainLinkStock.get(chainLinkStock[0])
							println "chainLinkStockInstance "+chainLinkStockInstance
							println "linkMeshSqfts "+linkMeshSqfts
							if (linkMeshSqfts == 0) {
								println "stock already allocated so returning"
								return
							}
							
							def stockForOrder = 0
							if (chainLinkStockInstance.noOfInStock > 0) {
											
								if (chainLinkStockInstance.noOfInStock  >= linkMeshSqfts_1) {
									stockForOrder += linkMeshSqfts_1
									linkMeshSqfts_1=0
								}  else if (chainLinkStockInstance.noOfInStock > 0) {
									linkMeshSqfts_1 = linkMeshSqfts_1 - chainLinkStockInstance.noOfInStock
									stockForOrder+=chainLinkStockInstance.noOfInStock
								}
								
								println "stockForOrder "+stockForOrder
								
								chainLinkStockInstance.addToChainLinkStockOrderItems(new ChainLinkStockOrder(corder: corderInstance, chainLinkStock: chainLinkStockInstance, chainLinkStockForOrder: stockForOrder, chainLinkStockOrderBlockTime: new Date()))
								chainLinkStockInstance.noOfInStock =  chainLinkStockInstance.noOfInStock - stockForOrder
								if (chainLinkStockInstance.noOfInStock == 0) {
									chainLinkStockInstance.availabilityStatus = false
								}
								
								println "Adding StockOrder and updating stock"
								
								if (!chainLinkStockInstance.save(flush: true)) {
									println "There is some problem with updating stock when blocking stock for "+corderInstance.id
									chainLinkStockInstance.errors.each {
										log.error it
									}
									flash.message = "There is some problem with updating stock when blocking stock for "+corderInstance.id
									render(view: "partLoad", model: [corderChainLinkInstance: corderChainLinkInstance])
									return
								}
							}
							linkMeshSqfts = linkMeshSqfts - stockForOrder
							println "after each iteration of stock orderChainLink "+linkMeshSqfts
						}
											
						if (linkMeshSqfts > 0) {
							flash.message = "There is no enough stock for "+corderChainLinkInstance.linkMesh
							render(view: "partLoad", model: [corderChainLinkInstance: corderChainLinkInstance])
							return
						}
						
					}
					
					if(!corderChainLinkInstance.save(flush: true)) {
						render(view: "partLoad", model: [corderChainLinkInstance: corderChainLinkInstance])
					}
					redirect(action: "partLoad", id: corderInstance.id)
					
				}
			
			}
			
		}
		
		if(!weldSideStockAvailable) {
			println "Stock Not available so returning"
			println availabilityWeldSide
			flash.message = availabilityWeldSide
			//render(view: "partLoad", model: [corderWeldSideInstance: corderWeldSideInstance])
			redirect(action: "partLoad", id: corderInstance.id)
			return
		}
		
					
		if(weldSideStockAvailable) {
						
			println "Stock Available so allocating it"
			
			for(int i=0; i<=10; i++) {
			def temp3 = params.('weldSide['+i+']')
				if(temp3!=null && temp3.('blockedWeldSideSqfts')!=''){
					println temp3.('id')
					println temp3.('blockedWeldSideSqfts')
					def corderSideMesh = temp3.('id').toBigDecimal()
					def sideMeshInstance =SideMesh.get(corderSideMesh)
					corderWeldSideInstance = CorderWeldSide.findByCorderAndSideMesh(corderInstance,sideMeshInstance)
					println'corderWeldSideInstance '+corderWeldSideInstance
					BigDecimal sideMeshSqfts = temp3.('blockedWeldSideSqfts').toBigDecimal()
					def sideMeshSqfts_1=sideMeshSqfts
					
					def wss = WeldSideMeshStock.createCriteria()
					def weldSideStockList = wss.list {
						eq("availabilityStatus", true)
						eq("sideMesh", corderWeldSideInstance.sideMesh)
						eq("wireBrand", corderWeldSideInstance.wireBrand)
											
						projections {
							groupProperty("id")
							groupProperty("sideMesh")
							groupProperty("wireBrand")
							sum("noOfInStock")
							
						}
					}
					println'weldSideStockList '+weldSideStockList
					if(corderWeldSideInstance.noOfBlocked < corderWeldSideInstance.squareFeets) {
						corderWeldSideInstance.noOfBlocked = corderWeldSideInstance.noOfBlocked + sideMeshSqfts
						weldSideStockList.each { weldSideStock ->
							
							def weldSideStockInstance = WeldSideMeshStock.get(weldSideStock[0])
							println "weldSideStockInstance "+weldSideStockInstance
							println "sideMeshSqfts "+sideMeshSqfts
							if (sideMeshSqfts == 0) {
								println "stock already allocated so returning"
								return
							}
							
							def stockForOrder = 0
							if (weldSideStockInstance.noOfInStock > 0) {
											
								if (weldSideStockInstance.noOfInStock  >= sideMeshSqfts_1) {
									stockForOrder += sideMeshSqfts_1
									sideMeshSqfts_1=0
								}  else if (weldSideStockInstance.noOfInStock > 0) {
									sideMeshSqfts_1 = sideMeshSqfts_1 - weldSideStockInstance.noOfInStock
									stockForOrder+=weldSideStockInstance.noOfInStock
								}
								
								println "stockForOrder "+stockForOrder
								
								weldSideStockInstance.addToWeldSideMeshStockOrderItems(new WeldSideMeshStockOrder(corder: corderInstance, weldSideMeshStock: weldSideStockInstance, weldSideMeshStockForOrder: stockForOrder, weldSideMeshStockOrderBlockTime: new Date()))
								weldSideStockInstance.noOfInStock =  weldSideStockInstance.noOfInStock - stockForOrder
								if (weldSideStockInstance.noOfInStock == 0) {
									weldSideStockInstance.availabilityStatus = false
								}
								
								println "Adding StockOrder and updating stock"
								
								if (!weldSideStockInstance.save(flush: true)) {
									println "There is some problem with updating stock when blocking stock for "+corderInstance.id
									weldSideStockInstance.errors.each {
										log.error it
									}
									flash.message = "There is some problem with updating stock when blocking stock for "+corderInstance.id
									render(view: "partLoad", model: [corderWeldSideInstance: corderWeldSideInstance])
									return
								}
							}
							sideMeshSqfts = sideMeshSqfts - stockForOrder
							println "after each iteration of stock orderWeldSide "+sideMeshSqfts
						}
											
						if (sideMeshSqfts > 0) {
							flash.message = "There is no enough stock for "+corderWeldSideInstance.sideMesh
							render(view: "partLoad", model: [corderWeldSideInstance: corderWeldSideInstance])
							return
						}
						
					}
					
					if(!corderWeldSideInstance.save(flush: true)) {
						render(view: "partLoad", model: [corderWeldSideInstance: corderWeldSideInstance])
					}
					redirect(action: "partLoad", id: corderInstance.id)
					
				}
			
			}
			
		}
		
	}
	
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def show() {
        def corderInstance = Corder.get(params.id)
		
		BigDecimal totalPayment = 0
		BigDecimal balance = 0
		corderInstance.corderPayments.each { corderPayment ->
			totalPayment += corderPayment.paymentAmount 
		}
		
		log.debug("totalAmount "+totalPayment)
		balance = (corderInstance.totalCost - totalPayment)
		log.debug("balance "+balance)
		
        if (!corderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
            redirect(action: "list")
            return
        }

        [corderInstance: corderInstance, totalPayment: totalPayment, balance: balance]
    }
	
	@Secured(['ROLE_ADMIN', 'ROLE_PRODMANAGER'])
	def shipOrder() {
		
		def corderInstance = Corder.get(params.id)
		NotificationService notificationService = new NotificationService()
		BigDecimal totalPayment = 0
		BigDecimal balance = 0
		corderInstance.corderPayments.each { corderPayment ->
			totalPayment += corderPayment.paymentAmount
		}
		
		log.debug("totalAmount "+totalPayment)
		balance = (corderInstance.totalCost - totalPayment)
		log.debug("balance "+balance)
		
		if(balance!= 0) {
			flash.message = "Shipping cannot be done, Balance Amount:"+balance
			render(view: "show", model: [corderInstance: corderInstance, totalPayment: totalPayment, balance: balance])
			
		}
		
		/*if (!corderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
			redirect(action: "list")
			return
		}*/
		else {
		corderInstance.shippingStatus = Corder.STATUS_SHIPPED
		//notificationService.addSmsNotification(Notification.NOTIFMSG_SMS_ORDER_SHIPPED+" DETAILS:"+corderInstance.orderId, true, Notification.NOTIFTYPE_SMS, corderInstance.customer.mobileNumber)
		[corderInstance: corderInstance, totalPayment: totalPayment, balance: balance]
		}		
	}
	
	@Secured(['ROLE_ADMIN'])
	def updateShippingStatus() {
		def corderInstance = Corder.get(params.id)
		if (!corderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (corderInstance.version > version) {
				corderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'corder.label', default: 'Corder')] as Object[],
						  "Another user has updated this Corder while you were editing")
				render(view: "edit", model: [corderInstance: corderInstance])
				return
			}
		}

		corderInstance.shippingStatus = Corder.STATUS_SHIPPED

		if (!corderInstance.save(flush: true)) {
			render(view: "edit", model: [corderInstance: corderInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'corder.label', default: 'Corder'), corderInstance.id])
		redirect(action: "shippedOrders")
	}

	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def edit() {
        def corderInstance = Corder.get(params.id)
        if (!corderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
            redirect(action: "list")
            return
        }

        [corderInstance: corderInstance]
    }

	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def update() {
        def corderInstance = Corder.get(params.id)
        if (!corderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (corderInstance.version > version) {
                corderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'corder.label', default: 'Corder')] as Object[],
                          "Another user has updated this Corder while you were editing")
                render(view: "edit", model: [corderInstance: corderInstance])
                return
            }
        }

        corderInstance.properties = params
		def corderMeshPartList = corderInstance.corderMeshParts
		def corderCagePartList = corderInstance.corderCageParts
		log.debug'corderMeshPartList '+corderMeshPartList
		log.debug'corderCagePartList '+corderCagePartList
		
		BigDecimal meshCost = 0
		def totMeshSheetCost = 0
		def meshSheetCost = 0
		
		corderMeshPartList.each { sheetSpecFor ->
			def noOfMeshParts = sheetSpecFor.noOfMeshParts
			BigDecimal noOfCrossWires = (sheetSpecFor.sheetSpecification.length/sheetSpecFor.sheetSpecification.pitch)+1
			BigDecimal crossWireLength = noOfCrossWires*(sheetSpecFor.sheetSpecification.width+(2*sheetSpecFor.sheetSpecification.projection))
			BigDecimal lineWireLength1 = (sheetSpecFor.sheetSpecification.length+sheetSpecFor.sheetSpecification.pitch)*sheetSpecFor.sheetSpecification.noOfLineWires1
			BigDecimal lineWireLength2 = (sheetSpecFor.sheetSpecification.length+sheetSpecFor.sheetSpecification.pitch)*sheetSpecFor.sheetSpecification.noOfLineWires2
			
			BigDecimal crossWireWeight = ((crossWireLength/6588)*(sheetSpecFor.sheetSpecification.crossWireDiameter*sheetSpecFor.sheetSpecification.crossWireDiameter))
			BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(sheetSpecFor.sheetSpecification.lineWireDiameter1*sheetSpecFor.sheetSpecification.lineWireDiameter1))
			BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(sheetSpecFor.sheetSpecification.lineWireDiameter2*sheetSpecFor.sheetSpecification.lineWireDiameter2))
			
			log.debug'crossWireDiameter '+sheetSpecFor.sheetSpecification.crossWireDiameter
			log.debug'lineWireDiameter1 '+sheetSpecFor.sheetSpecification.lineWireDiameter1
			log.debug'lineWireDiameter2 '+sheetSpecFor.sheetSpecification.lineWireDiameter2
			
			log.debug'crossWireWeight'+crossWireWeight
			log.debug'lineWireWeight1'+lineWireWeight1
			log.debug'lineWireWeight2'+lineWireWeight2
			
			def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecFor.sheetSpecification.crossWireDiameter)
			def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecFor.sheetSpecification.lineWireDiameter1)
			def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecFor.sheetSpecification.lineWireDiameter2)
			
			if(sheetSpecFor.sheetSpecification.lineWireDiameter1 > 0 && sheetSpecFor.sheetSpecification.lineWireDiameter2 > 0) {
				
				meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)) * noOfMeshParts)
				log.debug'meshSheetCost '+meshSheetCost
			} else if(sheetSpecFor.sheetSpecification.lineWireDiameter1 > 0) {
			
				meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts)
				log.debug'meshSheetCost '+meshSheetCost
			} else {
			
			meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice2.price)) * noOfMeshParts)
			log.debug'meshSheetCost '+meshSheetCost
			}
			
			totMeshSheetCost += meshSheetCost
			log.debug'totMeshSheetCost '+totMeshSheetCost
						
		}
		
		meshCost = (totMeshSheetCost*corderInstance.noOfSheds)
		log.debug'Mesh cost: '+meshCost
		
		BigDecimal totalCagePartCost = 0
		
		corderCagePartList.each { cagePart ->
			def noOfCagePart = cagePart.noOfCageParts
			def cagePartCost = cagePart.priceOfEachCagePart
			
			totalCagePartCost += (noOfCagePart*cagePartCost)
			log.debug'totalCagePartCost'+totalCagePartCost
						
		}
		totalCagePartCost = (totalCagePartCost*corderInstance.noOfSheds)
				
		log.debug'totalCagePartCost: '+totalCagePartCost
		BigDecimal totalCost = (meshCost+totalCagePartCost)
		
		BigDecimal costPerBird = (totalCost/corderInstance.noOfBirds)
		log.debug'costPerBird '+costPerBird
		
		def taxPercent = corderInstance.taxation.percent
		log.debug'tax '+taxPercent
		
		def tax = ((taxPercent/100)*totalCost)
		log.debug'tax ' +tax
		BigDecimal finalCost = totalCost + tax
		log.debug'finalCost '+finalCost
		
		corderInstance.costPerBird = costPerBird
		corderInstance.cost = totalCost
		corderInstance.tax = tax
		corderInstance.totalCost = finalCost
		corderInstance.comments = params.comments+" "+"Edited By "+springSecurityService.currentUser.toString()+new Date().format("ddMMyyhhmm")+"</br>"
						 
        if (!corderInstance.save(flush: true)) {
            render(view: "edit", model: [corderInstance: corderInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'corder.label', default: 'Corder'), corderInstance.id])
        redirect(action: "show", id: corderInstance.id)
    }
	
	@Secured(['ROLE_ADMIN'])
	def editPayment() {
		def corderInstance = Corder.get(params.id)
		log.debug'corderInstance '+corderInstance
		
        if (!corderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
            redirect(action: "list")
            return
        }
		render(view: "editPayment", model: [corderInstance: corderInstance])
        //[corderInstance: corderInstance]
    }

	@Secured(['ROLE_ADMIN'])
	def updatePayment() {
        log.debug'in payment'
		def corderInstance = Corder.get(params.id)
		log.debug'corderInstance'+corderInstance
        if (!corderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (corderInstance.version > version) {
                corderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'corder.label', default: 'Corder')] as Object[],
                          "Another user has updated this Corder while you were editing")
                render(view: "edit", model: [corderInstance: corderInstance])
                return
            }
        }

        corderInstance.properties = params
		
		def paymentList = corderInstance.corderPayments
		log.debug'paymentList '+paymentList
		
        if (!corderInstance.save(flush: true)) {
            render(view: "edit", model: [corderInstance: corderInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'corder.label', default: 'Corder'), corderInstance.id])
        redirect(action: "show", id: corderInstance.id)
    }

	@Secured(['ROLE_ADMIN'])
	def delete() {
        def corderInstance = Corder.get(params.id)
        if (!corderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
            redirect(action: "list")
            return
        }

        try {
            corderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'corder.label', default: 'Corder'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def search() {
		
	}
	
	def searchResults() {
				
		def c = Corder.createCriteria()
		def corderInstanceList = c {
				le("createdDate",params.createdDate) 
				ge("lastEditedDate",params.lastEditedDate) 
			order("createdDate", "desc")
		}
		log.debug "Final corderInstanceList.size() "+corderInstanceList.size()
				
		[corderInstanceList: corderInstanceList, corderInstanceTotal: corderInstanceList.size()]
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_PRODMANAGER'])
	def pendingMeshParts() {
				
		def c = Corder.createCriteria()
		def corderInstanceList = c {
				 eq("shippingStatus",Corder.STATUS_NEW)	
		}
		log.debug corderInstanceList
		if(corderInstanceList.size() > 0) {
			def c1 = CorderMeshParts.createCriteria()
			def orderMeshPartsInstanceList = c1.list {
				'in'("corder",corderInstanceList)
				order("sheetSpecification")
				projections {
					
					groupProperty("sheetSpecification")
					groupProperty("wireBrand")
					sum("noOfMeshParts")					
					
				}
			}
			log.debug orderMeshPartsInstanceList
			
			List  orderMeshPartReport = new ArrayList()
			List wireBrandInstanceList = WireBrand.list()
			def orderMeshPartReportLine
			
			Long temp = null
			orderMeshPartsInstanceList.each { orderMeshPartsInstance ->
				
				log.debug 'temp '+ temp 
				log.debug'orderMeshPartsInstance[0].id '+orderMeshPartsInstance[0].id.getClass()
				log.debug'temp '+ temp.getClass()
				
				if(temp == null || !temp.equals(orderMeshPartsInstance[0].id)) {
					log.debug orderMeshPartsInstance[0].id
					log.debug orderMeshPartsInstance[0]
					orderMeshPartReportLine = new Object[2 + wireBrandInstanceList.size()]
					orderMeshPartReport.add(orderMeshPartReportLine)
					
					orderMeshPartReportLine[0] = orderMeshPartsInstance[0].id
					orderMeshPartReportLine[1] = orderMeshPartsInstance[0]
					
				} 
				
				int wireBrandIndex = wireBrandInstanceList.indexOf(orderMeshPartsInstance[1]) 
				orderMeshPartReportLine[2 + wireBrandIndex] = orderMeshPartsInstance[2]
				temp = orderMeshPartsInstance[0].id
				
				
				
				
			}
			
			log.debug orderMeshPartReport
			//[orderMeshPartReport: orderMeshPartsInstanceList, wireBrandInstanceList: wireBrandInstanceList]
			[orderMeshPartsInstanceList: orderMeshPartReport, wireBrandInstanceList: wireBrandInstanceList]
			
		} else {
			flash.message = "No Orders at this point in time"
		}
		
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def pendingCageParts() {

		def c = Corder.createCriteria()
		def corderInstanceList = c {
			eq("shippingStatus",Corder.STATUS_NEW)
		}
		log.debug corderInstanceList
		if(corderInstanceList.size() > 0) {
			def c1 = CorderCageParts.createCriteria()
			def orderCagePartsInstanceList = c1.list {
				'in'("corder",corderInstanceList)
				order("cagePartSpecFormula")
				projections {

					groupProperty("cagePartSpecFormula")
					sum("noOfCageParts")
				}
			}
			log.debug orderCagePartsInstanceList
			[orderCagePartsInstanceList: orderCagePartsInstanceList]

		} else {
			flash.message = "No Orders at this point in time"
		}

	}
	
	def pendingChainLink() {
		
		def c = Corder.createCriteria()
		def corderInstanceList = c {
				 eq("shippingStatus",Corder.STATUS_NEW)
		}
		log.debug corderInstanceList
		if(corderInstanceList.size() > 0) {
			
			[corderInstanceList: corderInstanceList]
			
		} else {
			flash.message = "No Orders at this point in time"
		}	
		
	}
	
	def pendingWeldSide() {
		
		def c = Corder.createCriteria()
		def corderInstanceList = c {
				 eq("shippingStatus",Corder.STATUS_NEW)
		}
		log.debug corderInstanceList
		if(corderInstanceList.size() > 0) {
			
			[corderInstanceList: corderInstanceList]
			
		} else {
			flash.message = "No Orders at this point in time"
		}
		
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def customerOrder() {
		def c = Corder.createCriteria()
		def customerOrderList = c {
			eq("shippingStatus",Corder.STATUS_NEW)
			
		}
		log.debug customerOrderList
		[customerOrderList: customerOrderList]		
	}
	
	@Secured(['ROLE_ADMIN'])
	def findCorderByMeshPart() {
			
		log.debug("params.sheetSpecId "+params.sheetSpecId)
		log.debug("params.wireBrandId "+params.wireBrandId)
				
		def sheetSpecificationInstance = SheetSpecification.get(params.sheetSpecId)
		def wireBrandInstance = WireBrand.get(params.wireBrandId)
		
		def corderInstanceList = Corder.findAllWhere(shippingStatus: Corder.STATUS_NEW)
		List finalCorderInstanceList = new ArrayList()
		corderInstanceList.each { corderInstance ->
			
			def orderMeshParts = corderInstance.corderMeshParts
			orderMeshParts.each { orderMeshPart ->
				if (orderMeshPart.sheetSpecification == sheetSpecificationInstance && orderMeshPart.wireBrand ==  wireBrandInstance) {
					finalCorderInstanceList.add(corderInstance)
				}
			}
		}
					
		[corderInstanceList: finalCorderInstanceList, corderInstanceTotal: finalCorderInstanceList.size()]
	}
	
	@Secured(['ROLE_ADMIN'])
	def corderAwaitingParts() {
		
		log.debug("params.sheetSpecId "+params.sheetSpecification)
		log.debug("params.wireBrandId "+params.wireBrand)
			
		def sheetSpecificationInstance = SheetSpecification.get(params.sheetSpecification)
		def wireBrandInstance = WireBrand.get(params.wireBrand)
		
		def c = CorderMeshParts.createCriteria()
		def corderInstanceList = c.list {
			
			//eq("availabilityStatus",true)
			eq("wireBrand",wireBrandInstance)
			eq("sheetSpecification",sheetSpecificationInstance)
									
		}
		//println 'corderInstanceList '+corderInstanceList.noOfMeshParts
		/*def meshParts = 0
		def corderInstanceList = Corder.findAllWhere(shippingStatus: "NEW")
		List finalCorderInstanceList = new ArrayList()
		corderInstanceList.each { corderInstance ->
			
			def orderMeshParts = corderInstance.corderMeshParts
			orderMeshParts.each { orderMeshPart ->
				if (orderMeshPart.sheetSpecification == sheetSpecificationInstance && orderMeshPart.wireBrand ==  wireBrandInstance) {
					
					meshParts = orderMeshPart.noOfMeshParts
					finalCorderInstanceList.add(corderInstance)
					println'finalCorderInstanceList '+finalCorderInstanceList
				}
			}
		}
					
		[corderInstanceList: finalCorderInstanceList, meshParts: meshParts, corderInstanceTotal: finalCorderInstanceList.size()]		
		*/
		[corderInstanceList: corderInstanceList, corderInstanceTotal: corderInstanceList.size()]
	}
	
	
	@Secured(['ROLE_ADMIN'])
	def corderCageParts() {
		
		log.debug("params.cagePart "+params.cagePart)
					
		def cagePartInstance = CagePartSpecFormula.get(params.cagePart)
		log.debug'cagePartInstance '+cagePartInstance
		
		def c = CorderCageParts.createCriteria()
		def corderCagePartInstanceList = c.list {
						
			eq("cagePartSpecFormula",cagePartInstance)
									
		}
		log.debug'corderCagePartInstanceList '+corderCagePartInstanceList
		[corderCagePartInstanceList: corderCagePartInstanceList, corderCagePartInstanceTotal: corderCagePartInstanceList.size()]
	}
	
	@Secured(['ROLE_ADMIN'])
	def pendingOrderPayments() {
		
		List corderInstanceList = Corder.findAllByPaymentStatus(Corder.STATUS_DUE)
		[corderInstanceList: corderInstanceList, corderInstanceTotal: corderInstanceList.size()]		
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_PRODMANAGER'])
	def wireRequiredReport() {

		def c = Corder.createCriteria()
		def corderInstanceList = c {
				 eq("shippingStatus",Corder.STATUS_NEW)
		}
		println corderInstanceList
		def orderMeshPartsList
		//def orderMeshList = new ArrayList()
				
		if(corderInstanceList.size() > 0) {
			def c1 = CorderMeshParts.createCriteria()
			 orderMeshPartsList = c1.list {
				'in'("corder",corderInstanceList)
				order("sheetSpecification")
				projections {
										
					groupProperty("sheetSpecification")
					groupProperty("wireBrand")
					sum("noOfMeshParts")
										
				}
			}
			
			println'orderMeshPartsList'+orderMeshPartsList
			//println'nooftMeshParts '+orderMeshPartsList[3]
		}
		
		def orderChainLinkList
		if(corderInstanceList.size() > 0) {
			def c1 = CorderChainLink.createCriteria()
			 orderChainLinkList = c1.list {
				'in'("corder",corderInstanceList)
				order("linkMesh")
				projections {
										
					groupProperty("linkMesh")
					groupProperty("wireBrand")
					sum("squareFeets")
										
				}
			}
			
			println'orderChainLinkList'+orderChainLinkList
		}
		
		def orderWeldSideList
		if(corderInstanceList.size() > 0) {
			def c1 = CorderWeldSide.createCriteria()
			 orderWeldSideList = c1.list {
				'in'("corder",corderInstanceList)
				order("sideMesh")
				projections {
										
					groupProperty("sideMesh")
					groupProperty("wireBrand")
					sum("squareFeets")
										
				}
			}
			
			println'orderWeldSideList '+orderWeldSideList
		}
		
		def s = Stock.createCriteria()
		def stockInstanceList = s.list {
			
			eq("availabilityStatus",true)
			projections {
								
				groupProperty("sheetSpec")
				groupProperty("wireBrand")
				sum("noOfInStock")
			}
		}
		
		log.debug'stockInstanceList '+stockInstanceList
		
		def cls = ChainLinkStock.createCriteria()
		def chainLinkStockInstanceList = cls.list {
			
			eq("availabilityStatus",true)
			projections {
								
				groupProperty("linkMesh")
				groupProperty("wireBrand")
				sum("noOfInStock")
			}
		}
		
		println'chainLinkStockInstanceList '+chainLinkStockInstanceList
		
		def wss = WeldSideMeshStock.createCriteria()
		def weldSideStockInstanceList = wss.list {
			
			eq("availabilityStatus",true)
			projections {
								
				groupProperty("sideMesh")
				groupProperty("wireBrand")
				sum("noOfInStock")
			}
		}
		
		println'weldSideStockInstanceList '+weldSideStockInstanceList
		
		def orderMeshParts
		def orderMeshList = new ArrayList()
		
		orderMeshPartsList.each { meshPart ->
			log.debug'meshPart '+meshPart
			log.debug'sheet '+meshPart[0].sheetName
			log.debug'wire '+meshPart[1].wireBrand
			log.debug'noOfOrderedSheets '+meshPart[2]
			
			stockInstanceList.each { stock ->
				
				log.debug'sheetorder '+stock[0].sheetName
				log.debug'wire'+stock[1].wireBrand
				log.debug'noOfStockSheets '+stock[2]
				if((stock[0].sheetName == meshPart[0].sheetName) && (stock[1].wireBrand == meshPart[1].wireBrand)) {
					
					log.debug'test-if'
					meshPart[2] = stock[2] - meshPart[2]
					
					//println'orderMeshParts '+orderMeshParts
				} 								
			}
			orderMeshParts = meshPart
			log.debug'orderMeshParts '+orderMeshParts
			orderMeshList.add(orderMeshParts)
			//println'orderMeshList '+orderMeshList
			//println'meshPartsList '+meshPartsList
		}
		
		log.debug'orderMeshList '+orderMeshList
		
		def orderChainLink
		def orderChainLinkList_1 = new ArrayList()
		
		orderChainLinkList.each { chainLink ->
			println'chainlink '+chainLink
			println'linkMesh '+chainLink[0]
			println'wireBrand '+chainLink[1]
			println'noOfsqfts'+chainLink[2]
			
			chainLinkStockInstanceList.each { stock ->
				println'stock'+stock
				if((stock[0] == chainLink[0]) && (stock[1] == chainLink[1])) {
					chainLink[2] = stock[2]-chainLink[2]
					println'chainLink[2] '+chainLink[2]
				}
			}
			orderChainLink = chainLink
			println'orderChainLink '+orderChainLink
			orderChainLinkList_1.add(orderChainLink)
			println'orderChainLinkList_1 '+orderChainLinkList_1
		}
		
		def orderWeldSide
		def orderWeldSideList_1 = new ArrayList()
		
		orderWeldSideList.each { weldSide ->
			println'weldSide '+weldSide
			println'sideMesh '+weldSide[0]
			println'wireBrand '+weldSide[1]
			println'noOfsqfts'+weldSide[2]
			
			weldSideStockInstanceList.each { stock ->
				println'stock'+stock
				if((stock[0] == weldSide[0]) && (stock[1] == weldSide[1])) {
					weldSide[2] = stock[2]-weldSide[2]
					println'weldSide[2] '+weldSide[2]
				}
			}
			orderWeldSide = weldSide
			println'orderWeldSide '+orderWeldSide
			orderWeldSideList_1.add(orderWeldSide)
			println'orderWeldSideList_1 '+orderWeldSideList_1
		}
		
		def strArray
		def strArray1 
		def strArray2 
		def strArray3
		def strArray4
		
		def orderWireReq = [:]
						
		orderMeshList.each { meshPart ->
			
			BigDecimal noOfCrossWires = (meshPart[0].length/meshPart[0].pitch)+1
			BigDecimal crossWireLength = noOfCrossWires*(meshPart[0].width+(2*meshPart[0].projection))
			BigDecimal lineWireLength1 = (meshPart[0].length+meshPart[0].pitch)*meshPart[0].noOfLineWires1
			BigDecimal lineWireLength2 = (meshPart[0].length+meshPart[0].pitch)*meshPart[0].noOfLineWires2
			
			BigDecimal crossWireWeight = ((crossWireLength/6588)*(meshPart[0].crossWireDiameter*meshPart[0].crossWireDiameter))
			BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(meshPart[0].lineWireDiameter1*meshPart[0].lineWireDiameter1))
			BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(meshPart[0].lineWireDiameter2*meshPart[0].lineWireDiameter2))
			
			log.debug'crossWireDiameter'+meshPart[0].crossWireDiameter
			log.debug'lineWireDiameter1'+meshPart[0].lineWireDiameter1
			log.debug'lineWireDiameter2'+meshPart[0].lineWireDiameter2
			
			log.debug'crossWireWeight'+crossWireWeight
			log.debug'lineWireWeight1'+lineWireWeight1
			log.debug'lineWireWeight2'+lineWireWeight2
			
			if ((meshPart[0].crossWireDiameter == meshPart[0].lineWireDiameter1)
				&& (meshPart[0].lineWireDiameter2 == 0)) {
				
				log.debug'test1'
				
				strArray = new String[8]
							
				log.debug' wireBrand '+meshPart[1].wireBrand
				log.debug'crossWireDiameter'+meshPart[0].crossWireDiameter
				log.debug'sheetWt '+meshPart[0].sheetWeight
				log.debug'noOfParts '+meshPart[2]
				log.debug'meshPartSheetWt '+meshPart[0].sheetWeight*meshPart[2]
				BigDecimal wireWeight =  (crossWireWeight + lineWireWeight1) * meshPart[2]
				log.debug'wireWeight '+wireWeight
												
				strArray[0] = meshPart[1].wireBrand
				strArray[1] = meshPart[0].crossWireDiameter
				strArray[2] = wireWeight
				log.debug'strArray[0] '+strArray[0]
				log.debug'strArray[1] '+strArray[1]
				log.debug'sheetName '+meshPart[0]
				log.debug'strArray[2] '+strArray[2]
				def key = meshPart[1].wireBrand + meshPart[0].crossWireDiameter.toString()
				if(orderWireReq.size() == 0) {
					log.debug'adding to map '
					orderWireReq.put(key, strArray)
					
				} else {
				
					if(orderWireReq.get(key)) {
						log.debug'adding to existing data'
						def existingData = orderWireReq.get(key)
						println'existingData '+existingData
						println'existingData[2] '+existingData[2]
						existingData[2] =  new BigDecimal(existingData[2]) + wireWeight
						log.debug'existingData '+existingData
 						
					} else {
						orderWireReq.put(key, strArray)					
					}
				
				}
				
				
			} else if ((meshPart[0].crossWireDiameter == meshPart[0].lineWireDiameter1)
				&& (meshPart[0].lineWireDiameter2 > 0)) {
				
				strArray1 = new String[8]
				strArray2 = new String[8]
				
				log.debug'test2'
				
				log.debug'wireBrand '+meshPart[1]
				log.debug'crossWireDiameter'+meshPart[0].crossWireDiameter
				
				BigDecimal wireWeight1 =  (crossWireWeight + lineWireWeight1) * meshPart[2]
				BigDecimal wireWeight2 =  (lineWireWeight2) * meshPart[2]
				log.debug'wireWeight1 '+wireWeight1
				log.debug'wireWeight2 '+wireWeight2
				
				strArray1[0] = meshPart[1].wireBrand
				strArray1[1] = meshPart[0].crossWireDiameter
				strArray1[2] = wireWeight1
				
				strArray2[0] = meshPart[1].wireBrand
				strArray2[1] = meshPart[0].lineWireDiameter2
				strArray2[2] = wireWeight2
				
				def key1 = meshPart[1].wireBrand+meshPart[0].crossWireDiameter.toString()
				def key2 = meshPart[1].wireBrand+meshPart[0].lineWireDiameter2.toString()
				
				if(orderWireReq.size() == 0) {
					log.debug'adding to map '
					orderWireReq.put(key1, strArray1)
					orderWireReq.put(key2, strArray2)
					
				} else {
				
					if(orderWireReq.get(key1)) {
						log.debug'adding to existing data'
						def existingData1 = orderWireReq.get(key1)
						println'existingData1 '+existingData1
						existingData1[2] = new BigDecimal(existingData1[2]) + wireWeight1
						log.debug'existingData1 '+existingData1
						 
					} else {
						orderWireReq.put(key1, strArray1)
					}
					if(orderWireReq.get(key2)) {
						log.debug'adding to existing data'
						def existingData2 = orderWireReq.get(key2)
						println'existingData2 '+existingData2
						println'existingData2[2] '+existingData2[2]
						existingData2[2] =  new BigDecimal(existingData2[2]) + wireWeight2
						log.debug'existingData2 '+existingData2
						 
					} else {
						orderWireReq.put(key2, strArray2)
					}
				
				}
								
			}			
			
		}
		
		orderChainLinkList_1.each { chainLink ->
			
			strArray3 = new String[8]
			println'link'+chainLink
			println'wireBrand'+chainLink[1].wireBrand
			println'wireDiameter'+chainLink[0].wireDiameter
			println'wireWeight '+chainLink[2]
			strArray3[0] = chainLink[1].wireBrand
			strArray3[1] = chainLink[0].wireDiameter
			strArray3[3] = chainLink[2]
			println'strArray3[0] '+strArray3[0]
			println'strArray3[1] '+strArray3[1]
			println'strArray3[3] '+strArray3[3]
			
			def key3 = chainLink[1].wireBrand+chainLink[0].wireDiameter.toString()
			println'string3 '+strArray3
			if(orderWireReq.size() == 0) {
				println'adding to map '
				orderWireReq.put(key3, strArray3)
			} else {
				
					if(orderWireReq.get(key3)) {
						println'adding to existing data'
						def existingData3 = orderWireReq.get(key3)
						println'existingData3 '+existingData3
						existingData3[3] = strArray3[3]
						println'existingData3 '+existingData3
						 
					} else {
						orderWireReq.put(key3, strArray3)
					}
			}
			
		}
		
		orderWeldSideList_1.each { weldSide ->
			
			strArray4 = new String[8]
			println'side'+weldSide
			println'wireBrand'+weldSide[1].wireBrand
			println'wireDiameter'+weldSide[0].wireDiameter
			println'wireWeight '+weldSide[2]
			strArray4[0] = weldSide[1].wireBrand
			strArray4[1] = weldSide[0].wireDiameter
			strArray4[4] = weldSide[2]
			println'strArray4[0] '+strArray4[0]
			println'strArray4[1] '+strArray4[1]
			println'strArray4[4] '+strArray4[4]
			
			def key4 = weldSide[1].wireBrand+weldSide[0].wireDiameter.toString()
			
			if(orderWireReq.size() == 0) {
				println'adding to map '
				orderWireReq.put(key4, strArray4)
			} else {
				
					if(orderWireReq.get(key4)) {
						println'adding to existing data'
						def existingData4 = orderWireReq.get(key4)
						existingData4[4] = strArray4[4]
						println'existingData4 '+existingData4
						 
					} else {
						orderWireReq.put(key4, strArray4)
					}
			}
			
		}
				
		println'orderWireReq '+orderWireReq
		
		def wireOrderList = orderWireReq.keySet()
		println'wireOrderWeightList '+orderWireReq.values()
						
		wireOrderList.each { key ->
			
			def wire = orderWireReq[key]
			println'wire '+wire
			WireBrand wireBrandInstance = WireBrand.findByWireBrand(wire.getAt(0))
			BigDecimal wireDiameter = wire.getAt(1).toBigDecimal()
			def meshWireWeight = wire.getAt(2)?.toBigDecimal()
			def chainLinkWireWeight = wire.getAt(3)?.toBigDecimal()
			def weldSideWireWeight = wire.getAt(4)?.toBigDecimal()
			println'wireBrandInstance '+wireBrandInstance
			
			if(meshWireWeight == null){
				meshWireWeight = 0.0
			}
			if(chainLinkWireWeight == null){
				chainLinkWireWeight = 0.0
			}
			if(weldSideWireWeight == null){
				weldSideWireWeight = 0.0
			}
			
			println'wireDiameter '+wireDiameter
			println'meshWireWeight '+meshWireWeight
			println'chainLinkWireWeight '+chainLinkWireWeight
			println'weldSideWireWeight '+weldSideWireWeight
			
			def w = WireReceiptReporting.createCriteria()
			def wireReceiptList = w.list {
				
				eq("availabilityStatus",true)
				eq("wireBrand",wireBrandInstance)
				eq("wireDiameter",wireDiameter)
				
				projections {
					
					groupProperty("wireBrand")
					groupProperty("wireDiameter")
					sum("weightInStock")
				}
				
			}
			println 'wireReceiptList '+wireReceiptList
			
			def wireList = wireReceiptList.getAt(0)
			println'wireList '+wireList
			println'wireReceiptListSize() '+wireReceiptList.size()
			println'meshWireWeight'+meshWireWeight
			println'chainLinkWireWeight'+chainLinkWireWeight
			println'weldSideWireWeight'+weldSideWireWeight
			
			if(wireReceiptList.size() == 0) {
				println'wireOrderList '+wireOrderList
				def wireRequired = 0.0
				def wireAvaialble = 0.0
				def totalWire = 0.0
				
				wire[2] = (meshWireWeight)
				wire[3] = (chainLinkWireWeight)
				wire[4] = (weldSideWireWeight)
				wire[5] =(meshWireWeight+chainLinkWireWeight+weldSideWireWeight)
				wire[6] = wireAvaialble
				//if()
				wireRequired = (wireAvaialble-(meshWireWeight+chainLinkWireWeight+weldSideWireWeight))   
				wire[7] = wireRequired
				//wire[2] = wire2
				//wire[3] = wire3
				//wire[4] = (wire3 - wire2)
				//wire[4] = Math.abs(wire3 - wire2)
						
			} else {
			
				def wireRequired = 0.0
				def wireAvaialble = wireList.getAt(2)
			
				wire[2] = (meshWireWeight)
				wire[3] = (chainLinkWireWeight)
				wire[4] = (weldSideWireWeight)
				wire[5] = (meshWireWeight+chainLinkWireWeight+weldSideWireWeight)
				wire[6] = wireAvaialble
				wireRequired = (wireAvaialble+(meshWireWeight+chainLinkWireWeight+weldSideWireWeight))
				wire[7] = wireRequired
				/*def wire2 = wire[2].toBigDecimal()
				def wire3 = wireList.getAt(2)
				log.debug'wire3 '+wire3
				wire[3] = wire3
				wire[4] = (wire3 - wire2)
				//wire[4] = Math.abs(wire3 - wire2)
				log.debug'wire[4] '+wire[4]*/
				
			}
						
		}
		
		println'orderWireReq '+orderWireReq
		[wireRequiredList: orderWireReq.values()]		
	}
	
	def corderPayments() {
		
		def corderInstance = Corder.get(params.corder)
		log.debug"corderInstance "+corderInstance
		
		def c = CorderPayment.createCriteria()
		def corderPaymentList = c {
			eq("corder", corderInstance)
		}
		log.debug'corderPaymentList '+corderPaymentList
		[corderPaymentList: corderPaymentList, corderInstance: corderInstance]
	}
	
	@Secured(['ROLE_SALES'])
	def corderBySales() {
				
		User user = springSecurityService.currentUser
		log.debug'user '+user
		List corderInstanceList = Corder.findAllByCreatedBy(user)
		[corderInstanceList: corderInstanceList, corderInstanceTotal: corderInstanceList.size()]
	}
	
	def unBlockStock() {
		
		def corderInstance = Corder.get(params.id)
		log.debug'corderInstance '+corderInstance
		
		def stockOrderList = StockOrder.findAllByCorder(corderInstance)
		log.debug'stockOrderList '+stockOrderList
		
		def cageStockOrderList = CageStockOrder.findAllByCorder(corderInstance)
		log.debug'cageStockOrderList '+cageStockOrderList
		
		def chainLinkStockOrderList = ChainLinkStockOrder.findAllByCorder(corderInstance)
		
		def weldSideMeshStockOrderList = WeldSideMeshStockOrder.findAllByCorder(corderInstance)
		
		stockOrderList.each { stockOrderInstance ->
						
			def	stockInstance = stockOrderInstance.stock
			stockInstance.noOfInStock += stockOrderInstance.stockForOrder
			
			// if available status is false then make it true...if its already true then leave as it is
			log.debug'availabilityStatus '+stockInstance.availabilityStatus
			if(stockInstance.availabilityStatus == false) {
				stockInstance.availabilityStatus = true
			}
						
			// save stock and thats end of logic
			if (!stockInstance.save(flush: true)) {
				stockInstance.errors.each {
					log.error it
				}				
			}
			
			if (!stockOrderInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])
				redirect(action: "list")
				return
			}
	
			try {
				stockOrderInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), params.id])
				//redirect(action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'stockOrder.label', default: 'StockOrder'), params.id])
				redirect(action: "show", id: params.id)
			}						
			
		}	
		
		cageStockOrderList.each { cageStockOrderInstance ->
			
			def	cageStockInstance = cageStockOrderInstance.cageStock
			cageStockInstance.noOfInStock += cageStockOrderInstance.cageStockForOrder
			
			log.debug'availabilityStatus '+cageStockInstance.availabilityStatus
			if(cageStockInstance.availabilityStatus == false) {
				cageStockInstance.availabilityStatus = true
			}
						
			// save stock and thats end of logic
			if (!cageStockInstance.save(flush: true)) {
				cageStockInstance.errors.each {
					log.error it
				}
			}
			
			if (!cageStockOrderInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'cageStock.label', default: 'CageStock'), params.id])
				redirect(action: "list")
				return
			}
	
			try {
				cageStockOrderInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), params.id])
				//redirect(action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cageStockOrder.label', default: 'CageStockOrder'), params.id])
				redirect(action: "show", id: params.id)
			}
		}
		
		chainLinkStockOrderList.each { chainLinkStockOrderInstance ->
			
			def	chainLinkStockInstance = chainLinkStockOrderInstance.chainLinkStock
			chainLinkStockInstance.noOfInStock += chainLinkStockOrderInstance.chainLinkStockForOrder
			
			log.debug'availabilityStatus '+chainLinkStockInstance.availabilityStatus
			if(chainLinkStockInstance.availabilityStatus == false) {
				chainLinkStockInstance.availabilityStatus = true
			}
						
			// save stock and thats end of logic
			if (!chainLinkStockInstance.save(flush: true)) {
				chainLinkStockInstance.errors.each {
					log.error it
				}
			}
			
			if (!chainLinkStockInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'chainLinkStock.label', default: 'ChainLinkStock'), params.id])
				redirect(action: "list")
				return
			}
	
			try {
				chainLinkStockOrderInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), params.id])
				//redirect(action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'chainLinkStockOrder.label', default: 'ChainLinkStockOrder'), params.id])
				redirect(action: "show", id: params.id)
			}
		}
		
		weldSideMeshStockOrderList.each { weldSideMeshStockOrderInstance ->
			
			def	weldSideMeshStockInstance = weldSideMeshStockOrderInstance.weldSideMeshStock
			weldSideMeshStockInstance.noOfInStock += weldSideMeshStockOrderInstance.weldSideMeshStockForOrder
			
			log.debug'availabilityStatus '+weldSideMeshStockInstance.availabilityStatus
			if(weldSideMeshStockInstance.availabilityStatus == false) {
				weldSideMeshStockInstance.availabilityStatus = true
			}
						
			// save stock and thats end of logic
			if (!weldSideMeshStockInstance.save(flush: true)) {
				weldSideMeshStockInstance.errors.each {
					log.error it
				}
			}
			
			if (!weldSideMeshStockInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'weldSideMesh.label', default: 'WeldSideMesh'), params.id])
				redirect(action: "list")
				return
			}
	
			try {
				weldSideMeshStockOrderInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'WeldSideMeshStockOrder'), params.id])
				//redirect(action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'weldSideMeshStockOrder.label', default: 'weldSideMeshStockOrder'), params.id])
				redirect(action: "show", id: params.id)
			}
		}
		
		corderInstance.shippingStatus = Corder.STATUS_NEW
		if (!corderInstance.save(flush: true)) {
			redirect(action: "blockedOrders")
		}
		redirect(action: "list")
		
	}	
				
}	
