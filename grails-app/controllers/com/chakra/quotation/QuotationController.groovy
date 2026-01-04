package com.chakra.quotation

import java.math.RoundingMode

import grails.converters.*
// import grails.plugins.springsecurity.Secured

// import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.springframework.dao.DataIntegrityViolationException

import com.chakra.config.*
import com.chakra.customer.Customer
import com.chakra.enquiry.Enquiry
import com.chakra.notifications.Notification
import com.chakra.security.DummyUser
import com.chakra.service.FormulaService
import com.chakra.service.NotificationService

class QuotationController {
	
	
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	// def springSecurityService
		
	
	// @Secured(['ROLE_ADMIN', 'ROLE_SALES'])
    def index() {
        redirect(action: "list", params: params)
    }

	// @Secured(['ROLE_ADMIN','ROLE_SALES'])
	def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		//def quotationInstanceList = Quotation.findAllByStatusNotEqual("FAILED")
		//def ls = Quotation.executeQuery("from Quotation a",[max: params.max, offset: params.offset])
		def quotationInstanceList = Quotation.findAllByStatusNotEqual(Quotation.STATUS_FAILED, [max: params.max, offset: params.offset])
		//def totalCount = Quotation.executeQuery("Quotation Book a").size()
        [quotationInstanceList: quotationInstanceList, quotationInstanceTotal: Quotation.count()]
    }

	/*@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def quotation() {
		
		def quotationInstance = new Quotation()
		quotationInstance.properties = params
		if(!quotationInstance.customer) {
			flash.message = "Customer is not set"
			redirect(controller: "customer", action: "list")
		}
		def enquiryInstance = Enquiry.get(params.enquiry.id)
		log.debug'enquiryInstance '+enquiryInstance
		log.debug'status '+enquiryInstance.status
		
		if(enquiryInstance.status == 'REALIZED') {
			def quotationInstance = Quotation.findByEnquiry(enquiryInstance)
			log.debug'quotationInstance' +quotationInstance
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
		
		[quotationInstance: new Quotation(params), enquiryInstance: enquiryInstance]
    }*/
	
	// @Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def save() {
        def quotationInstance = new Quotation(params)
		def enquiryInstance = Enquiry.get(params.enquiry.id)
		log.debug'in save'
		log.debug'enquiryInstance '+enquiryInstance
		NotificationService notificationService = new NotificationService()
        def currentUser = DummyUser.get(1)
		quotationInstance.comments = "Created By "+currentUser.toString()+" "+new Date().format("dd/MM/yy-hh:mm")+"\n";
        
		if (quotationInstance.save(flush: true)) {
            //flash.message = "${message(code: 'default.created.message', args: [message(code: 'quotation.label', default: 'Quotation'), quotationInstance.id])}"
            //redirect(action: "show", id: quotationInstance.id)
			//quotationInstance = Quotation.get(params.id)
			//springSecurityService.currentUser
			if(quotationInstance.fulls == 0 && quotationInstance.halfs == 0) {
				flash.message = "Either fulls or halfs must be greater than zero"
				redirect(controller: "quotation", action: "create")
				
			}
			//def enquiryInstance = Enquiry.get(params.enquiry)
			//println'enquiryInstance '+enquiryInstance
						
			if(enquiryInstance != null) {
				if (enquiryInstance.save(flush: true))  {
					enquiryInstance.status = "REALIZED"
					enquiryInstance.comments = quotationInstance.quotationId+" "+ new Date().format("dd/MM/yy-hh:mm")+"\n";
					render(view: "createmodels", model: [quotationInstance: quotationInstance])
					return
				}
			}
			notificationService.addNotification(currentUser.toString(),Notification.NOTIFMSG_QUOTATION_GENERATED, true, ""+g.link(action:"list", controller:"quotation", id: quotationInstance.id) { quotationInstance.quotationId+"-"+quotationInstance.enquiry.enquiryId }, Notification.NOTIFTYPE_APP)
			notificationService.addSmsNotification(currentUser.toString(),Notification.NOTIFMSG_SMS_QUOTATION_CREATED+":"+quotationInstance.quotationId, true, Notification.NOTIFTYPE_SMS, quotationInstance.customer.mobileNumber)
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
        }
        else {
            render(view: "create", model: [quotationInstance: quotationInstance])
        }		
		
	}
	
	
	// @Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def addQuotationModel() {


		def quotationInstance = Quotation.get(params.quotation.id)
		log.debug 'quotationInstance '+quotationInstance
		if(!quotationInstance)
			flash.message = "Quotation not entered or not found"
		def cageDesignInstance = CageDesign.get(params.cageDesign.id)
		log.debug 'cageDesignInstance '+cageDesignInstance
		if(!cageDesignInstance)
			flash.message = "CageDesign not entered or not found"
		def taxationInstance = Taxation.get(params.taxation.id)
		log.debug 'taxationInstance '+taxationInstance
		if(!taxationInstance)
			flash.message = "TaxationKind not entered or not found"
			
			
			if(((params.meshOrder == null) && (params.cagePartOrder == null) && (params.chainLinkOrder == null) && (params.weldSideMeshOrder == null))) {
				println'in if block'
				flash.message = "Select one or more parts" 
				render(view: "createmodels", model: [quotationInstance: quotationInstance])
				return
				
			} else if(params.meshOrder == "on" && params.wireBrand.id == "null") {
				//println'in if block'
				flash.message = "Select WireBrand"
				render(view: "createmodels", model: [quotationInstance: quotationInstance])
				return
			} else if(params.cagePartOrder == "on")	{
				
				boolean cagePartSelected = false
				def cagePartSpecList = params.cagePartSpecification
				for(int i=0;(i<=cagePartSpecList.size()-1);i++)
				
								if (!(cagePartSpecList.getAt(i) ==  "null")) {
									cagePartSelected = true
									break
								}
				//}
				if (!cagePartSelected) {
					//println'in if block'
					flash.message = "Select atleast one cagepart"
					render(view: "createmodels", model: [quotationInstance: quotationInstance])
					return
				}
			} else if(params.chainLinkOrder == "on"){
			
				boolean linkMeshSelected = false
				//boolean wireBrandSelected = false
				for(int i=0; i<=5; i++) {
					
					def temp = params.('linkMesh['+i+']')
					if((temp !=null) && (temp.('id')!= "null") && (temp.('wireBrand')!= "null") ) {
												
						if (!(linkMeshSelected ==  "null")) {
							linkMeshSelected = true
							break
						}
					}
				}
				if (!linkMeshSelected) {
					//println'in if block'
					flash.message = "Select atleast one design and wirebrand in ChainLink"
					render(view: "createmodels", model: [quotationInstance: quotationInstance])
					return
				}
			} else if(params.weldSideMeshOrder == "on"){
			
				boolean weldSideMeshSelected = false
				//boolean wireBrandSelected = false
				for(int i=0; i<=5; i++) {
					
					def temp = params.('sideMesh['+i+']')
					if((temp !=null) && (temp.('id')!= "null") && (temp.('wireBrand')!= "null") ) {
												
						if (!(weldSideMeshSelected ==  "null")) {
							weldSideMeshSelected = true
							break
						}
					}
				}
				if (!weldSideMeshSelected) {
					//println'in if block'
					flash.message = "Select atleast one design and wirebrand in WeldSideMesh"
					render(view: "createmodels", model: [quotationInstance: quotationInstance])
					return
				}
			}	
			
		FormulaService formulaService = new FormulaService()

		def variables = ["cageLength": quotationInstance.cageLength, "fulls":quotationInstance.fulls,"halfs":quotationInstance.halfs,"noOfCuttingsInShed":quotationInstance.noOfCuttingsInShed,"tiers":quotationInstance.tiers
					,"noOfSingleBottomsPerSheet":cageDesignInstance.noOfSingleBottomsPerSheet,"noOfPartitionsPerSheetLength":cageDesignInstance.noOfPartitionsPerSheetLength,"sheetLength":cageDesignInstance.sheetLength]

		def doubleBox = ((( quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.fulls))
		def singleBox = (quotationInstance.cageLength/cageDesignInstance.sheetLength)*(quotationInstance.fulls)*((quotationInstance.tiers-1)*2)+((quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.halfs*quotationInstance.tiers)
		def noOfBirds = (doubleBox*2*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageDoubleBox)+(singleBox*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageSingleBox)

		def sheetSpecForList = cageDesignInstance.cageDesignSheetSpecFormula
		def totNoSheets = 0

		sheetSpecForList.each { sheetSpecFor ->

			def noOfSheets = formulaService.evalFormula(variables, sheetSpecFor.formula)
			log.debug'noOfSheets'+noOfSheets

			//totalWeight += noOfSheets * (sheetSpecFor.sheetSpecification.sheetWeight)

			totNoSheets += noOfSheets
		}

		QuotationMeshModel quotationMeshModel =  new QuotationMeshModel()

		BigDecimal meshCost = 0

		def taxPercent = taxationInstance.percent
		log.debug'taxPercent'+taxPercent
					
		log.debug 'meshOrder'+params.meshOrder

		if (params.meshOrder == "on") {

			def wireBrandInstance = WireBrand.get(params.wireBrand.id)
			
			def sheetSpecFormList = cageDesignInstance.cageDesignSheetSpecFormula
			def noSheetPerSheetSpec = 0
			def totMeshSheetCost = 0
			def meshSheetCost = 0
			def sheetSpecDiscount = 0
			def totSheetSpecDiscount = 0
			sheetSpecFormList.each { sheetSpecFor ->
				
				noSheetPerSheetSpec = formulaService.evalFormula(variables, sheetSpecFor.formula)
				log.debug'noSheetPerSheetSpec '+noSheetPerSheetSpec
				
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
					
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)) * noSheetPerSheetSpec)
					//sheetSpecDiscount = (crossWirePrice.sheetSpecDiscount/100)+(lineWirePrice1.sheetSpecDiscount/100)+(lineWirePrice2.sheetSpecDiscount/100)
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec) * (crossWirePrice.sheetSpecDiscount/100)) +( ((lineWireWeight2*lineWirePrice2.price) * noSheetPerSheetSpec )*(lineWirePrice2.sheetSpecDiscount/100))
					println'sheetSpecDiscount'+sheetSpecDiscount
					
					log.debug'meshSheetCost '+meshSheetCost
				} else if(sheetSpecFor.sheetSpecification.lineWireDiameter1 > 0) {
				
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec)
					//sheetSpecDiscount = (crossWirePrice.sheetSpecDiscount/100)+(lineWirePrice1.sheetSpecDiscount/100)
					log.debug'meshSheetCost '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec) * (crossWirePrice.sheetSpecDiscount/100))
					println'sheetSpecDiscount'+sheetSpecDiscount
				} /*else {
				
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice2.price)) * noSheetPerSheetSpec)
					//sheetSpecDiscount = (crossWirePrice.sheetSpecDiscount/100)+(lineWirePrice2.sheetSpecDiscount/100)
					log.debug'meshSheetCost '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice2.price)) * noSheetPerSheetSpec) * (crossWirePrice.sheetSpecDiscount/100))
					println'sheetSpecDiscount'+sheetSpecDiscount
				}*/
				
				totMeshSheetCost += meshSheetCost
				totSheetSpecDiscount += sheetSpecDiscount
				log.debug'totMeshSheetCost '+totMeshSheetCost
				QuotationMeshPart quotationMeshPart= new QuotationMeshPart()
				
					quotationMeshPart.wireBrand = wireBrandInstance
					quotationMeshPart.sheetSpecification = sheetSpecFor.sheetSpecification
					quotationMeshPart.noOfMeshParts = noSheetPerSheetSpec
					quotationMeshPart.meshCost = meshSheetCost
					quotationMeshPart.createdBy = quotationInstance.createdBy
					quotationMeshPart.createdDate = quotationInstance.createdDate
					quotationMeshPart.lastEditedBy = quotationInstance.lastEditedBy
					quotationMeshPart.editedDate = quotationInstance.lastEditedDate
	
					quotationMeshModel.addToQuotationMeshParts(quotationMeshPart)				
				
			}

			def c = CageDesignSheetSpecFormula.createCriteria()
			def sheetList = c.list{
				eq("cageDesign",cageDesignInstance)
			}
			
			meshCost = (totMeshSheetCost*quotationInstance.noOfSheds)
			//meshCost = (totMeshSheetCost*quotationInstance.noOfSheds)
			log.debug'Mesh cost: '+meshCost
			
			//def meshDiscount = (meshCost*sheetSpecDiscount)
			//meshCost = meshCost_1-totSheetSpecDiscount
			
			def meshDiscountPercent = ((totSheetSpecDiscount*100)/meshCost)
			quotationMeshModel.meshCost = meshCost
			quotationMeshModel.singleBox = singleBox
			quotationMeshModel.noOfBirds = noOfBirds
			quotationMeshModel.doubleBox = doubleBox
			quotationMeshModel.costPerBird = (meshCost/noOfBirds)
			quotationMeshModel.cageDesign = cageDesignInstance
			quotationMeshModel.wireBrand = wireBrandInstance
			quotationMeshModel.meshDiscount = totSheetSpecDiscount
			quotationMeshModel.meshDiscountPercent = meshDiscountPercent
			quotationMeshModel.netMeshCost = (meshCost-totSheetSpecDiscount)
			
			quotationInstance.isMeshQuotation = true
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}

		} else {
		
			//quotationMeshModel = null
			quotationInstance.isMeshQuotation = false
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		
		}

		QuotationModel quotationModel = new QuotationModel()
		
		QuotationCagePartModel quotationCagePartModel = new QuotationCagePartModel()

		quotationModel.quotationCageParts = new ArrayList()

		BigDecimal cagePartsTotalCost = 0
		log.debug "params "+params

		def cagePartSpecList = params.cagePartSpecification
		println 'cagePartSpecList '+cagePartSpecList

		if (params.cagePartOrder == "on") {

			for(int i=0;(i<=cagePartSpecList.size()-1);i++) {

				if (!(cagePartSpecList.getAt(i) ==  "null")) {

					println'cagePartSpecList.getAt(i)'+cagePartSpecList.getAt(i)
					CagePartSpecification cagePartSpecification = CagePartSpecification.get(cagePartSpecList.getAt(i))
					println "cagePartSpecification "+cagePartSpecification
					def cagePartSpecFormulaList = cagePartSpecification.cagePartSpecFormulaList
					println'cagePartSpecFormulaList '+cagePartSpecFormulaList
					cagePartSpecFormulaList.each { cagePartSpecFormula ->
						println "cagePartType.formula "+cagePartSpecFormula.formula
						def noOfParts = formulaService.evalFormula(variables, cagePartSpecFormula.formula)
						println 'noOfParts '+noOfParts
						println''+cagePartSpecFormula.cagePart+':'+noOfParts


						QuotationCagePart quotationCagePart = new QuotationCagePart()

						quotationCagePart.noOfCageParts = noOfParts
						quotationCagePart.cagePartSpecFormula = cagePartSpecFormula


						List cagePartPriceList = CagePartPrice.findAllByCagePart(cagePartSpecFormula.cagePart)
						println'cagePartPrice'+cagePartPriceList
						/*if(!cagePartPriceList)
					 flash.message = "Cagepart price not found"
					 if(cagePartPriceList.size() > 0)
					 flash.message = "More than one Cagepart price found"*/

						CagePartPrice cagePartPrice = cagePartPriceList.get(0)

						quotationCagePart.priceOfEachCagePart = cagePartPrice.price
						quotationCagePart.costOfCagePart = (quotationCagePart.noOfCageParts * quotationCagePart.priceOfEachCagePart)
						cagePartsTotalCost += quotationCagePart.costOfCagePart
						//quotationModel.quotationCageParts.add(quotationCagePart)
						quotationCagePartModel.addToQuotationCageParts(quotationCagePart)
										

					}

				}
			}

			println "cagePartsTotalCost "+ cagePartsTotalCost
			cagePartsTotalCost = cagePartsTotalCost*quotationInstance.noOfSheds
			println "cagePartsTotalCost "+ cagePartsTotalCost
			
			quotationCagePartModel.cageDesign = cageDesignInstance
			quotationCagePartModel.costPerBird = (cagePartsTotalCost)/noOfBirds
			quotationCagePartModel.noOfBirds = noOfBirds
			quotationCagePartModel.cagePartCost = cagePartsTotalCost
			
			quotationInstance.isCageQuotation = true
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}

		} else {
		
			//quotationCagePartModel = null
			quotationInstance.isCageQuotation = false
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		}
		
		QuotationChainLinkModel quotationChainLinkModel = new QuotationChainLinkModel()
		
		QuotationChainLink quotationChainLink =null
		
		BigDecimal chainLinkCost = 0
		BigDecimal chainLinkDiscount = 0
		
		if(params.chainLinkOrder == "on") {
			
			for(int i=0; i<=5; i++) {
								
				def temp = params.('linkMesh['+i+']')
				println'temp '+temp
				if((temp !=null) && (temp.('id')!= "null")) {
					def linkMesh = temp.('id')
					log.debug'linkMesh '+linkMesh
					def wireBrand = temp.('wireBrand')
					def length = temp.('length1').toBigDecimal()
					def height = temp.('height').toBigDecimal()
					def noOfPieces = temp.('noOfPieces').toBigDecimal()
					def linkMeshInstance = LinkMesh.get(linkMesh)
					println'linkMeshInstance '+linkMeshInstance
					def wireDiameter = linkMeshInstance.wireDiameter
					def wireWeight = linkMeshInstance.weight
					def wireBrandInstance = WireBrand.get(wireBrand)
					def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, wireDiameter)
					println'wirePrice '+wirePrice.price
					//wirePriceDiscount = wirePrice.chainLinkDiscount
					def squareFeet = (length*height*noOfPieces)
					println'squareFeet '+squareFeet
					
					def pricePerSqFt = (wireWeight*wirePrice.price)
					println'pricePerSqFt '+pricePerSqFt
					
					def chainLinkItemCost = (squareFeet*pricePerSqFt)
					println'chainLinkItemCost '+chainLinkItemCost
					chainLinkDiscount += (wirePrice.chainLinkDiscount/100)*(chainLinkItemCost)
					chainLinkCost += chainLinkItemCost
					
					quotationChainLink = new QuotationChainLink()
					
					quotationChainLink.linkMesh = linkMeshInstance
					quotationChainLink.wireBrand = wireBrandInstance
					quotationChainLink.length = length
					quotationChainLink.height = height
					quotationChainLink.noOfPieces = noOfPieces
					quotationChainLink.squareFeets = squareFeet
					quotationChainLink.pricePerSqFt = pricePerSqFt
					quotationChainLink.chainLinkItemCost = chainLinkItemCost
					quotationChainLinkModel.addToQuotationChainLinkItems(quotationChainLink)
					
				}
				println'chainLinkCost '+chainLinkCost
				
			}
			
			def chainLinkDiscountPercent = ((chainLinkDiscount*100)/chainLinkCost)
			
			quotationChainLinkModel.chainLinkCost = chainLinkCost
			quotationChainLinkModel.chainLinkDiscount = chainLinkDiscount
			quotationChainLinkModel.chainLinkDiscountPercent = chainLinkDiscountPercent
			quotationChainLinkModel.netChainLinkCost = (chainLinkCost-chainLinkDiscount)			
			
			quotationInstance.isChainLinkQuotation = true
			
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
			
		} else {
		
			//quotationChainLinkModel = null
			quotationInstance.isChainLinkQuotation = false
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		}
		
		QuotationWeldSideModel quotationWeldSideModel =  new QuotationWeldSideModel()
		QuotationWeldSide quotationWeldSide =null
		
		BigDecimal weldSideCost = 0
		BigDecimal weldSideDiscount = 0
		
		if(params.weldSideMeshOrder == "on") {
			
			for(int i=0; i<=5; i++) {
				
				def temp = params.('sideMesh['+i+']')
				log.debug'temp '+temp
				if((temp !=null) && (temp.('id')!= "null")) {
					def sideMesh = temp.('id')
					log.debug'sideMesh '+sideMesh
					def wireBrand = temp.('wireBrand')
					def length = temp.('length1').toBigDecimal()
					def height = temp.('height').toBigDecimal()
					def noOfPieces = temp.('noOfPieces').toBigDecimal()
					def sideMeshInstance = SideMesh.get(sideMesh)
					log.debug'sideMeshInstance '+sideMeshInstance
					def wireDiameter = sideMeshInstance.wireDiameter
					def wireWeight = sideMeshInstance.weight
					def wireBrandInstance = WireBrand.get(wireBrand)
					def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, wireDiameter)
					log.debug'wirePrice '+wirePrice.price
					def squareFeet = (length*height*noOfPieces)
					log.debug'squareFeet '+squareFeet
					
					def pricePerSqFt = (wireWeight*wirePrice.price)
					log.debug'pricePerSqFt '+pricePerSqFt
					
					def weldSideItemCost = (squareFeet*pricePerSqFt)
					log.debug'weldSideItemCost '+weldSideItemCost
					weldSideDiscount += (wirePrice.weldSideMeshDiscount/100)*(weldSideItemCost)
					weldSideCost += weldSideItemCost
					
					quotationWeldSide = new QuotationWeldSide()
					
					quotationWeldSide.sideMesh = sideMeshInstance
					quotationWeldSide.wireBrand = wireBrandInstance
					quotationWeldSide.length = length
					quotationWeldSide.height = height
					quotationWeldSide.noOfPieces = noOfPieces
					quotationWeldSide.squareFeets = squareFeet
					quotationWeldSide.pricePerSqFt = pricePerSqFt
					quotationWeldSide.weldSideItemCost = weldSideItemCost
					quotationWeldSideModel.addToQuotationWeldSideItems(quotationWeldSide)
					
				}
				log.debug'weldSideCost '+weldSideCost
				
			}
			
			def weldSideDiscountPercent = ((weldSideDiscount*100)/weldSideCost)
			
			quotationWeldSideModel.weldSideCost = weldSideCost
			quotationWeldSideModel.weldSideDiscount = weldSideDiscount
			quotationWeldSideModel.weldSideDiscountPercent = weldSideDiscountPercent
			quotationWeldSideModel.netWeldSideCost = (weldSideCost-weldSideDiscount)
			
			quotationInstance.isWeldSideMeshQuotation = true
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
			
		} else {
			
			//quotationWeldSideModel	= null
			quotationInstance.isWeldSideMeshQuotation = false
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		}
		
		BigDecimal cost = meshCost+cagePartsTotalCost+chainLinkCost+weldSideCost
		BigDecimal tax = ((taxPercent/100)*cost)
		log.debug'TAX: '+tax
		log.debug'COST '+cost
		quotationModel.cost = cost
		quotationModel.tax = tax
		quotationModel.noOfBirds = noOfBirds
		quotationModel.totalCost =cost+tax
		quotationModel.costPerBird = ((cost+tax)/noOfBirds)
		quotationModel.cageDesign = cageDesignInstance
		quotationModel.taxation = taxationInstance
		quotationModel.quotationMeshModel = quotationMeshModel
		quotationModel.quotationCagePartModel = quotationCagePartModel
		quotationModel.quotationChainLinkModel = quotationChainLinkModel
		quotationModel.quotationWeldSideModel = quotationWeldSideModel

		log.debug "quotationmodel "+quotationModel

		quotationInstance.quotationModels.add(quotationModel)
				
		if (quotationInstance.save(flush: true)) {
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
		else {
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
		
	}
	
	
	/*def createQuotation() {
		
		println'params '+params
		def cageDesignInstance = CageDesign.get(params.cageDesign)
		def wireBrandInstance = WireBrand.get(params.wireBrand)
		def taxationInstance = Taxation.get(params.taxation)
		def cagePartSpecList = params.cagePartSpecList
		def cageLength = params.cageLength.toBigDecimal()
		def fulls = params.fulls.toBigDecimal()
		println'fulls '+fulls
		def halfs = params.halfs.toBigDecimal()
		def tiers = params.tiers.toBigDecimal()
		def noOfCuttingsInShed = params.noOfCuttingsInShed.toBigDecimal()
		def noOfSheds = params.noOfSheds.toBigDecimal()
		
		//[quotationInstance: new Quotation(params), cageDesign: cageDesignInstance, wireBrand: wireBrandInstance, taxation: taxationInstance, noOfBirds: noOfBirds, cost:cost, tax: tax, totalCost: totalCost, cagePartSpecList: cagePartSpecList]
		
		FormulaService formulaService = new FormulaService()
		
		def variables = ["cageLength":cageLength, "fulls":fulls,"halfs":halfs,"noOfCuttingsInShed":noOfCuttingsInShed,"tiers":tiers
					,"noOfSingleBottomsPerSheet":cageDesignInstance.noOfSingleBottomsPerSheet,"noOfPartitionsPerSheetLength":cageDesignInstance.noOfPartitionsPerSheetLength,"sheetLength":cageDesignInstance.sheetLength]

		def doubleBox = ((( cageLength/cageDesignInstance.sheetLength)*fulls))
		def singleBox = (cageLength/cageDesignInstance.sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/cageDesignInstance.sheetLength)*halfs*tiers)
		def noOfBirds = (doubleBox*2*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageDoubleBox)+(singleBox*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageSingleBox)
		println'noOfBirds '+noOfBirds
		
		BigDecimal meshCost = 0
		def noSheetPerSheetSpec = 0
		def totMeshSheetCost = 0
		def meshSheetCost = 0
		def sheetSpecDiscount = 0
		def totSheetSpecDiscount = 0
		def netMeshCost = 0
			
		def sheetSpecForList = cageDesignInstance.cageDesignSheetSpecFormula
		println'sheetSpecForList '+sheetSpecForList
		sheetSpecForList.each { sheetSpecFor ->
			
			noSheetPerSheetSpec = formulaService.evalFormula(variables, sheetSpecFor.formula)
			println'noSheetPerSheetSpec '+noSheetPerSheetSpec
			
			BigDecimal noOfCrossWires = (sheetSpecFor.sheetSpecification.length/sheetSpecFor.sheetSpecification.pitch)+1
			BigDecimal crossWireLength = noOfCrossWires*(sheetSpecFor.sheetSpecification.width+(2*sheetSpecFor.sheetSpecification.projection))
			BigDecimal lineWireLength1 = (sheetSpecFor.sheetSpecification.length+sheetSpecFor.sheetSpecification.pitch)*sheetSpecFor.sheetSpecification.noOfLineWires1
			BigDecimal lineWireLength2 = (sheetSpecFor.sheetSpecification.length+sheetSpecFor.sheetSpecification.pitch)*sheetSpecFor.sheetSpecification.noOfLineWires2
			
			BigDecimal crossWireWeight = ((crossWireLength/6588)*(sheetSpecFor.sheetSpecification.crossWireDiameter*sheetSpecFor.sheetSpecification.crossWireDiameter))
			BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(sheetSpecFor.sheetSpecification.lineWireDiameter1*sheetSpecFor.sheetSpecification.lineWireDiameter1))
			BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(sheetSpecFor.sheetSpecification.lineWireDiameter2*sheetSpecFor.sheetSpecification.lineWireDiameter2))
			
			println'crossWireDiameter '+sheetSpecFor.sheetSpecification.crossWireDiameter
			println'lineWireDiameter1 '+sheetSpecFor.sheetSpecification.lineWireDiameter1
			println'lineWireDiameter2 '+sheetSpecFor.sheetSpecification.lineWireDiameter2
			
			println'crossWireWeight'+crossWireWeight
			println'lineWireWeight1'+lineWireWeight1
			println'lineWireWeight2'+lineWireWeight2
			
			def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecFor.sheetSpecification.crossWireDiameter)
			def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecFor.sheetSpecification.lineWireDiameter1)
			def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecFor.sheetSpecification.lineWireDiameter2)
							
			if(sheetSpecFor.sheetSpecification.lineWireDiameter1 > 0 && sheetSpecFor.sheetSpecification.lineWireDiameter2 > 0) {
				
				meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)) * noSheetPerSheetSpec)
				//sheetSpecDiscount = (crossWirePrice.sheetSpecDiscount/100)+(lineWirePrice1.sheetSpecDiscount/100)+(lineWirePrice2.sheetSpecDiscount/100)
				sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec) * (crossWirePrice.sheetSpecDiscount/100)) +( ((lineWireWeight2*lineWirePrice2.price) * noSheetPerSheetSpec )*(lineWirePrice2.sheetSpecDiscount/100))
				println'sheetSpecDiscount'+sheetSpecDiscount
				
				println'meshSheetCost '+meshSheetCost
			} else if(sheetSpecFor.sheetSpecification.lineWireDiameter1 > 0) {
			
				meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec)
				//sheetSpecDiscount = (crossWirePrice.sheetSpecDiscount/100)+(lineWirePrice1.sheetSpecDiscount/100)
				println'meshSheetCost '+meshSheetCost
				sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec) * (crossWirePrice.sheetSpecDiscount/100))
				println'sheetSpecDiscount'+sheetSpecDiscount
			}
			totMeshSheetCost += meshSheetCost
			totSheetSpecDiscount += sheetSpecDiscount
			println'totMeshSheetCost '+totMeshSheetCost
				
		}

		
		meshCost = (totMeshSheetCost*noOfSheds)
		println'Mesh cost: '+meshCost
		
		def meshDiscountPercent = ((totSheetSpecDiscount*100)/meshCost)
		netMeshCost = (meshCost-totSheetSpecDiscount)
		
		BigDecimal cagePartsTotalCost = 0
				
		for(int i=0;(i<=cagePartSpecList.size()-1);i++) {
			
			if (!(cagePartSpecList.getAt(i) ==  "null")) {
	
				println'cagePartSpecList.getAt(i)'+cagePartSpecList.getAt(i)
				CagePartSpecification cagePartSpecification = CagePartSpecification.get(cagePartSpecList.getAt(i))
				println "cagePartSpecification "+cagePartSpecification
				def cagePartSpecFormulaList = cagePartSpecification.cagePartSpecFormulaList
				println'cagePartSpecFormulaList '+cagePartSpecFormulaList
				cagePartSpecFormulaList.each { cagePartSpecFormula ->
					println "cagePartType.formula "+cagePartSpecFormula.formula
					def noOfParts = formulaService.evalFormula(variables, cagePartSpecFormula.formula)
					println 'noOfParts '+noOfParts
					println''+cagePartSpecFormula.cagePart+':'+noOfParts
	
	
					QuotationCagePart quotationCagePart = new QuotationCagePart()
	
					quotationCagePart.noOfCageParts = noOfParts
					quotationCagePart.cagePartSpecFormula = cagePartSpecFormula
	
	
					List cagePartPriceList = CagePartPrice.findAllByCagePart(cagePartSpecFormula.cagePart)
					println'cagePartPrice'+cagePartPriceList
					
					CagePartPrice cagePartPrice = cagePartPriceList.get(0)
	
					quotationCagePart.priceOfEachCagePart = cagePartPrice.price
					quotationCagePart.costOfCagePart = (quotationCagePart.noOfCageParts * quotationCagePart.priceOfEachCagePart)
					cagePartsTotalCost += quotationCagePart.costOfCagePart
					
				}
	
			}
		}
	
		println "cagePartsTotalCost "+ cagePartsTotalCost
		cagePartsTotalCost = cagePartsTotalCost*noOfSheds
		println "cagePartsTotalCost "+ cagePartsTotalCost
		
		def taxPercent = taxationInstance.percent
		BigDecimal cost = cagePartsTotalCost+netMeshCost
		BigDecimal tax = ((taxPercent/100)*cost)
		BigDecimal totalCost = (cost+tax)
		BigDecimal costPerBird = (totalCost/noOfBirds)
		println'cost '+cost
		println'tax '+tax
		println'totalCost '+totalCost
		
		def quotationPlannerSpecs = ["cageLength":cageLength,"noOfCuttingsInShed":noOfCuttingsInShed,"noOfSheds":noOfSheds,"fulls":fulls,"halfs":halfs,"tiers":tiers]
		
		def quotationPalnnerModelInfo = ["cageDesign":cageDesignInstance.toString(),"noOfBirds":noOfBirds,"cost":cost,"tax":tax,"totalCost":totalCost,
			
			"modelInfo":[
				"meshPartsDetails":["model":["cageDesign":cageDesignInstance.toString(),"wireBrand":wireBrandInstance.toString(),"singleBox":singleBox,"doubleBox":doubleBox,"costPerBird":costPerBird,"noOfBirds":noOfBirds,"meshCost":meshCost],
					"parts":["rows":"meshParts","meshCost":meshCost,"meshDiscountPercent":meshDiscountPercent,"meshDiscount":totSheetSpecDiscount,"netMeshCost":netMeshCost],
				],
				"cagePartsDetails":["model":["cageDesign":cageDesignInstance.toString(),"costPerBird":costPerBird,"noOfBirds":noOfBirds,"cagePartCost":cagePartsTotalCost],
					"parts":["rows":"cageParts","cagePartCost":cagePartsTotalCost]
				]
			]	
		]
		render(view: "quotation", model: [quotationPlannerSpecs: quotationPlannerSpecs, quotationPalnnerModelInfo:quotationPalnnerModelInfo as JSON])
	}
	*/
	
	
	def saveQuotation() {
		
		log.debug'In Save'
		log.debug'params' +params
		
		def quotationInstance = new Quotation(params)
		def cageDesignInstance = CageDesign.get(params.cageDesign)
		log.debug 'cageDesignInstance '+cageDesignInstance
		def taxationInstance = Taxation.get(params.taxation)
		log.debug 'taxationInstance '+taxationInstance
		NotificationService notificationService = new NotificationService()
		
		def currentUser = DummyUser.get(1)
		quotationInstance.comments = "Created By "+currentUser.toString()+" "+new Date().format("dd/MM/yy-hh:mm")+"\n";
		
		if (!quotationInstance.save(flush: true)) {
			quotationInstance.errors.each {
				log.error it
			}
		} else {
             render(view: "createmodels", model: [quotationInstance: quotationInstance])
        }
	}
}
