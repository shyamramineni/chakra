package com.chakra.quotation

import java.math.RoundingMode

import grails.converters.*
import grails.plugins.springsecurity.Secured

import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.springframework.dao.DataIntegrityViolationException

import com.chakra.config.*
import com.chakra.customer.Customer
import com.chakra.enquiry.Enquiry
import com.chakra.notifications.Notification
import com.chakra.security.User
import com.chakra.service.FormulaService
import com.chakra.service.NotificationService

class QuotationController {
	
	
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService
		
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
    def index() {
        redirect(action: "list", params: params)
    }

	@Secured(['ROLE_ADMIN','ROLE_SALES'])
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
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def save() {
        def quotationInstance = new Quotation(params)
		def enquiryInstance = Enquiry.get(params.enquiry.id)
		log.debug'in save'
		log.debug'enquiryInstance '+enquiryInstance
		NotificationService notificationService = new NotificationService()
		quotationInstance.comments = "Created By "+springSecurityService.currentUser.toString()+" "+new Date().format("dd/MM/yy-hh:mm")+"\n";
        
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
			notificationService.addNotification(springSecurityService.currentUser.toString(),Notification.NOTIFMSG_QUOTATION_GENERATED, true, ""+g.link(action:"list", controller:"quotation", id: quotationInstance.id) { quotationInstance.quotationId+"-"+quotationInstance.enquiry.enquiryId }, Notification.NOTIFTYPE_APP)
			notificationService.addSmsNotification(springSecurityService.currentUser.toString(),Notification.NOTIFMSG_SMS_QUOTATION_CREATED+":"+quotationInstance.quotationId, true, Notification.NOTIFTYPE_SMS, quotationInstance.customer.mobileNumber)
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
        }
        else {
            render(view: "create", model: [quotationInstance: quotationInstance])
        }		
		
	}
	
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
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
	
	
	def saveQuotation() {
		
		log.debug'In Save'
		log.debug'params' +params
		
		def quotationInstance = new Quotation(params)
		def cageDesignInstance = CageDesign.get(params.cageDesign)
		log.debug 'cageDesignInstance '+cageDesignInstance
		def taxationInstance = Taxation.get(params.taxation)
		log.debug 'taxationInstance '+taxationInstance
		NotificationService notificationService = new NotificationService()
				
		quotationInstance.comments = "Created By "+springSecurityService.currentUser.toString()+" "+new Date().format("dd/MM/yy-hh:mm")+"\n";
		
		if (!quotationInstance.save(flush: true)) {
			quotationInstance.errors.each {
				log.error it
			}
		}
		
		FormulaService formulaService = new FormulaService()
		
		def variables = ["cageLength": quotationInstance.cageLength, "fulls":quotationInstance.fulls,"halfs":quotationInstance.halfs,"noOfCuttingsInShed":quotationInstance.noOfCuttingsInShed,"tiers":quotationInstance.tiers
			,"noOfSingleBottomsPerSheet":cageDesignInstance.noOfSingleBottomsPerSheet,"noOfPartitionsPerSheetLength":cageDesignInstance.noOfPartitionsPerSheetLength,"sheetLength":cageDesignInstance.sheetLength]
		
		def doubleBox = ((( quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.fulls))
		def singleBox = (quotationInstance.cageLength/cageDesignInstance.sheetLength)*(quotationInstance.fulls)*((quotationInstance.tiers-1)*2)+((quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.halfs*quotationInstance.tiers)
		def noOfBirds = (doubleBox*2*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageDoubleBox)+(singleBox*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageSingleBox)
		
		def sheetSpecForList = cageDesignInstance.cageDesignSheetSpecFormula
		def totalWeight = 0
		
		sheetSpecForList.each { sheetSpecFor ->
		
			def noOfSheets = formulaService.evalFormula(variables, sheetSpecFor.formula)
			log.debug'noOfSheets'+noOfSheets
		
			totalWeight += noOfSheets * (sheetSpecFor.sheetSpecification.sheetWeight)
		
			// totNoSheets += noOfSheets
		}
		
		QuotationMeshModel quotationMeshModel =  new QuotationMeshModel()
		
		BigDecimal meshCost = 0
		
		def taxPercent = taxationInstance.percent
		log.debug'taxPercent'+taxPercent
		
			def wireBrandInstance = WireBrand.get(params.wireBrand)
			
			def w = WirePrice.createCriteria()
			def priceList = w.get{
				
				eq("wireBrand",wireBrandInstance)
			}
			println'wireBrandInstance '+wireBrandInstance
		
			BigDecimal wirePrice = priceList.price
		
			println'brandPrice'+wirePrice
		
			def sheetSpecFormList = cageDesignInstance.cageDesignSheetSpecFormula
			def noSheetPerSheetSpec = 0
			def totMeshSheetCost = 0
			def meshSheetCost = 0
		
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
					log.debug'meshSheetCost '+meshSheetCost
				} else if(sheetSpecFor.sheetSpecification.lineWireDiameter1 > 0) {
				
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec)
					log.debug'meshSheetCost '+meshSheetCost
				} else {
				
				meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice2.price)) * noSheetPerSheetSpec)
				log.debug'meshSheetCost '+meshSheetCost
				}
				
				totMeshSheetCost += meshSheetCost
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
			log.debug'Mesh cost: '+meshCost
		
			quotationMeshModel.meshCost = meshCost
			quotationMeshModel.singleBox = singleBox
			quotationMeshModel.noOfBirds = noOfBirds
			quotationMeshModel.doubleBox = doubleBox
			quotationMeshModel.costPerBird = (meshCost/noOfBirds)
			quotationMeshModel.cageDesign = cageDesignInstance
			quotationMeshModel.wireBrand = wireBrandInstance
		
		QuotationModel quotationModel = new QuotationModel()
		
		QuotationCagePartModel quotationCagePartModel = new QuotationCagePartModel()
		
		quotationModel.quotationCageParts = new ArrayList()
		
		BigDecimal cagePartsTotalCost = 0
		log.debug "params "+params
		
		def cagePartSpecList = params.cagePartSpecList
		log.debug 'cagePartSpecList '+cagePartSpecList
		
		if(cagePartSpecList != null) {
		
			for(int i=0;(i<=cagePartSpecList.size()-1);i++){
		
				if (!(cagePartSpecList.getAt(i) ==  "null")) {
		
					log.debug'cagePartSpecList.getAt(i)'+cagePartSpecList.getAt(i)
					CagePartSpecification cagePartSpecification = CagePartSpecification.get(cagePartSpecList.getAt(i))
					log.debug "cagePartSpecification "+cagePartSpecification
					def cagePartSpecFormulaList = cagePartSpecification.cagePartSpecFormulaList
					cagePartSpecFormulaList.each { cagePartSpecFormula ->
						log.debug "cagePartType.formula "+cagePartSpecFormula.formula
						def noOfParts = formulaService.evalFormula(variables, cagePartSpecFormula.formula)
						log.debug 'noOfParts '+noOfParts
						log.debug''+cagePartSpecFormula.cagePartSpecName+':'+noOfParts
						
						QuotationCagePart quotationCagePart = new QuotationCagePart()
		
						quotationCagePart.noOfCageParts = noOfParts
						quotationCagePart.cagePartSpecFormula = cagePartSpecFormula
		
						List cagePartPriceList = CagePartPrice.findAllByCagePartSpecFormula(cagePartSpecFormula)
						log.debug'cagePartPrice'+cagePartPriceList
						
						CagePartPrice cagePartPrice = cagePartPriceList.get(0)
		
						quotationCagePart.priceOfEachCagePart = cagePartPrice.price
						quotationCagePart.costOfCagePart = (quotationCagePart.noOfCageParts * quotationCagePart.priceOfEachCagePart)
						cagePartsTotalCost += quotationCagePart.costOfCagePart
						
						quotationCagePartModel.addToQuotationCageParts(quotationCagePart)
										
					}
		
				}
			}
		}
			
		
		log.debug "cagePartsTotalCost "+ cagePartsTotalCost
		cagePartsTotalCost = cagePartsTotalCost*quotationInstance.noOfSheds
		log.debug "cagePartsTotalCost "+ cagePartsTotalCost
		
		quotationCagePartModel.cageDesign = cageDesignInstance
		quotationCagePartModel.costPerBird = (cagePartsTotalCost)/noOfBirds
		quotationCagePartModel.noOfBirds = noOfBirds
		quotationCagePartModel.cagePartCost = cagePartsTotalCost
		
		BigDecimal cost = meshCost+cagePartsTotalCost
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
		
		log.debug "quotationmodel "+quotationModel
						
		quotationInstance.addToQuotationModels(quotationModel)
				
		if (quotationInstance.save(flush: true)) {
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
		else {
			render(view: "createQuotation", model: [quotationInstance: quotationInstance])
		}				
				
	}*/
	
	
	def quotationCart() {
	
	}
	
	def sheetPrices() {
		
		log.debug'params'+params
		
		List sheetSpecFormulaList = new ArrayList()
		List cagePartTypeList_2 = new ArrayList()
		List cageDesignSheetSpecFormulaList = new ArrayList()
		List cagePartSpecFormulaList_1 = new ArrayList()
		List cagePartSpecificationList_1 = new ArrayList()
		List cagePartList = new ArrayList()
				
		cageDesignSheetSpecFormulaList = params.cageDesignSheetSpecFormula
		def sheetQuantityList = params.sheetQuantity
		log.debug'cageDesignSheetSpecFormulaList '+cageDesignSheetSpecFormulaList
		log.debug'sheetQuantityList '+sheetQuantityList
		def cagePartSpecFormulaList = params.cagePartSpecFormula
		def cagePartTypeList = params.cagePartType
		def cagePartSpecificationList = params.cagePartSpecification
		def cageQuantityList = params.cageQuantity
		log.debug'cagePartTypeList '+cagePartTypeList
		log.debug'cageQuantityList '+cageQuantityList
		def customerInstance = Customer.get(params.customer.id)
		log.debug'customerInstance '+customerInstance
		def cageDesignInstance = CageDesign.get(params.cageDesign.id)
		log.debug'cageDesignInstance '+cageDesignInstance
		def wireBrandInstance = WireBrand.get(params.wireBrand.id)
		log.debug'wireBrandInstance '+wireBrandInstance
		def taxationInstance = Taxation.get(params.taxation.id)
		log.debug'taxationInstance '+taxationInstance
		
		def c1 = CageDesignSheetSpecFormula.createCriteria()
		def cageDesignSheetSpecFormulaList_1 = c1.list {
			
			eq("cageDesign",cageDesignInstance)
			
		}
		log.debug'cageDesignSheetSpecFormulaList_1 '+cageDesignSheetSpecFormulaList_1
		
		BigDecimal sheetWeight = 0
		BigDecimal sheetPrice = 0
		
		List sheetPriceList = new ArrayList()
		List cagePartPriceList = new ArrayList()
							
		if(cageDesignSheetSpecFormulaList != null) {
				
			for(int i=0;(i<=cageDesignSheetSpecFormulaList.size()-1);i++) {
				
				def cageDesignSheetSpecFormula = cageDesignSheetSpecFormulaList.getAt(i)
				log.debug'cageDesignSheetSpecFormula '+cageDesignSheetSpecFormula
				def sheetSpecFormula = CageDesignSheetSpecFormula.get(cageDesignSheetSpecFormula)
				log.debug'sheetSpecFormula '+sheetSpecFormula
					
				if(sheetSpecFormula != null) {
					
					BigDecimal noOfCrossWires = (sheetSpecFormula.sheetSpecification.length/sheetSpecFormula.sheetSpecification.pitch)+1
					BigDecimal crossWireLength = noOfCrossWires*(sheetSpecFormula.sheetSpecification.width+(2*sheetSpecFormula.sheetSpecification.projection))
					BigDecimal lineWireLength1 = (sheetSpecFormula.sheetSpecification.length+sheetSpecFormula.sheetSpecification.pitch)*sheetSpecFormula.sheetSpecification.noOfLineWires1
					BigDecimal lineWireLength2 = (sheetSpecFormula.sheetSpecification.length+sheetSpecFormula.sheetSpecification.pitch)*sheetSpecFormula.sheetSpecification.noOfLineWires2
					
					BigDecimal crossWireWeight = ((crossWireLength/6588)*(sheetSpecFormula.sheetSpecification.crossWireDiameter*sheetSpecFormula.sheetSpecification.crossWireDiameter))
					BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(sheetSpecFormula.sheetSpecification.lineWireDiameter1*sheetSpecFormula.sheetSpecification.lineWireDiameter1))
					BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(sheetSpecFormula.sheetSpecification.lineWireDiameter2*sheetSpecFormula.sheetSpecification.lineWireDiameter2))
					
					log.debug'crossWireDiameter '+sheetSpecFormula.sheetSpecification.crossWireDiameter
					log.debug'lineWireDiameter1 '+sheetSpecFormula.sheetSpecification.lineWireDiameter1
					log.debug'lineWireDiameter2 '+sheetSpecFormula.sheetSpecification.lineWireDiameter2
					
					log.debug'crossWireWeight'+crossWireWeight
					log.debug'lineWireWeight1'+lineWireWeight1
					log.debug'lineWireWeight2'+lineWireWeight2
					
					def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecFormula.sheetSpecification.crossWireDiameter)
					def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecFormula.sheetSpecification.lineWireDiameter1)
					def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecFormula.sheetSpecification.lineWireDiameter2)
					
					def sheetQuantity = sheetQuantityList.getAt(i)
					log.debug'sheetQuantity '+sheetQuantity
					sheetQuantity = sheetQuantity.toBigDecimal()
					
					if(sheetSpecFormula.sheetSpecification.lineWireDiameter1 > 0 && sheetSpecFormula.sheetSpecification.lineWireDiameter2 > 0) {
						
						sheetPrice = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)) * sheetQuantity)
						log.debug'meshSheetCost '+sheetPrice
					} else if(sheetSpecFormula.sheetSpecification.lineWireDiameter1 > 0) {
					
						sheetPrice = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * sheetQuantity)
						log.debug'meshSheetCost '+sheetPrice
					} else {
					
						sheetPrice = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice2.price)) * sheetQuantity)
						log.debug'meshSheetCost '+sheetPrice
					}
										
					log.debug'sheetPrice '+sheetPrice
					sheetPriceList.add(sheetPrice)
					sheetSpecFormulaList.add(sheetSpecFormula)
				} else {
				
					sheetPriceList.add(null)
					sheetSpecFormulaList.add(null)
				}
			
			}
			log.debug'sheetPriceList '+sheetPriceList
			log.debug'cageDesignSheetSpecFormulaList '+cageDesignSheetSpecFormulaList
			log.debug'sheetQuantityList'+sheetQuantityList
			log.debug'sheetSpecFormulaList'+sheetSpecFormulaList
		}
		
		def cagePartSpecificationList_2 = CagePartSpecification.findAll()
		log.debug'cagePartSpecificationList_2 '+cagePartSpecificationList_2
		
		def cagePartSpecFormulaList_2 = CagePartSpecFormula.findAll()
		log.debug'cagePartSpecFormulaList_2 '+cagePartSpecFormulaList_2
		
		def cagePartTypeList_1 = CagePartType.findAll()
		log.debug'cagePartTypeList_1 '+cagePartTypeList_1
		
		if(cagePartSpecFormulaList != null) {
				
			for(int i=0;(i<=cagePartSpecFormulaList.size()-1);i++) {
				
				BigDecimal totalCostOfCagePart = 0
				def cagePartSpecFormula = cagePartSpecFormulaList.getAt(i)
				log.debug'cagePartSpecFormula' +cagePartSpecFormula
				if(cagePartSpecFormula != "null") {
									
					def cagePartSpecFormulaInstance = CagePartSpecFormula.get(cagePartSpecFormula)
					log.debug'cagePartSpecFormulaInstance '+cagePartSpecFormulaInstance
					def cagePartType = cagePartTypeList.getAt(i)
					def cagePartTypeInstance = CagePartType.get(cagePartType)
					log.debug'cagePartTypeInstance '+cagePartTypeInstance
					def cagePartSpecification = cagePartSpecificationList.getAt(i)
					def cagePartSpecificationInstance = CagePartSpecification.get(cagePartSpecification)
					log.debug'cagePartSpecificationInstance '+cagePartSpecificationInstance
					def cagePartInstance = CagePartPrice.get(cagePartSpecFormula)
					log.debug'cagePartInstance '+cagePartInstance
					def cagePartPrice = cagePartInstance.price
					log.debug'cagePartPrice '+cagePartPrice
					def cageQuantity = cageQuantityList.getAt(i)
					log.debug'cageQuantity '+cageQuantity
					def cageQuantity_1 = cageQuantity.toBigDecimal()
					def costOfCagePart = (cageQuantity_1 * cagePartPrice)
					log.debug'costOfCagePart '+costOfCagePart
					totalCostOfCagePart  += costOfCagePart
					log.debug'totalCostOfCagePart '+totalCostOfCagePart
					
					cagePartTypeList_2.add(cagePartTypeInstance)
					cagePartSpecificationList_1.add(cagePartSpecificationInstance)
					cagePartPriceList.add(totalCostOfCagePart)
					cagePartSpecFormulaList_1.add(cagePartSpecFormulaInstance)
														
					
				} else {
					
					cagePartTypeList_2.add(null)
					cagePartSpecificationList_1.add(null)
					cagePartPriceList.add(null)
					cagePartSpecFormulaList_1.add(null)
				}
			
			}
			log.debug'sheetPriceList '+sheetPriceList
			log.debug'sheetQuantityList '+sheetQuantityList
			log.debug'cagePartPriceList '+cagePartPriceList
			log.debug'cagePartTypeList '+cagePartTypeList
			log.debug'cagePartTypeList '+cagePartTypeList
			log.debug'cagePartSpecificationList_1 '+cagePartSpecificationList_1
			log.debug'cageQuantityList '+cageQuantityList
			log.debug'cagePartTypeList_2 '+cagePartTypeList_2
		}
		
		render(view: "quotationCart", model: [customerInstance: customerInstance, cageDesignInstance: cageDesignInstance, wireBrandInstance: wireBrandInstance, taxationInstance: taxationInstance, cageDesignSheetSpecFormulaList: cageDesignSheetSpecFormulaList, sheetQuantityList: sheetQuantityList, sheetPriceList: sheetPriceList, cagePartTypeList: cagePartTypeList, cageQuantityList: cageQuantityList, cagePartPriceList: cagePartPriceList, cagePartSpecificationList_1: cagePartSpecificationList_1, cagePartList: cagePartList, sheetSpecFormulaList: sheetSpecFormulaList, cageDesignSheetSpecFormulaList_1: cageDesignSheetSpecFormulaList_1, cagePartTypeList_1: cagePartTypeList_1, cagePartTypeList_2: cagePartTypeList_2, cagePartSpecificationList_2: cagePartSpecificationList_2, cagePartSpecFormulaList_1: cagePartSpecFormulaList_1, cagePartSpecFormulaList_2: cagePartSpecFormulaList_2])

	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def createQuotationCart() {
		
		log.debug'params'+params
		def customerInstance = Customer.get(params.customer.id)
		log.debug'customerInstance'+customerInstance
		def wireBrandInstance = WireBrand.get(params.wireBrand.id)
		log.debug'wireBrandInstance'+wireBrandInstance
		def cageDesignInstance = CageDesign.get(params.cageDesign.id)
		log.debug'cageDesignInstance'+cageDesignInstance
		def taxationInstance = Taxation.get(params.taxation.id)
		log.debug'taxationInstance'+taxationInstance
		def meshPartList = params.meshList
		log.debug'meshPartList'+meshPartList
		def cageParSpecFormulaList = params.cageParSpecFormulaList
		log.debug'cageParSpecFormulaList'+cageParSpecFormulaList
		def meshQuantityList = params.meshQuantityList
		log.debug'meshQuantityList'+meshQuantityList
		def cageQuantityList = params.cageQuantityList
		log.debug'cageQuantityList'+cageQuantityList
		def meshPriceList = params.meshPriceList
		log.debug'meshPriceList'+meshPriceList
		def cagePartPriceList = params.cagePartPriceList
		log.debug'cagePartPriceList'+cagePartPriceList
		
		def quotationInstance = new Quotation(params)
		quotationInstance.customer = customerInstance
		
		if (!quotationInstance.save()) {
			quotationInstance.errors.each {
				log.error it
			}
		}
		log.debug'quotationInstance '+quotationInstance
		
		QuotationModel quotationModel = new QuotationModel()
		
		QuotationMeshModel quotationMeshModel =  null
				
		QuotationMeshPart quotationMeshPart = null
		
		BigDecimal meshCost = 0
		BigDecimal cageCost = 0 
		def taxPercent = taxationInstance.percent
		log.debug'taxPercent'+taxPercent
					
		if(meshPartList != null) {
			quotationMeshModel = new QuotationMeshModel()
			for(int i=0;(i<=meshPartList.size()-1);i++) {
			
				def meshPart = meshPartList.getAt(i)
				
				log.debug'meshPart '+meshPart
				log.debug'meshQuantityList '+meshQuantityList
				log.debug'meshQuantityList.size() '+meshQuantityList.size()
				def meshQuantity = meshQuantityList.getAt(i)
				log.debug'meshPartQuantity '+meshQuantity
				def meshPartPrice = meshPriceList.getAt(i)
				log.debug'meshPartPrice '+meshPartPrice
				def sheetSpec = SheetSpecification.get(meshPart)
				log.debug'sheetSpec '+sheetSpec
				if(sheetSpec != null) {
					quotationMeshPart = new QuotationMeshPart()
					quotationMeshPart.sheetSpecification = sheetSpec
					quotationMeshPart.noOfMeshParts = meshQuantity.toBigDecimal() 
					quotationMeshPart.meshCost = meshPartPrice.toBigDecimal()
					meshCost += meshPartPrice.toBigDecimal()
					log.debug'meshCost '+meshCost
					quotationMeshPart.wireBrand = wireBrandInstance
					quotationMeshPart.createdBy = quotationInstance.createdBy
					quotationMeshPart.createdDate = quotationInstance.createdDate
					quotationMeshPart.lastEditedBy = quotationInstance.lastEditedBy
					quotationMeshPart.editedDate = quotationInstance.lastEditedDate
					
					quotationMeshModel.addToQuotationMeshParts(quotationMeshPart)
				
				}
			}
			quotationMeshModel.meshCost = meshCost
			quotationMeshModel.cageDesign = cageDesignInstance
			quotationMeshModel.wireBrand = wireBrandInstance
		}						
		QuotationCagePartModel quotationCagePartModel = null
		QuotationCagePart quotationCagePart = null
		
		if(cageParSpecFormulaList != null) {
			quotationCagePartModel = new QuotationCagePartModel()
			for(int i=0;(i<=cageParSpecFormulaList.size()-1);i++) {
				
				def cagePartSpecFormula = cageParSpecFormulaList.getAt(i)
				log.debug'cagePartSpecFormula '+cagePartSpecFormula
				
				if(cagePartSpecFormula != "") {
					
					def cagePartSpecFormulaInstance = CagePartSpecFormula.get(cagePartSpecFormula)
					def cageQuantity = cageQuantityList.getAt(i)
					log.debug'cagePartQuantity '+cageQuantity
					def cageQuantity_1 = cageQuantity.toBigDecimal()
					def cagePartCost = cagePartPriceList.getAt(i)
					log.debug'cagePartCost '+cagePartCost
					def cagePartCost_1 = cagePartCost.toBigDecimal()
					def cagePartPriceInstance = CagePartPrice.get(cagePartSpecFormula.cagePart)
					log.debug'cagePartPriceInstance '+cagePartPriceInstance
					def cagePartPrice = cagePartPriceInstance.price
					log.debug'cagePartPrice '+cagePartPrice
										
					quotationCagePart = new QuotationCagePart()
					quotationCagePart.cagePartSpecFormula = cagePartSpecFormulaInstance
					quotationCagePart.priceOfEachCagePart = cagePartPrice
					
					quotationCagePart.noOfCageParts = cageQuantity_1
					quotationCagePart.costOfCagePart = cagePartCost_1
					cageCost += cagePartCost_1
					
					quotationCagePartModel.addToQuotationCageParts(quotationCagePart)
				}
			}		
			quotationCagePartModel.cageDesign = cageDesignInstance
			quotationCagePartModel.cagePartCost = cageCost
			
		}
		
		BigDecimal cost = meshCost+cageCost
		BigDecimal tax = ((taxPercent/100)*cost)
		log.debug'TAX: '+tax
		log.debug'COST '+cost
		quotationModel.cost = cost
		quotationModel.tax = tax
		quotationModel.totalCost =cost+tax
		quotationModel.cageDesign = cageDesignInstance
		quotationModel.taxation = taxationInstance
		quotationModel.quotationMeshModel = quotationMeshModel
		quotationModel.quotationCagePartModel = quotationCagePartModel
		
		log.debug "quotationmodel "+quotationModel

		quotationInstance.addToQuotationModels(quotationModel)
		
		//notificationService.addSmsNotification(Notification.NOTIFMSG_SMS_QUOTATION_CREATED+":"+quotationInstance.quotationId, true, Notification.NOTIFTYPE_SMS, quotationInstance.customer.mobileNumber)
		if (quotationInstance.save(flush: true)) {
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
		else {
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
		
	}		
	
	/*@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def show() {
        def quotationInstance = Quotation.get(params.id)
        if (!quotationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
            redirect(action: "list")
            return
        }
		

        [quotationInstance: quotationInstance]
    }*/
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def quotationModelShow() {
		//def quotationInstance = Quotation.get(params.id)
		//println'quotation'+params.quotation
		//println'quotationMeshModel'+params.quotationMeshModel
		//println'quotationCagePart'+params.quotationCagePart
		def quotationInstance = Quotation.get(params.quotation)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
		//def quotationMeshModelInstance = QuotationMeshModel.get(params.quotationMeshModel)
		//def quotationCagePartInstance = QuotationCagePart.get(params.quotationCagePart)
		if (!quotationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
			redirect(action: "list")
			return
		}
		if (!quotationModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'quotation Model'), params.id])
			redirect(action: "list")
			return
		}
		

		[quotationInstance: quotationInstance, quotationModelInstance: quotationModelInstance]
	}

	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def edit() {
        def quotationInstance = Quotation.get(params.id)
        if (!quotationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
            redirect(action: "list")
            return
        }
		/*println'quotationInstance '+quotationInstance.status
		if(quotationInstance.status == "REALIZED") {
			render(view: "createModel", model: [quotationInstance: quotationInstance])
			
		} else*/
		render(view: "createmodels", model: [quotationInstance: quotationInstance])
        //[quotationInstance: quotationInstance]
    }

	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def update() {
        def quotationInstance = Quotation.get(params.id)
        if (!quotationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationInstance.version > version) {
                quotationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotation.label', default: 'Quotation')] as Object[],
                          "Another user has updated this Quotation while you were editing")
                render(view: "edit", model: [quotationInstance: quotationInstance])
                return
            }
        }

        quotationInstance.properties = params
		quotationInstance.comments = params.comments+" "+"Edited By "+springSecurityService.currentUser.toString()+'-'+new Date().format("dd/MM/yy-hh:mm")+"</br>"

        if (!quotationInstance.save(flush: true)) {
            render(view: "edit", model: [quotationInstance: quotationInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotation.label', default: 'Quotation'), quotationInstance.id])
        redirect(action: "show", id: quotationInstance.id)
    }
	
	@Secured(['ROLE_ADMIN'])
	def delete() {
        def quotationInstance = Quotation.get(params.id)
        if (!quotationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
            redirect(action: "list")
            return
        }

        try {
            quotationInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def editMeshModel() {
		
        def quotationInstance = Quotation.get(params.quotation)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
		
        if (!quotationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
            redirect(action: "list")
            return
        }
		render(view: "editMeshModel", model: [quotationInstance: quotationInstance, quotationModelInstance: quotationModelInstance])
        //[quotationInstance: quotationInstance]
    }
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def updateMeshModel() {
		println'params '+params
		def quotationMeshModelInstance = QuotationMeshModel.get(params.id)
		def quotationInstance = Quotation.get(params.quotation)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
		def taxPercent = quotationModelInstance.taxation.percent
		log.debug'tax '+taxPercent
		def wireBrandInstance = quotationModelInstance.quotationMeshModel.wireBrand
		log.debug'wireBrandInstance '+wireBrandInstance
		def addValue = params.addValue.toBigDecimal()
		def description = params.description
		println'addValue '+addValue
		println'description '+description
				
        if (!quotationMeshModelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (quotationMeshModelInstance.version > version) {
                quotationMeshModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel')] as Object[],
                          "Another user has updated this QuotationMeshModel while you were editing")
                render(view: "editMeshModel", model: [quotationMeshModelInstance: quotationMeshModelInstance])
                return
            }
        }
        quotationMeshModelInstance.properties = params 
		def quotationMeshPartsList = quotationMeshModelInstance.quotationMeshParts
		log.debug'quotationMeshPartsList '+quotationMeshPartsList
				
		BigDecimal meshCost = 0
		def totMeshSheetCost = 0
		def meshSheetCost = 0
		def sheetSpecDiscount = 0 
		def totSheetSpecDiscount = 0
		
		quotationMeshPartsList.each { sheetSpecFor ->
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
				sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts) * (crossWirePrice.sheetSpecDiscount/100)) +( ((lineWireWeight2*lineWirePrice2.price) * noOfMeshParts)*(lineWirePrice2.sheetSpecDiscount/100))
			} else if(sheetSpecFor.sheetSpecification.lineWireDiameter1 > 0) {
			
				meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts)
				log.debug'meshSheetCost '+meshSheetCost
				sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts) * (crossWirePrice.sheetSpecDiscount/100))
			} else {
			
			meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice2.price)) * noOfMeshParts)
			log.debug'meshSheetCost '+meshSheetCost
			}
			
			totMeshSheetCost += meshSheetCost
			log.debug'totMeshSheetCost '+totMeshSheetCost
			totSheetSpecDiscount += sheetSpecDiscount
						
		}
		meshCost = (totMeshSheetCost*quotationInstance.noOfSheds)				
		log.debug'Mesh cost: '+meshCost
		
		BigDecimal meshCostPerBird = (meshCost/quotationModelInstance.noOfBirds)
		
		def meshDiscountPercent = ((totSheetSpecDiscount*100)/meshCost)
		def netMeshCost = (meshCost-totSheetSpecDiscount)+(addValue)

        quotationMeshModelInstance.meshCost = meshCost
		quotationMeshModelInstance.costPerBird = meshCostPerBird
		quotationMeshModelInstance.addValue = addValue
		quotationMeshModelInstance.description = description
		quotationMeshModelInstance.meshDiscount = totSheetSpecDiscount
		quotationMeshModelInstance.meshDiscountPercent = meshDiscountPercent
		quotationMeshModelInstance.netMeshCost = netMeshCost
		
		if (!quotationMeshModelInstance.save(flush: true)) {
			quotationMeshModelInstance.errors.allErrors.each {
				log.error it
			}
            render(view: "editMeshModel", model: [quotationMeshModelInstance: quotationMeshModelInstance])
            return
        }
		
		BigDecimal cagePartCost = quotationModelInstance?.quotationCagePartModel?.cagePartCost
		BigDecimal chainLinkCost = quotationModelInstance?.quotationChainLinkModel?.netChainLinkCost
		BigDecimal weldSideMeshCost = quotationModelInstance?.quotationWeldSideModel?.netWeldSideCost
		println'cagePartCost '+cagePartCost
		
		BigDecimal totalCost = 0
		totalCost = netMeshCost+cagePartCost+chainLinkCost+weldSideMeshCost
		
		def tax = ((taxPercent/100)*totalCost)
		log.debug'tax ' +tax
		BigDecimal finalCost = totalCost + tax
		log.debug'finalCost '+finalCost
		BigDecimal costPerBird = (finalCost/quotationModelInstance.noOfBirds)
		quotationModelInstance.cost = totalCost
		quotationModelInstance.tax = tax
		quotationModelInstance.totalCost = finalCost		
		quotationModelInstance.costPerBird = costPerBird
		
		if (!quotationModelInstance.save(flush: true)) {
			quotationModelInstance.errors.allErrors.each {
				log.error it
			}
			render(view: "editMeshModel", model: [quotationMeshModelInstance: quotationMeshModelInstance])
			return
		}
		
		log.debug'test'

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), quotationMeshModelInstance.id])
        redirect(controller: "quotation", action: "quotationModelShow", params: [quotation: params.quotation, quotationModel: params.quotationModel])
    }
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def editCageModel() {
		
		def quotationInstance = Quotation.get(params.quotation)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
		if (!quotationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
			redirect(action: "list")
			return
		}
		render(view: "editCageModel", model: [quotationInstance: quotationInstance, quotationModelInstance: quotationModelInstance])
		
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def updateCageModel() {
		def quotationCageModelInstance = QuotationCagePartModel.get(params.id)
		def quotationInstance = Quotation.get(params.quotation)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
		
		def taxPercent = quotationModelInstance.taxation.percent
		log.debug'tax '+taxPercent
				
		if (!quotationCageModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationCagePartModel.label', default: 'QuotationCagePartModel'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (quotationCageModelInstance.version > version) {
				quotationCageModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'quotationCagePartModel.label', default: 'QuotationCagePartModel')] as Object[],
						  "Another user has updated this QuotationCagePartModel while you were editing")
				render(view: "editMeshModel", model: [quotationCageModelInstance: quotationCageModelInstance])
				return
			}
		}
		quotationCageModelInstance.properties = params
		def quotationCagePartsList = quotationCageModelInstance.quotationCageParts
				
		BigDecimal totalCagePartCost = 0
		
		quotationCagePartsList.each { cagePart ->
			def noOfCagePart = cagePart.noOfCageParts
			def cagePartCost = cagePart.priceOfEachCagePart
			
			totalCagePartCost += (noOfCagePart*cagePartCost)
			log.debug'totalCagePartCost'+totalCagePartCost
						
		}
		totalCagePartCost = (totalCagePartCost*quotationInstance.noOfSheds)
				
		log.debug'totalCagePartCost: '+totalCagePartCost
		
		BigDecimal cageCostPerBird = (totalCagePartCost/quotationModelInstance.noOfBirds)

        quotationCageModelInstance.cagePartCost = totalCagePartCost
		quotationCageModelInstance.costPerBird = cageCostPerBird

		if (!quotationCageModelInstance.save(flush: true)) {
			
			render(view: "editCageModel", model: [quotationCageModelInstance: quotationCageModelInstance])
			return
		}
		
		BigDecimal meshCost = quotationModelInstance?.quotationMeshModel?.netMeshCost
		BigDecimal chainLinkCost = quotationModelInstance?.quotationChainLinkModel?.netChainLinkCost
		BigDecimal weldSideCost = quotationModelInstance?.quotationWeldSideModel?.netWeldSideCost
		log.debug'meshCost '+meshCost
		BigDecimal totalCost = meshCost+totalCagePartCost+chainLinkCost+weldSideCost
		def tax = ((taxPercent/100)*totalCost)
		log.debug'tax ' +tax
		BigDecimal finalCost = totalCost + tax
		log.debug'finalCost '+finalCost
		BigDecimal costPerBird = (finalCost/quotationModelInstance.noOfBirds)
		quotationModelInstance.cost = totalCost
		quotationModelInstance.tax = tax
		quotationModelInstance.totalCost = finalCost
		quotationModelInstance.costPerBird = costPerBird
		
		if (!quotationCageModelInstance.save(flush: true)) {
			quotationCageModelInstance.errors.allErrors.each {
				log.error it
			}
			render(view: "editCageModel", model: [quotationCageModelInstance: quotationCageModelInstance])
			return
		}
		
		log.debug'test'

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationCageModel.label', default: 'QuotationCageModel'), quotationCageModelInstance.id])
		//redirect(action: "quotationModelShow", id: quotationMeshModelInstance.id)
		redirect(controller: "quotation", action: "quotationModelShow", params: [quotation: params.quotation, quotationModel: params.quotationModel])
	}
	
	def editChainLinkModel() {
		def quotationInstance = Quotation.get(params.quotation)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
		if (!quotationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
			redirect(action: "list")
			return
		}
		render(view: "editChainLinkModel", model: [quotationInstance: quotationInstance, quotationModelInstance: quotationModelInstance])
	}

	def updateChainLinkModel() {
		println'params'+params
		def quotationChainLinkModelInstance = QuotationChainLinkModel.get(params.id)
		def quotationInstance = Quotation.get(params.quotation)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
		
		def taxPercent = quotationModelInstance.taxation.percent
		
		if (!quotationChainLinkModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (quotationChainLinkModelInstance.version > version) {
				quotationChainLinkModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel')] as Object[],
						  "Another user has updated this QuotationChainLinkModel while you were editing")
				render(view: "edit", model: [quotationChainLinkModelInstance: quotationChainLinkModelInstance])
				return
			}
		}

		quotationChainLinkModelInstance.properties = params
		
		def quotationChainLinkItemList = quotationChainLinkModelInstance.quotationChainLinkItems
		BigDecimal chainLinkCost = 0
		BigDecimal totChainLinkCost = 0
		BigDecimal chainLinkDiscount = 0
		BigDecimal totChainLinkDiscount = 0
		
		quotationChainLinkItemList.each { chainLink ->
			def wireBrandInstance = chainLink.wireBrand
			def linkMeshInstance = chainLink.linkMesh
			def length = chainLink.length
			def height = chainLink.height
			def noOfPieces = chainLink.noOfPieces
			def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, linkMeshInstance.wireDiameter)
			def chainLinkItemCost = (length*height*noOfPieces*wirePrice.price*linkMeshInstance.weight)
			println'chainLinkItemCost'+chainLinkItemCost
			chainLinkDiscount = (((wirePrice.chainLinkDiscount)/100)*chainLinkItemCost)
			totChainLinkCost += chainLinkItemCost
			totChainLinkDiscount += chainLinkDiscount
			
		}
		
		chainLinkCost = (totChainLinkCost*quotationInstance.noOfSheds)
		log.debug'ChainLink Cost: '+chainLinkCost
				
		def chainLinkDiscountPercent = ((totChainLinkDiscount*100)/chainLinkCost)
		
		quotationChainLinkModelInstance.chainLinkCost = chainLinkCost
		quotationChainLinkModelInstance.chainLinkDiscount = chainLinkDiscount
		quotationChainLinkModelInstance.chainLinkDiscountPercent = chainLinkDiscountPercent
		quotationChainLinkModelInstance.netChainLinkCost = (chainLinkCost-chainLinkDiscount)
		if (!quotationChainLinkModelInstance.save(flush: true)) {
			render(view: "editChainLinkModel", model: [quotationChainLinkModelInstance: quotationChainLinkModelInstance])
			return
		}
		
		BigDecimal meshCost = quotationModelInstance?.quotationMeshModel?.netMeshCost
		BigDecimal cageCost = quotationModelInstance?.quotationCagePartModel?.cagePartCost
		BigDecimal weldSideCost = quotationModelInstance?.quotationWeldSideModel?.netWeldSideCost
		println'meshCost '+meshCost
		BigDecimal totalCost = meshCost+cageCost+chainLinkCost+weldSideCost
		def tax = ((taxPercent/100)*totalCost)
		log.debug'tax ' +tax
		BigDecimal finalCost = totalCost + tax
		log.debug'finalCost '+finalCost
		BigDecimal costPerBird = (finalCost/quotationModelInstance.noOfBirds)
		quotationModelInstance.cost = totalCost
		quotationModelInstance.tax = tax
		quotationModelInstance.totalCost = finalCost
		quotationModelInstance.costPerBird = costPerBird
		
		if (!quotationChainLinkModelInstance.save(flush: true)) {
			quotationChainLinkModelInstance.errors.allErrors.each {
				log.error it
			}
			render(view: "editChainLinkModel", model: [quotationChainLinkModelInstance: quotationChainLinkModelInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), quotationChainLinkModelInstance.id])
		redirect(controller: "quotation", action: "quotationModelShow", params: [quotation: params.quotation, quotationModel: params.quotationModel])
	}
	
	def editWeldSideModel() {
		
		def quotationInstance = Quotation.get(params.quotation)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
		
		def taxPercent = quotationModelInstance.taxation.percent
		
		if (!quotationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotation.label', default: 'Quotation'), params.id])
			redirect(action: "list")
			return
		}
		render(view: "editWeldSideModel", model: [quotationInstance: quotationInstance, quotationModelInstance: quotationModelInstance])
	}

	def updateWeldSideModel() {
		def quotationWeldSideModelInstance = QuotationWeldSideModel.get(params.id)
		def quotationInstance = Quotation.get(params.quotation)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
		
		def taxPercent = quotationModelInstance.taxation.percent
		
		if (!quotationWeldSideModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (quotationWeldSideModelInstance.version > version) {
				quotationWeldSideModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel')] as Object[],
						  "Another user has updated this QuotationWeldSideModel while you were editing")
				render(view: "edit", model: [quotationWeldSideModelInstance: quotationWeldSideModelInstance])
				return
			}
		}

		quotationWeldSideModelInstance.properties = params
		
		def quotationWeldSideItemList = quotationWeldSideModelInstance.quotationWeldSideItems
		BigDecimal weldSideCost = 0
		BigDecimal totWeldSideCost = 0
		BigDecimal weldSideDiscount = 0
		BigDecimal totWeldSideDiscount = 0
		
		quotationWeldSideItemList.each { weldSide ->
			def wireBrandInstance = weldSide.wireBrand
			def weldSideInstance = weldSide.sideMesh
			def length = weldSide.length
			def height = weldSide.height
			def noOfPieces = weldSide.noOfPieces
			def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, weldSideInstance.wireDiameter)
			def weldSideItemCost = (length*height*noOfPieces*wirePrice.price*weldSideInstance.weight)
			println'weldSideItemCost '+weldSideItemCost
			weldSideDiscount = (((wirePrice.weldSideMeshDiscount)/100)*weldSideItemCost)
			totWeldSideCost += weldSideItemCost
			totWeldSideDiscount += weldSideDiscount
			
		}
		
		weldSideCost = (totWeldSideCost*quotationInstance.noOfSheds)
		log.debug'WeldSide Cost: '+weldSideCost
				
		def weldSideDiscountPercent = ((totWeldSideDiscount*100)/weldSideCost)
		
		quotationWeldSideModelInstance.weldSideCost = weldSideCost
		quotationWeldSideModelInstance.weldSideDiscount = weldSideDiscount
		quotationWeldSideModelInstance.weldSideDiscountPercent = weldSideDiscountPercent
		quotationWeldSideModelInstance.netWeldSideCost = (weldSideCost-weldSideDiscount)
		if (!quotationWeldSideModelInstance.save(flush: true)) {
			render(view: "editChainLinkModel", model: [quotationWeldSideModelInstance: quotationWeldSideModelInstance])
			return
		}
		
		BigDecimal meshCost = quotationModelInstance?.quotationMeshModel?.netMeshCost
		BigDecimal cageCost = quotationModelInstance?.quotationCagePartModel?.cagePartCost
		BigDecimal chainLinkCost = quotationModelInstance?.quotationChainLinkModel?.netChainLinkCost
		println'meshCost '+meshCost
		BigDecimal totalCost = meshCost+cageCost+chainLinkCost+weldSideCost
		def tax = ((taxPercent/100)*totalCost)
		log.debug'tax ' +tax
		BigDecimal finalCost = totalCost + tax
		log.debug'finalCost '+finalCost
		BigDecimal costPerBird = (finalCost/quotationModelInstance.noOfBirds)
		quotationModelInstance.cost = totalCost
		quotationModelInstance.tax = tax
		quotationModelInstance.totalCost = finalCost
		quotationModelInstance.costPerBird = costPerBird
		
		if (!quotationWeldSideModelInstance.save(flush: true)) {
			quotationWeldSideModelInstance.errors.allErrors.each {
				log.error it
			}
			render(view: "editWeldSideModel", model: [quotationWeldSideModelInstance: quotationWeldSideModelInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'quotationWeldSideModelInstance.label', default: 'QuotationWeldSideModel'), quotationWeldSideModelInstance.id])
		redirect(controller: "quotation", action: "quotationModelShow", params: [quotation: params.quotation, quotationModel: params.quotationModel])
	}	
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def search() {
		
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_SALES'])
	def searchResults() {
				
		def q = Quotation.createCriteria()
		def quotationInstanceList = q {
			
				le("createdDate",params.createdDate) 
				ge("lastEditedDate",params.lastEditedDate) 
			
			//order("startDate", "desc")
		}
		
		log.debug "Final quotationInstanceList.size() "+quotationInstanceList.size()
				
		[quotationInstanceList: quotationInstanceList, quotationInstanceTotal: quotationInstanceList.size()]
		
	}
	
	@Secured(['ROLE_ADMIN'])
	def cancelQuotation() {
		
		def quotationInstance = Quotation.get(params.quotation)
		log.debug'quotationInstance '+quotationInstance
		[quotationInstance: quotationInstance]		
	}
	
	def cancelQuotationReason() {
		log.debug'params '+params
		def quotationInstance = Quotation.get(params.quotation.id)
		log.debug'quotationInstance '+quotationInstance
		def quotationFailedComments = params.quotationFailedComments
		log.debug'quotationFailedComments '+quotationFailedComments
		def quotationFailedReasonInstance = QuotationFailedReason.get(params.quotationFailedReason.id)
		log.debug'quotationFailedReasonInstance '+quotationFailedReasonInstance
		quotationInstance.quotationFailedReason = quotationFailedReasonInstance
		quotationInstance.quotationFailedComments = quotationFailedComments
		quotationInstance.status = Quotation.STATUS_FAILED
		if(!quotationInstance.save(flush: true)) {
			render(view: "cancelQuotation", model: [quotationInstance: quotationInstance])
			return
		}
		
		NotificationService notificationService = new NotificationService()
		notificationService.addNotification(springSecurityService.currentUser.toString(), Notification.NOTIFMSG_QUOTATION_CANCELLED, true, ""+g.link(action:"show", controller:"quotation", id: quotationInstance.id) { quotationInstance.quotationId }, Notification.NOTIFTYPE_APP)
		redirect(action: "show", id: quotationInstance.id)
		
	}
	
	@Secured(['ROLE_ADMIN'])
	def cancelledQuotations() {
		List quotationInstanceList = Quotation.findAllByStatus("FAILED")
		log.debug'quotationInstanceList '+quotationInstanceList
		[quotationInstanceList: quotationInstanceList, quotationInstanceTotal: quotationInstanceList.size()]
	}
	
	@Secured(['ROLE_SALES'])
	def quotationBySales() {
				
		User user = springSecurityService.currentUser
		log.debug'user '+user
		List quotationInstanceList = Quotation.findAllByCreatedBy(user)
		[quotationInstanceList: quotationInstanceList, quotationInstanceTotal: quotationInstanceList.size()]
	}
	
	def reValidate() {
		
		def quotationInstance = Quotation.get(params.id)
		log.debug'quotationInstance '+quotationInstance
		def quotationModelList = quotationInstance.quotationModels
		log.debug'quotationModelList '+quotationModelList
		
		QuotationModel quotationModel = null
		
		for(int j=0;(j<=quotationModelList.size()-1);j++) {
			
			BigDecimal meshCost = 0
			BigDecimal cagePartsTotalCost = 0
			def taxPercent = 0
			//def noOfBirds = 0
			def cageDesignInstance = quotationInstance.quotationModels.cageDesign[0]
			log.debug'cageDesignInstance '+cageDesignInstance
			def wireBrandInstance = null
			def taxationInstance = quotationInstance.quotationModels.taxation[0]
			log.debug'taxationInstance '+taxationInstance
			def quotationMeshModel = null
			def quotationCagePartModel = null
			
			taxPercent = taxationInstance.percent
			log.debug'taxPercent'+taxPercent
			
			FormulaService formulaService = new FormulaService()
			
			def variables = ["cageLength": quotationInstance.cageLength, "fulls":quotationInstance.fulls,"halfs":quotationInstance.halfs,"noOfCuttingsInShed":quotationInstance.noOfCuttingsInShed,"tiers":quotationInstance.tiers
				,"noOfSingleBottomsPerSheet":cageDesignInstance.noOfSingleBottomsPerSheet,"noOfPartitionsPerSheetLength":cageDesignInstance.noOfPartitionsPerSheetLength,"sheetLength":cageDesignInstance.sheetLength]
			
			def doubleBox = ((( quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.fulls))
			def singleBox = (quotationInstance.cageLength/cageDesignInstance.sheetLength)*(quotationInstance.fulls)*((quotationInstance.tiers-1)*2)+((quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.halfs*quotationInstance.tiers)
			def noOfBirds = (doubleBox*2*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageDoubleBox)+(singleBox*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageSingleBox)
			
			if(quotationModelList.quotationMeshModel[0] != null) {
				
				log.debug'quotationMeshModel'+quotationModelList.quotationMeshModel
				
				def quotationModels = quotationModelList.get(j)
				wireBrandInstance = quotationModels.quotationMeshModel.wireBrand
				
				def sheetSpecForList = cageDesignInstance.cageDesignSheetSpecFormula
				def totalWeight = 0
				
				sheetSpecForList.each { sheetSpecFor ->
				
					def noOfSheets = formulaService.evalFormula(variables, sheetSpecFor.formula)
					log.debug'noOfSheets'+noOfSheets
				
					totalWeight += noOfSheets * (sheetSpecFor.sheetSpecification.sheetWeight)
				
				
				}
				
				quotationMeshModel =  new QuotationMeshModel()
					
				def w = WirePrice.createCriteria()
				def priceList = w.get{
					
					eq("wireBrand",wireBrandInstance)
				}
				log.debug'wireBrandInstance '+wireBrandInstance
			
				BigDecimal wirePrice = priceList.price
			
				log.debug'brandPrice'+wirePrice
			
				def sheetSpecFormList = cageDesignInstance.cageDesignSheetSpecFormula
				def noSheetPerSheetSpec = 0
				def totMeshSheetCost = 0
				def meshSheetCost = 0
				def sheetSpecDiscount = 0
				def totSheetSpecDiscount = 0
			
				sheetSpecFormList.each { sheetSpecFor ->
			
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
					}
					totMeshSheetCost += meshSheetCost
					totSheetSpecDiscount += sheetSpecDiscount
			
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
				log.debug'Mesh cost: '+meshCost
				
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
				
			}
			
			if(quotationModelList.quotationCagePartModel[0] != null) {
				
				//quotationCagePartModel = quotationModelList.quotationCagePartModel.
				//println'quotationCageModel'+quotationModelList.quotationCagePartModel
				quotationCagePartModel = new QuotationCagePartModel()
				
				//def cagePartList = quotationModelList.quotationCagePartModel.quotationCageParts.cagePartSpecFormula.id
				def cagePartSpecList = quotationModelList.quotationCagePartModel.quotationCageParts.cagePartSpecFormula.id.get(j)
				log.debug 'cagePartSpecList '+cagePartSpecList
				
				if(cagePartSpecList != null) {
				
					for(int i=0;(i<=cagePartSpecList.size()-1);i++){
				
						if (!(cagePartSpecList.getAt(i) ==  "null")) {
				
							log.debug'cagePartSpecList.getAt(i)'+cagePartSpecList.getAt(i)
							CagePartSpecification cagePartSpecification = CagePartSpecification.get(cagePartSpecList.getAt(i))
							log.debug "cagePartSpecification "+cagePartSpecification
							def cagePartSpecFormulaList = cagePartSpecification.cagePartSpecFormulaList
							
							cagePartSpecFormulaList.each { cagePartSpecFormula ->
								log.debug "cagePartType.formula "+cagePartSpecFormula.formula
								def noOfParts = formulaService.evalFormula(variables, cagePartSpecFormula.formula)
								log.debug 'noOfParts '+noOfParts
								log.debug''+cagePartSpecFormula.cagePartSpecName+':'+noOfParts
								
								QuotationCagePart quotationCagePart = new QuotationCagePart()
				
								quotationCagePart.noOfCageParts = noOfParts
								quotationCagePart.cagePartSpecFormula = cagePartSpecFormula
				
								List cagePartPriceList = CagePartPrice.findAllByCagePartSpecFormula(cagePartSpecFormula)
								log.debug'cagePartPrice'+cagePartPriceList
								
								CagePartPrice cagePartPrice = cagePartPriceList.get(0)
				
								quotationCagePart.priceOfEachCagePart = cagePartPrice.price
								quotationCagePart.costOfCagePart = (quotationCagePart.noOfCageParts * quotationCagePart.priceOfEachCagePart)
								cagePartsTotalCost += quotationCagePart.costOfCagePart
								
								quotationCagePartModel.addToQuotationCageParts(quotationCagePart)
												
							}
				
						}
					}
				}
				
				log.debug "cagePartsTotalCost "+ cagePartsTotalCost
				cagePartsTotalCost = cagePartsTotalCost*quotationInstance.noOfSheds
				log.debug "cagePartsTotalCost "+ cagePartsTotalCost
				
				quotationCagePartModel.cageDesign = cageDesignInstance
				quotationCagePartModel.costPerBird = (cagePartsTotalCost)/noOfBirds
				quotationCagePartModel.noOfBirds = noOfBirds
				quotationCagePartModel.cagePartCost = cagePartsTotalCost
			
			}
			
			quotationModel = new QuotationModel()
			
			BigDecimal cost = meshCost+cagePartsTotalCost
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
			
			log.debug "quotationmodel "+quotationModel
							
					
		}
		
		quotationInstance.addToQuotationModels(quotationModel)
		quotationInstance.status = Quotation.STATUS_NEW
		
		render(view: "createmodels", model: [quotationInstance: quotationInstance])
				
	}
	
	def quotationChainLink() {
		
	}
	
	
	def weldSidePrices() {
		
		log.debug'params'+params
		def customerInstance = Customer.get(params.customer.id)
		def taxationInstance = Taxation.get(params.taxation.id)
		
		BigDecimal weldSideCost = 0
		
		List sideMeshList = new ArrayList()
		List wireBrandList = new ArrayList()
		List lengthList = new ArrayList()
		List heightList = new ArrayList()
		List noOfPiecesList = new ArrayList()
		List ratePerSqftList = new ArrayList()
		List squareFeetsList = new ArrayList()
		List weldSideCostList = new ArrayList()
		
		for(int i=0; i<=5; i++) {
			
			def temp = params.('sideMesh['+i+']')
			//println'temp '+temp
			if((temp !=null) && (temp.('id')!= "null")) {
				def weldSide = temp.('id').toBigDecimal()
				log.debug'weldSide '+weldSide
				def wireBrand = temp.('wireBrand').toBigDecimal()
				def length = temp.('length1').toBigDecimal()
				def height = temp.('height').toBigDecimal()
				def noOfPieces = temp.('noOfPieces').toBigDecimal()
				def sideMeshInstance = SideMesh.get(weldSide)
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
				weldSideCost += weldSideItemCost
				
				sideMeshList.add(sideMeshInstance)
				wireBrandList.add(wireBrandInstance)
				lengthList.add(length)
				heightList.add(height)
				noOfPiecesList.add(noOfPieces)
				ratePerSqftList.add(pricePerSqFt) 
				squareFeetsList.add(squareFeet) 
				weldSideCostList.add(weldSideItemCost)
			}
			log.debug'weldSideCost '+weldSideCost
			
		}
		render(view: "quotationWeldSide", model: [customerInstance: customerInstance, taxationInstance: taxationInstance, sideMeshList: sideMeshList, wireBrandList: wireBrandList, lengthList: lengthList, heightList: heightList, noOfPiecesList: noOfPiecesList, ratePerSqftList: ratePerSqftList, squareFeetsList: squareFeetsList, weldSideCostList: weldSideCostList])		
	}
	
	def createWeldSide() {
		
		log.debug'params'+params
		def customerInstance = Customer.get(params.customer.id)
		def taxationInstance = Taxation.get(params.taxation.id)
		//def temp = params.('linkMesh['+i+']')
		//println'temp '+temp
		def quotationInstance = new Quotation(params)
		quotationInstance.customer = customerInstance
		
		if (!quotationInstance.save()) {
			quotationInstance.errors.each {
				log.error it
			}
		}
		log.debug'quotationInstance '+quotationInstance
		
		QuotationWeldSideModel quotationWeldSideModel =  new QuotationWeldSideModel()
		QuotationWeldSide quotationWeldSide =null
		
		BigDecimal weldSideCost = 0
			
		for(int i=0; i<=5; i++) {
			
			def temp = params.('sideMesh['+i+']')
			log.debug'temp '+temp
			if(temp) {
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
		quotationWeldSideModel.weldSideCost = weldSideCost
		
		QuotationModel quotationModel = new QuotationModel()
		
		def taxPercent = taxationInstance.percent
		BigDecimal cost = weldSideCost
		BigDecimal tax = ((taxPercent/100)*cost)
		log.debug'TAX: '+tax
		log.debug'COST '+cost
		quotationModel.cost = cost
		quotationModel.tax = tax
		quotationModel.totalCost =cost+tax
		quotationModel.taxation = taxationInstance
		quotationModel.quotationWeldSideModel = quotationWeldSideModel
		quotationInstance.addToQuotationModels(quotationModel)
		//notificationService.addSmsNotification(Notification.NOTIFMSG_SMS_QUOTATION_CREATED+":"+quotationInstance.quotationId, true, Notification.NOTIFTYPE_SMS, quotationInstance.customer.mobileNumber)
					
		if (quotationInstance.save(flush: true)) {
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
		else {
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
				
	}
	
	def quotationWeldSide() {
	
	}
	
	def chainLinkPrices() {
		
		log.debug'params'+params
		def customerInstance = Customer.get(params.customer.id)
		def taxationInstance = Taxation.get(params.taxation.id)
		
		BigDecimal chainLinkCost = 0
		
		List linkMeshList = new ArrayList()
		List wireBrandList = new ArrayList()
		List lengthList = new ArrayList()
		List heightList = new ArrayList()
		List noOfPiecesList = new ArrayList()
		List ratePerSqftList = new ArrayList()
		List squareFeetsList = new ArrayList()
		List chainLinkCostList = new ArrayList()
		
		for(int i=0; i<=5; i++) {
			
			def temp = params.('linkMesh['+i+']')
			if((temp !=null) && (temp.('id')!= "null")) {
				def linkMesh = temp.('id').toBigDecimal()
				log.debug'linkMesh '+linkMesh
				def wireBrand = temp.('wireBrand').toBigDecimal()
				def length = temp.('length1').toBigDecimal()
				def height = temp.('height').toBigDecimal()
				def noOfPieces = temp.('noOfPieces').toBigDecimal()
				def linkMeshInstance = LinkMesh.get(linkMesh)
				log.debug'linkMeshInstance '+linkMeshInstance
				def wireDiameter = linkMeshInstance.wireDiameter
				def wireWeight = linkMeshInstance.weight
				def wireBrandInstance = WireBrand.get(wireBrand)
				def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, wireDiameter)
				log.debug'wirePrice '+wirePrice.price
				def squareFeet = (length*height*noOfPieces)
				log.debug'squareFeet '+squareFeet
				
				def pricePerSqFt = (wireWeight*wirePrice.price)
				log.debug'pricePerSqFt '+pricePerSqFt
				
				def chainLinkItemCost = (squareFeet*pricePerSqFt)
				log.debug'chainLinkItemCost '+chainLinkItemCost
				chainLinkCost += chainLinkItemCost
				
				linkMeshList.add(linkMeshInstance)
				wireBrandList.add(wireBrandInstance)
				lengthList.add(length)
				heightList.add(height)
				noOfPiecesList.add(noOfPieces)
				ratePerSqftList.add(pricePerSqFt)
				squareFeetsList.add(squareFeet)
				chainLinkCostList.add(chainLinkItemCost)
			}
			log.debug'chainLinkCost '+chainLinkCost
			log.debug'linkMeshList '+linkMeshList
			
		}
		render(view: "quotationChainLink", model: [customerInstance: customerInstance, taxationInstance: taxationInstance, linkMeshList: linkMeshList, wireBrandList: wireBrandList, lengthList: lengthList, heightList: heightList, noOfPiecesList: noOfPiecesList, ratePerSqftList: ratePerSqftList, squareFeetsList: squareFeetsList, chainLinkCostList: chainLinkCostList])
	}
	
	def createChainLink() {
		
		log.debug'params'+params
		def customerInstance = Customer.get(params.customer.id)
		def taxationInstance = Taxation.get(params.taxation.id)
		//def temp = params.('linkMesh['+i+']')
		//println'temp '+temp
		def quotationInstance = new Quotation(params)
		quotationInstance.customer = customerInstance
		
		if (!quotationInstance.save()) {
			quotationInstance.errors.each {
				log.error it
			}
		}
		log.debug'quotationInstance '+quotationInstance
		
		QuotationChainLinkModel quotationChainLinkModel =  new QuotationChainLinkModel()
		QuotationChainLink quotationChainLink =null
		
		BigDecimal chainLinkCost = 0
			
		for(int i=0; i<=5; i++) {
			
			def temp = params.('linkMesh['+i+']')
			log.debug'temp '+temp
			if(temp) {
				def linkMesh = temp.('id')
				log.debug'linkMesh '+linkMesh
				def wireBrand = temp.('wireBrand')
				def length = temp.('length1').toBigDecimal()
				def height = temp.('height').toBigDecimal()
				def noOfPieces = temp.('noOfPieces').toBigDecimal()
				def linkMeshInstance = LinkMesh.get(linkMesh)
				log.debug'linkMeshInstance '+linkMeshInstance
				def wireDiameter = linkMeshInstance.wireDiameter
				def wireWeight = linkMeshInstance.weight
				def wireBrandInstance = WireBrand.get(wireBrand)
				def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, wireDiameter)
				log.debug'wirePrice '+wirePrice.price
				def squareFeet = (length*height*noOfPieces)
				log.debug'squareFeet '+squareFeet
				
				def pricePerSqFt = (wireWeight*wirePrice.price)
				log.debug'pricePerSqFt '+pricePerSqFt
				
				def chainLinkItemCost = (squareFeet*pricePerSqFt)
				log.debug'chainLinkItemCost '+chainLinkItemCost
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
			log.debug'chainLinkCost '+chainLinkCost
			
		}
		quotationChainLinkModel.chainLinkCost = chainLinkCost
		
		QuotationModel quotationModel = new QuotationModel()
		
		def taxPercent = taxationInstance.percent
		BigDecimal cost = chainLinkCost
		BigDecimal tax = ((taxPercent/100)*cost)
		log.debug'TAX: '+tax
		log.debug'COST '+cost
		quotationModel.cost = cost
		quotationModel.tax = tax
		quotationModel.totalCost =cost+tax
		quotationModel.taxation = taxationInstance
		quotationModel.quotationChainLinkModel = quotationChainLinkModel
		quotationInstance.addToQuotationModels(quotationModel)
		//notificationService.addSmsNotification(Notification.NOTIFMSG_SMS_QUOTATION_CREATED+":"+quotationInstance.quotationId, true, Notification.NOTIFTYPE_SMS, quotationInstance.customer.mobileNumber)
					
		if (quotationInstance.save(flush: true)) {
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
		else {
			render(view: "createmodels", model: [quotationInstance: quotationInstance])
		}
				
	}
	
	def shoppingCart() {
		println'params '+params
		def taxationInstance = Taxation.get(params.taxation)
		println'taxationInstance '+taxationInstance
		def sheetQuantity = JSON.parse(params.sheetQuantity)
		def cageQuantity = JSON.parse(params.cageQuantity)
		def sheetQuantityList = sheetQuantity.items
		def cageQuantityList = cageQuantity.items
		println'sheetQuantityList '+sheetQuantityList
		println'cageQuantityList '+cageQuantityList	
		
		def sheetSpecCost = 0 
		List meshPartList = new ArrayList()
		
		
		if(sheetQuantityList.size() != null) {
			
			for(int i=0;(i<=sheetQuantityList.size()-1);i++) {
				def sheet = sheetQuantityList.getAt(i)
				def sheetSpec = sheet.id
				def wireBrand = sheet.wirebrand
				def quantity  = sheet.qty
				
				if(sheetSpec != '') {
					def sheetSpecificationInstance = SheetSpecification.get(sheetSpec)
					def wireBrandInstance = WireBrand.get(wireBrand)
					
					BigDecimal noOfCrossWires = (sheetSpecificationInstance.length/sheetSpecificationInstance.pitch)+1
					BigDecimal crossWireLength = noOfCrossWires*(sheetSpecificationInstance.width+(2*sheetSpecificationInstance.projection))
					BigDecimal lineWireLength1 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires1
					BigDecimal lineWireLength2 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires2
					
					BigDecimal crossWireWeight = ((crossWireLength/6588)*(sheetSpecificationInstance.crossWireDiameter*sheetSpecificationInstance.crossWireDiameter))
					BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(sheetSpecificationInstance.lineWireDiameter1*sheetSpecificationInstance.lineWireDiameter1))
					BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(sheetSpecificationInstance.lineWireDiameter2*sheetSpecificationInstance.lineWireDiameter2))
								
					def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecificationInstance.crossWireDiameter)
					def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecificationInstance.lineWireDiameter1)
					def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecificationInstance.lineWireDiameter2)
									
					if(sheetSpecificationInstance.lineWireDiameter1 > 0 && sheetSpecificationInstance.lineWireDiameter2 > 0) {
						sheetSpecCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)) * quantity.toBigDecimal())
					} else if(sheetSpecificationInstance.lineWireDiameter1 > 0) {
						sheetSpecCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * quantity.toBigDecimal())
					}
					println'sheetSpecCost '+sheetSpecCost
					meshPartList.add(
						"sheetSpecification":sheetSpecificationInstance.id,"wireBrand":wireBrandInstance.id,"noOfMeshParts":quantity, "sheetSpecCost":sheetSpecCost)
					
				}
			}
		}
		
		println'cageQuantityList.size() '+cageQuantityList.size()
		def cagePartSpecList = new ArrayList()
		if(cageQuantityList.size() != null) {
			
			for(int i=0;(i<=cageQuantityList.size()-1);i++) {
				
				/*def cagePartItems = cageQuantityList.getAt(i)
				def cagePartSpecFormula = cagePartItems.id
				def cagePartSpecId= cagePartItems.cagePartSpecId
				println'cagePartSpecFormula '+cagePartSpecFormula
				def quantity  = cagePartItems.qty
				
				if(cagePartSpecFormula != "") {
					def cagePartSpecFormulaInstance = CagePartSpecFormula.get(cagePartSpecFormula)
					println'cagePartSpecFormulaInstance '+cagePartSpecFormulaInstance
					def cagePartPriceInstance = CagePartPrice.findByCagePart(cagePartSpecFormulaInstance.cagePart)
					println'cagePartPriceInstance '+cagePartPriceInstance
					def cagePartCost = (quantity.toBigDecimal()*cagePartPriceInstance.price)
					println'cagePartCost '+cagePartCost
					cagePartList.add("cagePart":cagePartSpecFormula, "cagePartSpecId":cagePartSpecId,"noOfCageParts":quantity, "cagePartCost":cagePartCost)
				}*/
				
				List cagePartList
				def cagePartItems = cageQuantityList.getAt(i)
				println'cagePartItems '+cagePartItems
				def cagePartSpec = cagePartItems.cagePartSpec
				def cagePartSpecificationInstance = CagePartSpecification.get(cagePartSpec)
				def cagePartSpecFormItems = cagePartItems.cageParts
				if(cagePartSpec != " ") {
					cagePartList = new ArrayList()
					cagePartSpecFormItems.each  { cage ->
						
						println'id '+cage.id
						def cagePartSpecFormula = cage.id.toBigDecimal()
						def noOfCageParts = cage.qty.toBigDecimal()
						def cagePartSpecFormulaInstance = CagePartSpecFormula.get(cagePartSpecFormula.toBigDecimal())
						def cagePartPriceInstance = CagePartPrice.findByCagePart(cagePartSpecFormulaInstance.cagePart)
						println'cagePartPriceInstance '+cagePartPriceInstance
						def cagePartCost = (noOfCageParts*cagePartPriceInstance.price)
						println'cagePartCost '+cagePartCost
						cagePartList.add("cagePart":cagePartSpecFormula, "cagePartSpecId":cagePartSpec,"noOfCageParts":noOfCageParts, "cagePartCost":cagePartCost)
					}
					cagePartSpecList.add("cagePartSpecId":cagePartSpec,"cageParts":cagePartList)
				}
			}
		
		}
		println'cagePartSpecList '+cagePartSpecList
		def quotationCartInfo = ["taxation":taxationInstance.id,"meshParts":meshPartList,"cageParts":cagePartSpecList]
		println'cartSummary '+quotationCartInfo
		render(view: "quotation", model: [taxationInstance: taxationInstance, quotationCartInfo: quotationCartInfo as JSON])		
	}
	
	def quotationCartSubmit() {
		println'params '+params
		def quotationCartData = JSON.parse(params.requestData)
		println'quotationCartData '+quotationCartData
		def customer = quotationCartData.customerId.toBigDecimal()
		def taxation = quotationCartData.taxation.toBigDecimal()
		def customerInstance = Customer.get(customer)
		println'customerInstance '+customerInstance
		def taxationInstance = Taxation.get(taxation)
		println'taxationInstance '+taxationInstance
		def meshPartList = quotationCartData.meshParts
		def cagePartList = quotationCartData.cageParts
		println'meshPartList '+meshPartList
		println'cagePartList '+cagePartList
		def cagePartSpecList = new ArrayList()
						
		def totMeshSheetCost = 0
		def meshSheetCost = 0
		def sheetSpecDiscount = 0
		def totSheetSpecDiscount = 0
		def netMeshCost = 0
		def taxPercent = taxationInstance.percent
		
		def meshParts = new ArrayList()
		def cageParts = new ArrayList()
		
		Quotation quotationInstance = new Quotation()
		
		quotationInstance.customer = customerInstance
		if (!quotationInstance.save()) {
			quotationInstance.errors.each {
				log.error it
			}
		}
		println'quotationInstance '+quotationInstance
		
		QuotationModel quotationModel = new QuotationModel()
		QuotationMeshModel  quotationMeshModel = null
		QuotationCagePartModel  quotationCagePartModel = new QuotationCagePartModel()
		QuotationChainLinkModel quotationChainLinkModel = new QuotationChainLinkModel()
		QuotationWeldSideModel quotationWeldSideModel =  new QuotationWeldSideModel()
		QuotationMeshPart quotationMeshPart = null
		
		QuotationCagePart quotationCagePart = null
		
		if(meshPartList.size()>0){
			quotationMeshModel = new QuotationMeshModel()
			meshPartList.each { meshPart ->
				def wireBrand = meshPart.wireBrand.toBigDecimal()
				def sheetSpec = meshPart.sheetSpecification.toBigDecimal()
				def noOfMeshParts = meshPart.noOfMeshParts.toBigDecimal()
				//def SheetSpecCost = meshPart.sheetSpecCost
				
				def sheetSpecificationInstance = SheetSpecification.get(sheetSpec)
				println'sheetSpecificationInstance '+sheetSpecificationInstance
				def wireBrandInstance = WireBrand.get(wireBrand)
				println'wireBrandInstance '+wireBrandInstance
				println'noOfMeshParts '+noOfMeshParts
				BigDecimal noOfCrossWires = (sheetSpecificationInstance.length/sheetSpecificationInstance.pitch)+1
				BigDecimal crossWireLength = noOfCrossWires*(sheetSpecificationInstance.width+(2*sheetSpecificationInstance.projection))
				BigDecimal lineWireLength1 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires1
				BigDecimal lineWireLength2 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires2
				
				BigDecimal crossWireWeight = ((crossWireLength/6588)*(sheetSpecificationInstance.crossWireDiameter*sheetSpecificationInstance.crossWireDiameter))
				BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(sheetSpecificationInstance.lineWireDiameter1*sheetSpecificationInstance.lineWireDiameter1))
				BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(sheetSpecificationInstance.lineWireDiameter2*sheetSpecificationInstance.lineWireDiameter2))
				
				println'crossWireDiameter '+sheetSpecificationInstance.crossWireDiameter
				println'lineWireDiameter1 '+sheetSpecificationInstance.lineWireDiameter1
				println'lineWireDiameter2 '+sheetSpecificationInstance.lineWireDiameter2
				
				println'crossWireWeight'+crossWireWeight
				println'lineWireWeight1'+lineWireWeight1
				println'lineWireWeight2'+lineWireWeight2
				
				def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecificationInstance.crossWireDiameter)
				def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecificationInstance.lineWireDiameter1)
				def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecificationInstance.lineWireDiameter2)
								
				if(sheetSpecificationInstance.lineWireDiameter1 > 0 && sheetSpecificationInstance.lineWireDiameter2 > 0) {
					
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)) * noOfMeshParts)
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts) * (crossWirePrice.sheetSpecDiscount/100)) +( ((lineWireWeight2*lineWirePrice2.price) * noOfMeshParts )*(lineWirePrice2.sheetSpecDiscount/100))
					println'sheetSpecDiscount'+sheetSpecDiscount
					
					println'meshSheetCost '+meshSheetCost
				} else if(sheetSpecificationInstance.lineWireDiameter1 > 0) {
				
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts)
					println'meshSheetCost '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts) * (crossWirePrice.sheetSpecDiscount/100))
					println'sheetSpecDiscount'+sheetSpecDiscount
				}
				totMeshSheetCost += meshSheetCost
				totSheetSpecDiscount += sheetSpecDiscount
				println'totMeshSheetCost '+totMeshSheetCost
				println'totSheetSpecDiscount '+totSheetSpecDiscount
				
				quotationMeshPart = new QuotationMeshPart()
				quotationMeshPart.wireBrand = wireBrandInstance
				quotationMeshPart.sheetSpecification = sheetSpecificationInstance
				quotationMeshPart.noOfMeshParts = noOfMeshParts
				quotationMeshPart.meshCost = meshSheetCost
				quotationMeshModel.addToQuotationMeshParts(quotationMeshPart)
				println'quotationMeshPart '+quotationMeshPart
				
			}
			
			
			def meshDiscountPercent = ((totSheetSpecDiscount*100)/totMeshSheetCost)
			netMeshCost = (totMeshSheetCost-totSheetSpecDiscount)
			quotationMeshModel.meshCost = totMeshSheetCost
			quotationMeshModel.meshDiscount = totSheetSpecDiscount
			quotationMeshModel.meshDiscountPercent = meshDiscountPercent
			quotationMeshModel.netMeshCost = netMeshCost
		}
		println'quotationMeshModel '+quotationMeshModel
		
		def totalCageCost = 0
		
		/*if(cagePartList.size()>0){
			QuotationCagePart quotationCagePart = null
			for(int i=0;(i<=cagePartList.size()-1);i++){
				def cagePart = cagePartList.getAt(i)
				println'cagePart '+cagePart
				def cagePartSpecFormula = cagePart.cagePart.toBigDecimal()
				def noOfCageParts = cagePart.noOfCageParts.toBigDecimal()
				def cagePartSpecFormulaInstance = CagePartSpecFormula.get(cagePartSpecFormula)
				println'cagePartSpecFormulaInstance '+cagePartSpecFormulaInstance
				def cagePartPriceInstance = CagePartPrice.findByCagePart(cagePartSpecFormulaInstance.cagePart)
				println'cagePartPriceInstance '+cagePartPriceInstance
				def priceOfEachCagePart = cagePartPriceInstance.price
				println'priceOfEachCagePart '+priceOfEachCagePart
				def cagePartCost = (noOfCageParts*priceOfEachCagePart)
				totalCageCost += cagePartCost
				quotationCagePart = new QuotationCagePart()
				quotationCagePart.cagePartSpecFormula = cagePartSpecFormulaInstance
				quotationCagePart.noOfCageParts = noOfCageParts
				quotationCagePart.costOfCagePart = cagePartCost
				quotationCagePart.priceOfEachCagePart = priceOfEachCagePart
				quotationCagePartModel.addToQuotationCageParts(quotationCagePart)
				println'quotationCageModel '+quotationCagePartModel
				
			}
			quotationCagePartModel.cagePartCost = totalCageCost
		}*/
		def cagePartsTotalCost = 0		
		
		if(cagePartList.size() > 0) {
			
			for(int i=0;(i<=cagePartList.size()-1);i++) {
						
				def cagePartItems = cagePartList.getAt(i)
				println'cagePartItems '+cagePartItems
				def cagePartSpec = cagePartItems.cagePartSpecId
				println'cagePartSpec '+cagePartSpec
				def cagePartSpecFormItems = cagePartItems.cageParts
				if(cagePartSpec != '') {
					BigDecimal cagePartSpecCost = 0
					def cagePartSpecificationInstance = CagePartSpecification.get(cagePartSpec.toBigDecimal())
					QuotationCagePartSpecification quotationCagePartSpecification = new QuotationCagePartSpecification()
					cagePartSpecFormItems.each  { cage ->
						quotationCagePart = new QuotationCagePart()
						println'id '+cage.cagePart
						def cagePartSpecFormula = cage.cagePart.toBigDecimal()
						println'cagePartSpecFormula '+cagePartSpecFormula
						def noOfCageParts = cage.noOfCageParts.toBigDecimal()
						def cagePartSpecFormulaInstance = CagePartSpecFormula.get(cagePartSpecFormula)
						println'cagePartSpecFormulaInstance '+cagePartSpecFormulaInstance
						def cagePartPriceInstance = CagePartPrice.findByCagePart(cagePartSpecFormulaInstance.cagePart)
						println'cagePartPriceInstance '+cagePartPriceInstance
						println'cagePartPrice '+cagePartPriceInstance.price
						def cagePartCost = (noOfCageParts*cagePartPriceInstance.price)
						println'cagePartCost '+cagePartCost
						
						quotationCagePart.noOfCageParts = noOfCageParts
						quotationCagePart.cagePartSpecFormula = cagePartSpecFormulaInstance
						quotationCagePart.priceOfEachCagePart = cagePartPriceInstance.price
						quotationCagePart.costOfCagePart = cagePartCost
						totalCageCost += cagePartCost
						cagePartSpecCost += cagePartCost
						println'quotationCagePart '+quotationCagePart
						quotationCagePartSpecification.addToQuotationCageParts(quotationCagePart)
						
					}
					//def cagePartSpecTax = ((taxPercent/100)*cagePartSpecCost)
					quotationCagePartSpecification.cagePartSpecification = cagePartSpecificationInstance
					quotationCagePartSpecification.cagePartSpecCost = cagePartSpecCost
					//quotationCagePartSpecification.costPerBird = ((cagePartSpecCost+cagePartSpecTax)/noOfBirds)
					quotationCagePartModel.addToQuotationCagePartSpecs(quotationCagePartSpecification)
				}
			}
			
			def cagePartTax = ((taxPercent/100)*totalCageCost)
			quotationCagePartModel.cagePartCost = (totalCageCost+cagePartTax)
			quotationCagePartModel.cagePartTax = cagePartTax
		
		}
				
		BigDecimal cost = netMeshCost+totalCageCost
		BigDecimal tax = ((taxPercent/100)*cost)
		quotationModel.cost = cost
		quotationModel.tax = tax
		quotationModel.totalCost =(cost+tax)
		quotationModel.taxation = taxationInstance
		quotationModel.quotationMeshModel = quotationMeshModel
		quotationModel.quotationCagePartModel = quotationCagePartModel
		quotationModel.quotationChainLinkModel = quotationChainLinkModel
		quotationModel.quotationWeldSideModel = quotationWeldSideModel
		
		println'quotationModel '+quotationModel
		
		quotationInstance.addToQuotationModels(quotationModel)
		if (!quotationInstance.save(flush: true)) {
			quotationInstance.errors.each {
				println it
			}
			return
		}
		
		NotificationService notificationService = new NotificationService()
		
		notificationService.addNotification(springSecurityService.currentUser.toString(),Notification.NOTIFMSG_QUOTATION_GENERATED, true, ""+g.link(action:"show", controller:"quotation", id: quotationInstance.id) { quotationInstance.quotationId }, Notification.NOTIFTYPE_APP)
		notificationService.addSmsNotification(springSecurityService.currentUser.toString(),"Quotation of value "+quotationModel.totalCost+" generated by "+springSecurityService.currentUser.toString()+" .", true, Notification.NOTIFTYPE_SMS, quotationInstance.customer.mobileNumber)
				
		def cagePartData = quotationModel?.quotationCagePartModel?.quotationCagePartSpecs
		def meshPartData = quotationModel?.quotationMeshModel?.quotationMeshParts
		def rows = new ArrayList()
		
		if(meshPartData?.size() > 0) {
			meshPartData.each { meshPart ->
				meshParts.add(
					"sheetSpec":meshPart.sheetSpecification.id,"sheetId":meshPart.sheetSpecification.sheetSpecId, "wireBrand":meshPart.wireBrand.toString(), "sheetSpecification":meshPart.sheetSpecification.toString(), "noOfMeshParts":meshPart.noOfMeshParts, "costOfMeshPart":meshPart.meshCost)
			}
		}
		if(cagePartData?.size() > 0) {
				
				cagePartData.each { cagePartSpec ->
					def cageParts_1 = new ArrayList()
					
					cagePartSpec.each { cagePart ->
						
						def cageItems = cagePart.quotationCageParts
						println'cageParts '+cageParts
						println'cageitems '+cageItems
						cageItems.each { cage ->
							cageParts_1.add("cagePartId":cage.cagePartSpecFormula.id,"cagePartCode":cage.cagePartSpecFormula.cagePart.cagePartCode,"cagePart":cage.cagePartSpecFormula.cagePart.cagePart,"noOfcageParts":cage.noOfCageParts,"priceOfEachCagePart":cage.priceOfEachCagePart,"costOfCagePart":cage.costOfCagePart)
							
						}
						rows.add("cagePartSpec":["cagePartSpecificationId":cagePartSpec.cagePartSpecification.id,"cagePartSpecification":cagePartSpec.cagePartSpecification.toString(),"cagePartSpecCost":cagePartSpec.cagePartSpecCost],"cageParts":cageParts_1)
						println'rows '+rows						
					}
															
					
				}				
				
		}
		def responseData = [
			
			"quotationInfo":["id":quotationInstance.id,"quotation":quotationInstance.quotationId,"status":quotationInstance.status,"createdby":quotationInstance.createdBy.toString(),"createddate":quotationInstance.createdDate.format("dd/MM/yyyy"),"comments":quotationInstance.comments],
			
			"model":["id":quotationModel?.id,"cost":quotationModel?.cost, "tax":quotationModel?.tax, "totalCost":quotationModel?.totalCost],
			
			"modelInfo":[
				"meshPartsDetails":["model":["meshCost":quotationModel?.quotationMeshModel?.meshCost],
					"parts":["rows":meshParts,"meshCost":quotationModel?.quotationMeshModel?.meshCost,"meshDiscountPercent":quotationModel?.quotationMeshModel?.meshDiscountPercent,"meshDiscount":quotationModel?.quotationMeshModel?.meshDiscount,"netMeshCost":quotationModel?.quotationMeshModel?.netMeshCost]
					],
				"cagePartsDetails":["model":["cagePartCost":quotationModel?.quotationCagePartModel?.cagePartCost],
					"parts":["rows":rows,"cagePartTax":quotationModel?.quotationCagePartModel?.cagePartTax,"cagePartCost":quotationModel?.quotationCagePartModel?.cagePartCost]
					],
				"chainLinkDetails":["model":["chainLinkCost":quotationModel?.quotationChainLinkModel?.chainLinkCost],
					"parts":["rows":"","chainLinkCost":quotationModel?.quotationChainLinkModel?.chainLinkCost,"chainLinkDiscountPercent":quotationModel?.quotationChainLinkModel?.chainLinkDiscountPercent,"chainLinkDiscount":quotationModel?.quotationChainLinkModel?.chainLinkDiscount,"netChainLinkCost":quotationModel?.quotationChainLinkModel?.netChainLinkCost]
					],
				"weldSideMeshDetails":["model":["weldSideCost":quotationModel?.quotationWeldSideModel?.weldSideCost],
					"parts":["rows":"","weldSideCost":quotationModel?.quotationWeldSideModel?.weldSideCost,"weldSideDiscountPercent":quotationModel?.quotationWeldSideModel?.weldSideDiscountPercent,"weldSideDiscount":quotationModel?.quotationWeldSideModel?.weldSideDiscount,"netWeldSideCost":quotationModel?.quotationWeldSideModel?.netWeldSideCost]
					]
				]
			]
			println'responseData '+responseData
			
			render(contentType: 'text/json') {[
				'responseData': responseData,'responseCode': responseData ? "OK" : "NODATA"
			]}
	}
		
	def quotationSpecs(){
		println'params'+params
		//println'requestData '+requestData
		def quotationData = JSON.parse(params.requestData)
		println'quotationData '+quotationData
		def customer = quotationData.customerId.toBigDecimal()
		def customerInstance = Customer.get(customer)
		def enquiry = quotationData.enquiryId.toBigDecimal()
		println'enquiry '+enquiry
		def enquiryInstance = Enquiry.get(enquiry)	
		Quotation quotationInstance = new Quotation(quotationData)
		quotationInstance.customer = customerInstance
		quotationInstance.enquiry = enquiryInstance
		enquiryInstance.status = Enquiry.STATUS_REALIZED
		if (!quotationInstance.save(flush: true)) {
			quotationInstance.errors.each {
				println it
			}
			return
		}
		def responseData = ["id":quotationInstance.id,"cageLength":quotationInstance.cageLength,"noOfCuttingsInShed":quotationInstance.noOfCuttingsInShed,"noOfSheds":quotationInstance.noOfSheds,"fulls":quotationInstance.fulls,"tiers":quotationInstance.tiers,"createdby":quotationInstance.createdBy.username,"createddate":quotationInstance.createdDate.format("dd/MM/yyyy"),"status":quotationInstance.status,"quotation":quotationInstance.quotationId,"enquiry":enquiryInstance.enquiryId]
		println'responseData '+responseData
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "OK" : "INVALID"
		]}
		//return
	}
	
	def addQuotationModels(){
		println'params '+params
		def quotationModelData = JSON.parse(params.requestData)
		println'quotationModelData'+quotationModelData
		def quotation = quotationModelData.quotationId
		def cageDesign = quotationModelData.cageDesign
		def taxation = quotationModelData.taxation
		def wireBrand = quotationModelData.meshPart
		def hasMeshPart = quotationModelData.hasMeshPart
		def hasCagePart = quotationModelData.hasCagePart
		def hasChainLink = quotationModelData.hasChainLink
		def hasWeldSide = quotationModelData.hasWeldSide
		def quotationInstance = Quotation.get(quotation)
		def cageDesignInstance =CageDesign.get(cageDesign)
		println'quotationInstance'+quotationInstance
		def taxationInstance = Taxation.get(taxation)
		println'taxationInstance'+taxationInstance
		
		List cagePartSpecList = quotationModelData.cagePartTypes.cagePartSpec
		println'cagePartSpecList '+cagePartSpecList
		def chainLinkData = quotationModelData.chainLinkItems
		println'chainLinkData '+chainLinkData
		def weldSideData = quotationModelData.weldSideItems
		
		QuotationModel quotationModel = new QuotationModel()
				
		QuotationMeshModel quotationMeshModel =  new QuotationMeshModel()
		
		FormulaService formulaService = new FormulaService()
		
		def variables = ["cageLength": quotationInstance.cageLength, "fulls":quotationInstance.fulls,"halfs":quotationInstance.halfs,"noOfCuttingsInShed":quotationInstance.noOfCuttingsInShed,"tiers":quotationInstance.tiers
					,"noOfSingleBottomsPerSheet":cageDesignInstance.noOfSingleBottomsPerSheet,"noOfPartitionsPerSheetLength":cageDesignInstance.noOfPartitionsPerSheetLength,"sheetLength":cageDesignInstance.sheetLength,"noOfBirdsPerCageSingleBox":cageDesignInstance.noOfBirdsPerCageSingleBox,"noOfBirdsPerCageDoubleBox":cageDesignInstance.noOfBirdsPerCageDoubleBox]

		def doubleBox = ((( quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.fulls))
		def singleBox = (quotationInstance.cageLength/cageDesignInstance.sheetLength)*(quotationInstance.fulls)*((quotationInstance.tiers-1)*2)+((quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.halfs*quotationInstance.tiers)
		def noOfBirds = (doubleBox*2*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageDoubleBox)+(singleBox*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageSingleBox)
		println'noOfBirds '+noOfBirds	
		
		BigDecimal meshCost = 0
		BigDecimal noSheetPerSheetSpec = 0
		def totMeshSheetCost = 0
		def meshSheetCost = 0
		def sheetSpecDiscount = 0
		def totSheetSpecDiscount = 0
		def netMeshCost = 0
		def taxPercent = taxationInstance.percent
		
		println'hasMeshPart '+hasMeshPart
		if(hasMeshPart == true) {
			
			//quotationMeshModel =  new QuotationMeshModel()
			
			def sheetSpecForList = cageDesignInstance.cageDesignSheetSpecFormula
			println'sheetSpecForList '+sheetSpecForList
			def wireBrandInstance = WireBrand.get(wireBrand)
			println'wireBrandInstance '+wireBrandInstance
			
			sheetSpecForList.each { sheetSpecFor ->
				
				noSheetPerSheetSpec = formulaService.evalFormula(variables, sheetSpecFor.formula)
				println'noSheetPerSheetSpec '+noSheetPerSheetSpec
				
				noSheetPerSheetSpec = noSheetPerSheetSpec.setScale(0, RoundingMode.UP)
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
						
			meshCost = (totMeshSheetCost*quotationInstance.noOfSheds)
			println'Mesh cost: '+meshCost
			
			def meshDiscountPercent = ((totSheetSpecDiscount*100)/meshCost)
			netMeshCost = (meshCost-totSheetSpecDiscount)
			def meshTax = ((taxPercent/100)*netMeshCost)
			
			quotationMeshModel.meshCost = meshCost
			quotationMeshModel.singleBox = singleBox
			quotationMeshModel.noOfBirds = noOfBirds
			quotationMeshModel.doubleBox = doubleBox
			quotationMeshModel.costPerBird = ((netMeshCost+meshTax)/noOfBirds)
			quotationMeshModel.cageDesign = cageDesignInstance
			quotationMeshModel.wireBrand = wireBrandInstance
			quotationMeshModel.meshDiscount = totSheetSpecDiscount
			quotationMeshModel.meshDiscountPercent = meshDiscountPercent
			quotationMeshModel.netMeshCost = (netMeshCost+meshTax)
			quotationMeshModel.meshTax = meshTax
			
			quotationInstance.isMeshQuotation = true
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		} else {
			quotationInstance.isMeshQuotation = false
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		}
		
		QuotationCagePartModel quotationCagePartModel = new QuotationCagePartModel()
		
		BigDecimal cagePartsTotalCost = 0
		
				
		if(hasCagePart == true){
			
			//quotationCagePartModel = new QuotationCagePartModel()
			
			for(int i=0;(i<=cagePartSpecList.size()-1);i++) {
				
				if (!(cagePartSpecList.getAt(i) ==  "null")) {
					
					BigDecimal cagePartSpecCost = 0
					QuotationCagePartSpecification quotationCagePartSpecification = new QuotationCagePartSpecification()
					
					println'cagePartSpecList.getAt(i)'+cagePartSpecList.getAt(i)
					CagePartSpecification cagePartSpecification = CagePartSpecification.get(cagePartSpecList.getAt(i))
					println "cagePartSpecification "+cagePartSpecification
					def cagePartSpecFormulaList = cagePartSpecification.cagePartSpecFormulaList
					println'cagePartSpecFormulaList '+cagePartSpecFormulaList
					cagePartSpecFormulaList.each { cagePartSpecFormula ->
						println "cagePartType.formula "+cagePartSpecFormula.formula
						BigDecimal noOfParts = formulaService.evalFormula(variables, cagePartSpecFormula.formula)
						println 'noOfParts '+noOfParts
						noOfParts = noOfParts.setScale(0, RoundingMode.UP)
						println''+cagePartSpecFormula.cagePart+':'+noOfParts
		
		
						QuotationCagePart quotationCagePart = new QuotationCagePart()
		
						quotationCagePart.noOfCageParts = noOfParts
						quotationCagePart.cagePartSpecFormula = cagePartSpecFormula
		
		
						List cagePartPriceList = CagePartPrice.findAllByCagePart(cagePartSpecFormula.cagePart)
						println'cagePartPrice'+cagePartPriceList
						
						CagePartPrice cagePartPrice = cagePartPriceList.get(0)
						println'cagePartPrice'+cagePartPrice
						quotationCagePart.priceOfEachCagePart = cagePartPrice.price
						quotationCagePart.costOfCagePart = (quotationCagePart.noOfCageParts * quotationCagePart.priceOfEachCagePart)
						cagePartsTotalCost += quotationCagePart.costOfCagePart
						cagePartSpecCost += quotationCagePart.costOfCagePart
						println'quotationCagePart '+quotationCagePart
						quotationCagePartSpecification.addToQuotationCageParts(quotationCagePart)										
		
					}
					
					def cagePartSpecTax = ((taxPercent/100)*cagePartSpecCost)
					quotationCagePartSpecification.cagePartSpecification = cagePartSpecification
					quotationCagePartSpecification.cagePartSpecCost = (cagePartSpecCost+cagePartSpecTax)
					quotationCagePartSpecification.costPerBird = ((cagePartSpecCost+cagePartSpecTax)/noOfBirds)
					quotationCagePartModel.addToQuotationCagePartSpecs(quotationCagePartSpecification)
				}
			}
		
			println "cagePartsTotalCost "+ cagePartsTotalCost
			cagePartsTotalCost = cagePartsTotalCost*quotationInstance.noOfSheds
			println "cagePartsTotalCost "+ cagePartsTotalCost
			
			def cagePartTax = ((taxPercent/100)*cagePartsTotalCost)
			
			quotationCagePartModel.cageDesign = cageDesignInstance
			quotationCagePartModel.costPerBird = ((cagePartsTotalCost+cagePartTax)/noOfBirds)
			quotationCagePartModel.noOfBirds = noOfBirds
			quotationCagePartModel.cagePartCost = (cagePartsTotalCost+cagePartTax)
			quotationCagePartModel.cagePartTax = cagePartTax
			
			quotationInstance.isCageQuotation = true
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		} else {
			quotationInstance.isCageQuotation = false
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		}
		
		QuotationChainLinkModel quotationChainLinkModel = new QuotationChainLinkModel()
		QuotationChainLink quotationChainLink = null
		
		BigDecimal chainLinkCost = 0
		BigDecimal chainLinkDiscount = 0
		def netChainLinkCost = 0
		
		if(hasChainLink == true) {
			
			//quotationChainLinkModel = new QuotationChainLinkModel()
			
			chainLinkData.each { chain ->
				def linkMesh = chain.linkMeshId
				def wireBrand_1 = chain.wireBrand
				def length = chain.length1.toBigDecimal()
				def height =chain.height.toBigDecimal()
				def noOfPieces = chain.noOfPieces.toBigDecimal()				
				def linkMeshInstance = LinkMesh.get(linkMesh)
				println'linkMeshInstance '+linkMeshInstance
				def wireDiameter = linkMeshInstance.wireDiameter
				def wireWeight = linkMeshInstance.weight
				def wireBrandInstance = WireBrand.get(wireBrand_1)
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
			def chainLinkDiscountPercent = ((chainLinkDiscount*100)/chainLinkCost)
			netChainLinkCost = (chainLinkCost-chainLinkDiscount)
			def chainLinkTax = ((taxPercent/100)*netChainLinkCost)
			
			quotationChainLinkModel.chainLinkCost = chainLinkCost
			quotationChainLinkModel.chainLinkDiscount = chainLinkDiscount
			quotationChainLinkModel.chainLinkDiscountPercent = chainLinkDiscountPercent
			quotationChainLinkModel.netChainLinkCost = (netChainLinkCost+chainLinkTax)
			
			quotationInstance.isChainLinkQuotation = true
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
			
		}else {
			
			quotationInstance.isChainLinkQuotation = false
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		}
		
		QuotationWeldSideModel quotationWeldSideModel =  new QuotationWeldSideModel()
		QuotationWeldSide quotationWeldSide = null
		
		BigDecimal weldSideCost = 0
		BigDecimal weldSideDiscount = 0
		BigDecimal netWeldSideCost = 0
		
		if(hasWeldSide == true) {
			
			//quotationWeldSideModel =  new QuotationWeldSideModel()
			
			weldSideData.each { weldSide ->
				def sideMesh = weldSide.sideMeshId
				def wireBrand_1 = weldSide.wireBrand
				println'wireBrand_1 '+wireBrand_1
				def length = weldSide.length1.toBigDecimal()
				def height =weldSide.height.toBigDecimal()
				def noOfPieces = weldSide.noOfPieces.toBigDecimal()
				def sideMeshInstance = SideMesh.get(sideMesh)
				println'sideMeshInstance '+sideMeshInstance
				def wireDiameter = sideMeshInstance.wireDiameter
				println'wireDiameter '+wireDiameter
				def wireWeight = sideMeshInstance.weight
				println'wireWeight '+wireWeight
				def wireBrandInstance = WireBrand.get(wireBrand_1)
				println'wireBrandInstance '+wireBrandInstance
				def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, wireDiameter)
				println'wirePrice '+wirePrice
				println'wirePrice_1 '+wirePrice.price
				def squareFeet = (length*height*noOfPieces)
				println'squareFeet '+squareFeet
				
				def pricePerSqFt = (wireWeight*wirePrice.price)
				println'pricePerSqFt '+pricePerSqFt
				
				def weldSideItemCost = (squareFeet*pricePerSqFt)
				println'weldSideItemCost '+weldSideItemCost
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
			println'weldSideCost '+weldSideCost
			def weldSideDiscountPercent = ((weldSideDiscount*100)/weldSideCost)
			netWeldSideCost = (weldSideCost-weldSideDiscount)
			def weldSideTax = ((taxPercent/100)*netWeldSideCost)
			quotationWeldSideModel.weldSideCost = weldSideCost
			quotationWeldSideModel.weldSideDiscount = weldSideDiscount
			quotationWeldSideModel.weldSideDiscountPercent = weldSideDiscountPercent
			quotationWeldSideModel.netWeldSideCost = (netWeldSideCost+weldSideTax)
			
			quotationInstance.isWeldSideMeshQuotation = true
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		}else {
			quotationInstance.isWeldSideMeshQuotation = false
			if (!quotationInstance.save(flush: true)) {
				quotationInstance.errors.each {
					println it
				}
			}
		}
						
		BigDecimal cost = cagePartsTotalCost+netMeshCost+netChainLinkCost+netWeldSideCost
		BigDecimal tax = ((taxPercent/100)*cost)
		//log.debug'TAX: '+tax
		//log.debug'COST '+cost
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
 
		quotationInstance.quotationModels.add(quotationModel)
		if (!quotationInstance.save(flush: true)) {
			quotationInstance.errors.each {
				println it
			}
			return
		}
		
		NotificationService notificationService = new NotificationService()
		
		notificationService.addNotification(springSecurityService.currentUser.toString(),Notification.NOTIFMSG_QUOTATION_GENERATED, true, ""+g.link(action:"show", controller:"quotation", id: quotationInstance.id) { quotationInstance.quotationId}, Notification.NOTIFTYPE_APP)
		notificationService.addSmsNotification(springSecurityService.currentUser.toString(),"Quotation Created Value of your enquiry is "+quotationModel.totalCost+" has been depatched by "+"XXXX "+"on "+quotationInstance.createdDate.format("dd-MM-yyyy"), true, Notification.NOTIFTYPE_SMS, quotationInstance.customer.mobileNumber)
				
		List meshParts = new ArrayList()
		//List cageParts = new ArrayList()
		List chainLinkItems = new ArrayList()
		List weldSideItems = new ArrayList()
		List rows = new ArrayList()
		
		//def cagePartList = quotationModel?.quotationCagePartModel?.quotationCagePartSpecs?.quotationCageParts
		//println'cagePartList '+cagePartList
		def cagePartSpecifList = quotationModel?.quotationCagePartModel?.quotationCagePartSpecs
		def meshPartList = quotationModel?.quotationMeshModel?.quotationMeshParts
		def chainLinkList = quotationModel?.quotationChainLinkModel?.quotationChainLinkItems
		def weldSideList = quotationModel?.quotationWeldSideModel?.quotationWeldSideItems
		
		if(meshPartList?.size() > 0) {
			meshPartList.each { meshPart ->
				meshParts.add(
					"sheetSpecId":meshPart.sheetSpecification.id,"sheetId":meshPart.sheetSpecification.sheetSpecId, "wireBrand":meshPart.wireBrand.wireBrand, "sheetSpecification":meshPart.sheetSpecification.toString(), "noOfMeshParts":meshPart.noOfMeshParts, "costOfMeshPart":meshPart.meshCost)
			}
		}
		/*if(cagePartList?.size() > 0) {
			cagePartList.each { cagePart ->
				cageParts.add(
					"cagePartId":cagePart.cagePartSpecFormula.id,"cagePartCode":cagePart.cagePartSpecFormula.cagePart.cagePartCode,"cagePart":cagePart.cagePartSpecFormula.cagePart.cagePart,"noOfcageParts":cagePart.noOfCageParts,"priceOfEachCagePart":cagePart.priceOfEachCagePart,"costOfCagePart":cagePart.costOfCagePart)
			}
		}*/
		if(chainLinkList?.size() > 0) {
			chainLinkList.each { chainLink ->
				chainLinkItems.add(
					"chainLinkId":chainLink.id,"linkMeshId":chainLink.linkMesh.id,"linkMesh":chainLink.linkMesh.toString(),"wireBrand":chainLink.wireBrand.wireBrand,"length":chainLink.length,"height":chainLink.height,"noOfPieces":chainLink.noOfPieces,"squareFeets":chainLink.squareFeets,"pricePerSqFt":chainLink.pricePerSqFt,"chainLinkItemCost":chainLink.chainLinkItemCost)
			}
		}
		if(weldSideList?.size() > 0) {
			weldSideList.each { weldSide ->
				weldSideItems.add(
					"weldSideId":weldSide.id,"sideMeshId":weldSide.sideMesh.id,"sideMesh":weldSide.sideMesh.toString(),"wireBrand":weldSide.wireBrand.wireBrand,"length":weldSide.length,"height":weldSide.height,"noOfPieces":weldSide.noOfPieces,"squareFeets":weldSide.squareFeets,"pricePerSqFt":weldSide.pricePerSqFt,"weldSideItemCost":weldSide.weldSideItemCost)
			}
		}
		/*if(cagePartSpecifList?.size() > 0) {
			cagePartSpecifList.each { cagePartSpec ->
				cagePartSpecs.add(
					"cagePartSpecificationId":cagePartSpec.cagePartSpecification.id,"cagePartSpecCost":cagePartSpec.cagePartSpecCost,"costPerBird":cagePartSpec.costPerBird)
			}
		}*/
		if(cagePartSpecifList?.size() > 0) {
				
				cagePartSpecifList.each { cagePartSpec ->
					def cageParts = new ArrayList()
					
					cagePartSpec.each { cagePart ->
						def cageItems = cagePart.quotationCageParts
						println'cageParts '+cageParts
						println'cageitems '+cageItems
						cageItems.each { cage ->
							cageParts.add("cagePartId":cage.cagePartSpecFormula.id,"cagePartCode":cage.cagePartSpecFormula.cagePart.cagePartCode,"cagePart":cage.cagePartSpecFormula.cagePart.cagePart,"noOfcageParts":cage.noOfCageParts,"priceOfEachCagePart":cage.priceOfEachCagePart,"costOfCagePart":cage.costOfCagePart)
							
						}
						rows.add("cagePartSpec":["cagePartSpecificationId":cagePartSpec.cagePartSpecification.id,"cagePartSpecification":cagePartSpec.cagePartSpecification.toString(),"cagePartSpecCost":cagePartSpec.cagePartSpecCost,"costPerBird":cagePartSpec.costPerBird,"noOfBirds":noOfBirds],"cageParts":cageParts)
						println'rows '+rows						
					}
															
					
				}				
				
			}
			
			println'rows '+rows
		
		def responseData = ["model":["id":quotationModel?.id,"cageDesign":cageDesignInstance?.cageDesign, "noOfBirds":quotationModel?.noOfBirds, "costPerBird":quotationModel?.costPerBird, "cost":quotationModel?.cost, "tax":quotationModel?.tax, "totalCost":quotationModel?.totalCost],
		"modelInfo":[
			"meshPartsDetails":["model":["cageDesign":quotationModel?.quotationMeshModel?.cageDesign?.cageDesign, "wireBrand":quotationModel?.quotationMeshModel?.wireBrand?.wireBrand, "singleBox":quotationModel?.quotationMeshModel?.singleBox, "doubleBox":quotationModel?.quotationMeshModel?.doubleBox, "costPerBird":quotationModel?.quotationMeshModel?.costPerBird, "noOfBirds":quotationModel?.quotationMeshModel?.noOfBirds, "meshCost":quotationModel?.quotationMeshModel?.netMeshCost],
				"parts":["rows":meshParts,"meshCost":quotationModel?.quotationMeshModel?.meshCost,"meshDiscountPercent":quotationModel?.quotationMeshModel?.meshDiscountPercent,"meshDiscount":quotationModel?.quotationMeshModel?.meshDiscount,"meshTax":quotationModel?.quotationMeshModel?.meshTax,"netMeshCost":quotationModel?.quotationMeshModel?.netMeshCost]
				],
			"cagePartsDetails":["model":["cageDesign":quotationModel?.quotationCagePartModel?.cageDesign?.cageDesign,"costPerBird":quotationModel?.quotationCagePartModel?.costPerBird, "noOfBirds":quotationModel?.quotationCagePartModel?.noOfBirds, "cagePartCost":quotationModel?.quotationCagePartModel?.cagePartCost],
				"parts":["rows":rows,"cagePartTax":quotationModel?.quotationCagePartModel?.cagePartTax,"cagePartCost":quotationModel?.quotationCagePartModel?.cagePartCost]
				],
			"chainLinkDetails":["model":["chainLinkCost":quotationModel?.quotationChainLinkModel?.chainLinkCost],
				"parts":["rows":chainLinkItems,"chainLinkCost":quotationModel?.quotationChainLinkModel?.chainLinkCost,"chainLinkDiscountPercent":quotationModel?.quotationChainLinkModel?.chainLinkDiscountPercent,"chainLinkDiscount":quotationModel?.quotationChainLinkModel?.chainLinkDiscount,"chainLinkTax":quotationModel?.quotationChainLinkModel?.chainLinkTax,"netChainLinkCost":quotationModel?.quotationChainLinkModel?.netChainLinkCost]
				],
			"weldSideMeshDetails":["model":["weldSideCost":quotationModel?.quotationWeldSideModel?.weldSideCost],
				"parts":["rows":weldSideItems,"weldSideCost":quotationModel?.quotationWeldSideModel?.weldSideCost,"weldSideDiscountPercent":quotationModel?.quotationWeldSideModel?.weldSideDiscountPercent,"weldSideDiscount":quotationModel?.quotationWeldSideModel?.weldSideDiscount,"weldSideTax":quotationModel?.quotationWeldSideModel?.weldSideTax,"netWeldSideCost":quotationModel?.quotationWeldSideModel?.netWeldSideCost]
				]
			]
		]
		println'responseData '+responseData
//		println'isMeshQuotation '+quotationInstance.isMeshQuotation
//		println'isCageQuotation '+quotationInstance.isCageQuotation
		
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "OK" : "NODATA"
		]}
		
	}
	
	
	
	def editMeshPart() {
		println'params '+params
		def meshPartData = JSON.parse(params.requestData)
		println'meshPartData '+meshPartData
		def quotation = meshPartData.quotationId.toBigDecimal()
		def quotationModel = meshPartData.modelId.toBigDecimal()
		def sheetSpec = meshPartData.sheetSpec.toBigDecimal()
		def noOfSheetSpecs = meshPartData.noOfMeshParts.toBigDecimal()
		
		def quotationInstance = Quotation.get(quotation)
		println'quotationInstance '+quotationInstance
		def quotationModelInstance = QuotationModel.get(quotationModel)
		println'quotationModelInstance '+quotationModelInstance
		def quotationMeshModelInstance = quotationModelInstance.quotationMeshModel
		def taxPercent = quotationModelInstance.taxation.percent
		println'tax '+taxPercent
		def wireBrandInstance = quotationModelInstance.quotationMeshModel.wireBrand
		println'wireBrandInstance '+wireBrandInstance
		
		def sheetSpecificationInstance = SheetSpecification.get(sheetSpec)
				
		if (!quotationMeshModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (quotationMeshModelInstance.version > version) {
				quotationMeshModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'quotationMeshModel.label', default: 'QuotationMeshModel')] as Object[],
						  "Another user has updated this QuotationMeshModel while you were editing")
				render(view: "editMeshModel", model: [quotationMeshModelInstance: quotationMeshModelInstance])
				return
			}
		}
		//quotationMeshModelInstance.properties = params
		def quotationMeshPartsList = quotationMeshModelInstance.quotationMeshParts
		println'quotationMeshPartsList '+quotationMeshPartsList
						
		BigDecimal meshCost = 0
		def totMeshSheetCost = 0
		
		def sheetSpecDiscount = 0
		def totSheetSpecDiscount = 0
		
		quotationMeshPartsList.each { quotMeshPart ->
			def meshSheetCost = 0
			def sheetSpecification = quotMeshPart.sheetSpecification.id
			println'sheetSpecification '+sheetSpecification
			def noOfMeshParts = quotMeshPart.noOfMeshParts
			println'noOfMeshParts '+noOfMeshParts
				
			if(sheetSpecification == sheetSpecificationInstance.id){
				println'in if block'
				BigDecimal noOfCrossWires = (quotMeshPart.sheetSpecification.length/quotMeshPart.sheetSpecification.pitch)+1
				BigDecimal crossWireLength = noOfCrossWires*(quotMeshPart.sheetSpecification.width+(2*quotMeshPart.sheetSpecification.projection))
				BigDecimal lineWireLength1 = (quotMeshPart.sheetSpecification.length+quotMeshPart.sheetSpecification.pitch)*quotMeshPart.sheetSpecification.noOfLineWires1
				BigDecimal lineWireLength2 = (quotMeshPart.sheetSpecification.length+quotMeshPart.sheetSpecification.pitch)*quotMeshPart.sheetSpecification.noOfLineWires2
				
				BigDecimal crossWireWeight = ((crossWireLength/6588)*(quotMeshPart.sheetSpecification.crossWireDiameter*quotMeshPart.sheetSpecification.crossWireDiameter))
				BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(quotMeshPart.sheetSpecification.lineWireDiameter1*quotMeshPart.sheetSpecification.lineWireDiameter1))
				BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(quotMeshPart.sheetSpecification.lineWireDiameter2*quotMeshPart.sheetSpecification.lineWireDiameter2))
				
				def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, quotMeshPart.sheetSpecification.crossWireDiameter)
				def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, quotMeshPart.sheetSpecification.lineWireDiameter1)
				def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, quotMeshPart.sheetSpecification.lineWireDiameter2)
				
				if(quotMeshPart.sheetSpecification.lineWireDiameter1 > 0 && quotMeshPart.sheetSpecification.lineWireDiameter2 > 0) {
					
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)) * noOfSheetSpecs)
					println'meshSheetCost if '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfSheetSpecs) * (crossWirePrice.sheetSpecDiscount/100)) +( ((lineWireWeight2*lineWirePrice2.price) * noOfSheetSpecs)*(lineWirePrice2.sheetSpecDiscount/100))
				} else if(quotMeshPart.sheetSpecification.lineWireDiameter1 > 0) {
				
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfSheetSpecs)
					println'meshSheetCost else '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfSheetSpecs) * (crossWirePrice.sheetSpecDiscount/100))
				}
				quotMeshPart.noOfMeshParts = noOfSheetSpecs
				quotMeshPart.meshCost = meshSheetCost
				
				//totMeshSheetCost += meshSheetCost
				//totSheetSpecDiscount += sheetSpecDiscount
			}else {
				println'in else block'
				BigDecimal noOfCrossWires = (quotMeshPart.sheetSpecification.length/quotMeshPart.sheetSpecification.pitch)+1
				BigDecimal crossWireLength = noOfCrossWires*(quotMeshPart.sheetSpecification.width+(2*quotMeshPart.sheetSpecification.projection))
				BigDecimal lineWireLength1 = (quotMeshPart.sheetSpecification.length+quotMeshPart.sheetSpecification.pitch)*quotMeshPart.sheetSpecification.noOfLineWires1
				BigDecimal lineWireLength2 = (quotMeshPart.sheetSpecification.length+quotMeshPart.sheetSpecification.pitch)*quotMeshPart.sheetSpecification.noOfLineWires2
				
				BigDecimal crossWireWeight = ((crossWireLength/6588)*(quotMeshPart.sheetSpecification.crossWireDiameter*quotMeshPart.sheetSpecification.crossWireDiameter))
				BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(quotMeshPart.sheetSpecification.lineWireDiameter1*quotMeshPart.sheetSpecification.lineWireDiameter1))
				BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(quotMeshPart.sheetSpecification.lineWireDiameter2*quotMeshPart.sheetSpecification.lineWireDiameter2))
				
				def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, quotMeshPart.sheetSpecification.crossWireDiameter)
				def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, quotMeshPart.sheetSpecification.lineWireDiameter1)
				def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, quotMeshPart.sheetSpecification.lineWireDiameter2)
				
				if(quotMeshPart.sheetSpecification.lineWireDiameter1 > 0 && quotMeshPart.sheetSpecification.lineWireDiameter2 > 0) {
					
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)) * noOfMeshParts)
					println'meshSheetCost if '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts) * (crossWirePrice.sheetSpecDiscount/100)) +( ((lineWireWeight2*lineWirePrice2.price) * noOfMeshParts)*(lineWirePrice2.sheetSpecDiscount/100))
				} else if(quotMeshPart.sheetSpecification.lineWireDiameter1 > 0) {
				
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts)
					println'meshSheetCost else '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noOfMeshParts) * (crossWirePrice.sheetSpecDiscount/100))
				}
				
			}
			totMeshSheetCost += meshSheetCost
			totSheetSpecDiscount += sheetSpecDiscount
			println'totMeshSheetCost '+totMeshSheetCost
			println'totSheetSpecDiscount '+totSheetSpecDiscount
		}			
		
		meshCost = (totMeshSheetCost*quotationInstance.noOfSheds)
		println'Mesh cost: '+meshCost
		
		BigDecimal meshCostPerBird = (meshCost/quotationModelInstance.noOfBirds)
		
		def meshDiscountPercent = ((totSheetSpecDiscount*100)/meshCost)
		def netMeshCost = (meshCost-totSheetSpecDiscount)
		println'netMeshCost '+netMeshCost
		/*BigDecimal scaled = netMeshCost.setScale(2, RoundingMode.UP)
		println'scaled '+scaled*/		
		quotationMeshModelInstance.meshCost = meshCost
		quotationMeshModelInstance.costPerBird = meshCostPerBird
		//quotationMeshModelInstance.addValue = addValue
		//quotationMeshModelInstance.description = description
		quotationMeshModelInstance.meshDiscount = totSheetSpecDiscount
		quotationMeshModelInstance.meshDiscountPercent = meshDiscountPercent
		quotationMeshModelInstance.netMeshCost = netMeshCost
		
		if (!quotationMeshModelInstance.save(flush: true)) {
			quotationMeshModelInstance.errors.allErrors.each {
				println it
			}
			//render(view: "editMeshModel", model: [quotationMeshModelInstance: quotationMeshModelInstance])
			return
		}
		
		BigDecimal cagePartCost = quotationModelInstance?.quotationCagePartModel?.cagePartCost
		BigDecimal chainLinkCost = quotationModelInstance?.quotationChainLinkModel?.netChainLinkCost
		BigDecimal weldSideMeshCost = quotationModelInstance?.quotationWeldSideModel?.netWeldSideCost
		println'cagePartCost '+cagePartCost
		println'chainLinkCost '+chainLinkCost
		println'weldSideMeshCost '+weldSideMeshCost
		
		BigDecimal totalCost = 0
		totalCost = netMeshCost+cagePartCost+chainLinkCost+weldSideMeshCost
		println'totalCost '+totalCost
		def tax = ((taxPercent/100)*totalCost)
		println'tax ' +tax
		BigDecimal finalCost = totalCost + tax
		println'finalCost '+finalCost
		BigDecimal costPerBird = (finalCost/quotationModelInstance.noOfBirds)
		quotationModelInstance.cost = totalCost
		quotationModelInstance.tax = tax
		quotationModelInstance.totalCost = finalCost
		quotationModelInstance.costPerBird = costPerBird
		
		if (!quotationModelInstance.save(flush: true)) {
			quotationModelInstance.errors.allErrors.each {
				println it
			}
		}
		
		def meshParts = new ArrayList()
		def meshPartList = quotationMeshModelInstance.quotationMeshParts
		meshPartList.each { meshPart ->
				meshParts.add(
					"sheetSpecId":meshPart.sheetSpecification.id,"sheetId":meshPart.sheetSpecification.sheetSpecId, "wireBrand":meshPart.wireBrand.wireBrand, "sheetSpecification":meshPart.sheetSpecification.toString(), "noOfMeshParts":meshPart.noOfMeshParts, "costOfMeshPart":meshPart.meshCost)
			}
		
		def responseData = ["model":["id":quotationModelInstance.id,"cageDesign":quotationModelInstance.cageDesign.toString(), "noOfBirds":quotationModelInstance.noOfBirds, "cost":quotationModelInstance.cost, "tax":quotationModelInstance.tax, "totalCost":quotationModelInstance.totalCost],
			"meshPartsDetails":["model":["cageDesign":quotationMeshModelInstance.cageDesign.toString(), "wireBrand":quotationMeshModelInstance.wireBrand.toString(), "singleBox":quotationMeshModelInstance.singleBox, "doubleBox":quotationMeshModelInstance.doubleBox, "costPerBird":quotationMeshModelInstance.costPerBird, "noOfBirds":quotationMeshModelInstance.noOfBirds, "meshCost":quotationMeshModelInstance.meshCost],
				"parts":["rows":meshParts,"meshCost":quotationMeshModelInstance.meshCost,"meshDiscountPercent":quotationMeshModelInstance.meshDiscountPercent,"meshDiscount":quotationMeshModelInstance.meshDiscount,"netMeshCost":quotationMeshModelInstance.netMeshCost]
				]			
			]
		
		println'responseData '+responseData
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "MESHOK" : "NODATA"
		]}
	}
	
	def editCagePart(){
		
		println'params '+params
		def cagePartData = JSON.parse(params.requestData)
		println'cagePartData '+cagePartData
		def quotation = cagePartData.quotationId.toBigDecimal()
		def quotationModel = cagePartData.modelId.toBigDecimal()
		def cagePart = cagePartData.cagePart.toBigDecimal()
		def noOfCageParts = cagePartData.noOfCageParts.toBigDecimal()
		
		def quotationInstance = Quotation.get(quotation)
		def quotationModelInstance = QuotationModel.get(quotationModel)
		def quotationCagePartModelInstance = quotationModelInstance.quotationCagePartModel
		def taxPercent = quotationModelInstance.taxation.percent
		log.debug'tax '+taxPercent
		def noOfBirds = quotationModelInstance.noOfBirds
		
		if (!quotationCagePartModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationCagePartModel.label', default: 'QuotationCagePartModel'), params.id])
			//redirect(action: "list")
			return
		}

		/*if (params.version) {
			def version = params.version.toLong()
			if (quotationCageModelInstance.version > version) {
				quotationCageModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'quotationCagePartModel.label', default: 'QuotationCagePartModel')] as Object[],
						  "Another user has updated this QuotationCagePartModel while you were editing")
				//render(view: "editMeshModel", model: [quotationCageModelInstance: quotationCageModelInstance])
				return
			}
		}*/
		//quotationCageModelInstance.properties = params
		//def quotationCagePartsList = quotationCagePartModelInstance.quotationCageParts
		def quotationCagePartSpecList = quotationCagePartModelInstance.quotationCagePartSpecs		
				
		BigDecimal totalCagePartCost = 0
		BigDecimal cagePartSpecCost = 0 
		
		quotationCagePartSpecList.each { cagePartSpec ->
			println'cagePartSpec '+cagePartSpec
			def cageParts = new ArrayList()
			
			cagePartSpec.each { cagePartSpec_1 ->
				println'cagePartSpec_1 '+cagePartSpec_1
				def cageItems = cagePartSpec_1.quotationCageParts
				println'cageParts '+cageParts
				println'cageitems '+cageItems
				cageItems.each { cagePartSpecForm ->
					println "cagePartSpecFormId"+cagePartSpecForm.cagePartSpecFormula.id
					
					if(cagePartSpecForm.cagePartSpecFormula.id == cagePart){
						
						println'in if block'
						def cagePartCost = cagePartSpecForm.priceOfEachCagePart
						totalCagePartCost += (noOfCageParts*cagePartCost)
						cagePartSpecForm.noOfCageParts = noOfCageParts
						cagePartSpecForm.costOfCagePart = (noOfCageParts*cagePartCost)
						
					}else{
						
						println'in else block'
						def noOfCagePart = cagePartSpecForm.noOfCageParts
						def cagePartCost = cagePartSpecForm.priceOfEachCagePart
						totalCagePartCost += (noOfCagePart*cagePartCost)
						
					}
					
				}
				cagePartSpecCost += totalCagePartCost
				cagePartSpec_1.cagePartSpecCost = cagePartSpecCost
				cagePartSpec_1.costPerBird = (cagePartSpecCost/noOfBirds)
			}
		}													
			
		
		
		/*quotationCagePartsList.each { cagePart_1 ->
			println'cagePart_1'+cagePart_1.cagePartSpecFormula.id
			println'cagePart'+cagePart
			if(cagePart_1.cagePartSpecFormula.id == cagePart){
				
				println'in if block'
				def cagePartCost = cagePart_1.priceOfEachCagePart
				totalCagePartCost += (noOfCageParts*cagePartCost)
				cagePart_1.noOfCageParts = noOfCageParts
				cagePart_1.costOfCagePart = (noOfCageParts*cagePartCost)
				
			}else{
				
				println'in else block'
				def noOfCagePart = cagePart_1.noOfCageParts
				def cagePartCost = cagePart_1.priceOfEachCagePart
				totalCagePartCost += (noOfCagePart*cagePartCost)
				
			}
						
			println'totalCagePartCost'+totalCagePartCost
						
		}*/
		totalCagePartCost = (totalCagePartCost*quotationInstance.noOfSheds)
				
		println'totalCagePartCost: '+totalCagePartCost
		
		BigDecimal cageCostPerBird = (totalCagePartCost/quotationModelInstance.noOfBirds)

		quotationCagePartModelInstance.cagePartCost = totalCagePartCost
		quotationCagePartModelInstance.costPerBird = cageCostPerBird

		if (!quotationCagePartModelInstance.save(flush: true)) {
			
			//render(view: "editCageModel", model: [quotationCageModelInstance: quotationCageModelInstance])
			return
		}
		
		BigDecimal meshCost = quotationModelInstance?.quotationMeshModel?.netMeshCost
		BigDecimal chainLinkCost = quotationModelInstance?.quotationChainLinkModel?.netChainLinkCost
		BigDecimal weldSideCost = quotationModelInstance?.quotationWeldSideModel?.netWeldSideCost
		println'meshCost '+meshCost
		BigDecimal totalCost = meshCost+totalCagePartCost+chainLinkCost+weldSideCost
		def tax = ((taxPercent/100)*totalCost)
		println'tax ' +tax
		BigDecimal finalCost = totalCost + tax
		println'finalCost '+finalCost
		BigDecimal costPerBird = (finalCost/quotationModelInstance.noOfBirds)
		quotationModelInstance.cost = totalCost
		quotationModelInstance.tax = tax
		quotationModelInstance.totalCost = finalCost
		quotationModelInstance.costPerBird = costPerBird
		
		if (!quotationCagePartModelInstance.save(flush: true)) {
			quotationCagePartModelInstance.errors.allErrors.each {
				println it
			}			
		}
		def cagePartSpecifList = quotationModelInstance?.quotationCagePartModel?.quotationCagePartSpecs
		def rows = new ArrayList()
		
		cagePartSpecifList.each { cagePartSpec ->
					def cageParts = new ArrayList()
					
					cagePartSpec.each { cagePart_1 ->
						def cageItems = cagePart_1.quotationCageParts
						println'cageParts '+cageParts
						println'cageitems '+cageItems
						cageItems.each { cage ->
							cageParts.add("cagePartId":cage.cagePartSpecFormula.id,"cagePartCode":cage.cagePartSpecFormula.cagePart.cagePartCode,"cagePart":cage.cagePartSpecFormula.cagePart.cagePart,"noOfcageParts":cage.noOfCageParts,"priceOfEachCagePart":cage.priceOfEachCagePart,"costOfCagePart":cage.costOfCagePart)
							
						}
						rows.add("cagePartSpec":["cagePartSpecificationId":cagePartSpec.cagePartSpecification.id,"cagePartSpecification":cagePartSpec.cagePartSpecification.toString(),"cagePartSpecCost":cagePartSpec.cagePartSpecCost,"costPerBird":cagePartSpec.costPerBird,"noOfBirds":noOfBirds],"cageParts":cageParts)
						println'rows '+rows						
					}
															
					
				}
		
				
		def responseData = ["model":["id":quotationModelInstance.id,"cageDesign":quotationModelInstance.cageDesign.toString(),"costPerBird":quotationModelInstance.costPerBird,"noOfBirds":quotationModelInstance.noOfBirds,"cost":quotationModelInstance.cost,"tax":quotationModelInstance.tax,"totalCost":quotationModelInstance.totalCost],
							"cagePartsDetails":["model":["cageDesign":quotationCagePartModelInstance.cageDesign.toString(),"costPerBird":quotationCagePartModelInstance.costPerBird,"noOfBirds":quotationCagePartModelInstance.noOfBirds,"cagePartCost":quotationCagePartModelInstance.cagePartCost],
								"parts":["rows":rows,"cagePartCost":quotationCagePartModelInstance.cagePartCost] 
								]
							]
		println'responseData '+responseData
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "CAGEOK" : "NODATA"
		]}
	}
	
	def editChainLink(){
		
		println'params '+params
		
		def chainLinkData = JSON.parse(params.requestData)
		println'chainLinkData '+chainLinkData
		def quotation = chainLinkData.quotationId.toBigDecimal()
		def quotationModel = chainLinkData.modelId.toBigDecimal()
		def linkMesh = chainLinkData.linkMeshId.toBigDecimal()
		def noOfPieces = chainLinkData.noOfPieces.toBigDecimal()
		def length = chainLinkData.length.toBigDecimal()
		def height = chainLinkData.height.toBigDecimal()
		def chainLinkId = chainLinkData.chainLinkId.toBigDecimal()
		def linkMeshInstance = LinkMesh.get(linkMesh)
		println'linkMeshInstance '+linkMeshInstance 
		def quotationInstance = Quotation.get(quotation)
		def quotationModelInstance = QuotationModel.get(quotationModel)
		def chainLinkInstance = QuotationChainLink.get(chainLinkId)
		def quotationChainLinkModelInstance = quotationModelInstance.quotationChainLinkModel
		def taxPercent = quotationModelInstance.taxation.percent
		
		if (!quotationChainLinkModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel'), params.id])
			//redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (quotationChainLinkModelInstance.version > version) {
				quotationChainLinkModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'quotationChainLinkModel.label', default: 'QuotationChainLinkModel')] as Object[],
						  "Another user has updated this QuotationChainLinkModel while you were editing")
				//render(view: "edit", model: [quotationChainLinkModelInstance: quotationChainLinkModelInstance])
				return
			}
		}

		//quotationChainLinkModelInstance.properties = params
		def length_1 = 0 
		def height_1 = 0 
		def noOfPieces_1 = 0 
		
		def quotationChainLinkItemList = quotationChainLinkModelInstance.quotationChainLinkItems
		println'quotationChainLinkItemList '+quotationChainLinkItemList
		
		BigDecimal chainLinkCost = 0
		BigDecimal totChainLinkCost = 0
		BigDecimal chainLinkDiscount = 0
		BigDecimal totChainLinkDiscount = 0
		
		quotationChainLinkItemList.each { chainLink ->
			println'chainlink '+chainLink.id
			println'chainLinkInstance.id '+chainLinkInstance.id
			def wireBrandInstance = chainLink.wireBrand
			if(chainLink.id == chainLinkInstance.id) {
				println'in if'
				if(length != ''){
					length_1 = length
				} else {
					length_1 = chainLink.length
				}
				if(height != ''){
					height_1 = height
				}else {
					height_1= chainLink.height
				}
				if(noOfPieces != ''){
					noOfPieces_1 = noOfPieces
				}else {
					noOfPieces_1 = chainLink.noOfPieces
				}
				println'length_1 '+length_1
				println'height_1 '+height_1
				println'noOfPieces_1 '+noOfPieces_1
			}
			/*def linkMeshInstance = chainLink.linkMesh
			def length = chainLink.length
			def height = chainLink.height
			def noOfPieces = chainLink.noOfPieces*/
			def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, linkMeshInstance.wireDiameter)
			def chainLinkItemCost = (length_1*height_1*noOfPieces_1*wirePrice.price*linkMeshInstance.weight)
			println'chainLinkItemCost'+chainLinkItemCost
			chainLinkDiscount = (((wirePrice.chainLinkDiscount)/100)*chainLinkItemCost)
			totChainLinkCost += chainLinkItemCost
			totChainLinkDiscount += chainLinkDiscount
			
			chainLink.length = length_1
			chainLink.height = height_1
			chainLink.noOfPieces = noOfPieces_1
			chainLink.squareFeets = (length_1*height_1*noOfPieces_1)
			chainLink.pricePerSqFt = (linkMeshInstance.weight * wirePrice.price)
			chainLink.chainLinkItemCost = chainLinkItemCost
			
		}
		
		chainLinkCost = (totChainLinkCost*quotationInstance.noOfSheds)
		println'ChainLink Cost: '+chainLinkCost
				
		def chainLinkDiscountPercent = ((totChainLinkDiscount*100)/chainLinkCost)
		
		quotationChainLinkModelInstance.chainLinkCost = chainLinkCost
		quotationChainLinkModelInstance.chainLinkDiscount = chainLinkDiscount
		quotationChainLinkModelInstance.chainLinkDiscountPercent = chainLinkDiscountPercent
		quotationChainLinkModelInstance.netChainLinkCost = (chainLinkCost-chainLinkDiscount)
		if (!quotationChainLinkModelInstance.save(flush: true)) {
			//render(view: "editChainLinkModel", model: [quotationChainLinkModelInstance: quotationChainLinkModelInstance])
			return
		}
		
		BigDecimal meshCost = quotationModelInstance?.quotationMeshModel?.netMeshCost
		BigDecimal cageCost = quotationModelInstance?.quotationCagePartModel?.cagePartCost
		BigDecimal weldSideCost = quotationModelInstance?.quotationWeldSideModel?.netWeldSideCost
		println'meshCost '+meshCost
		BigDecimal totalCost = meshCost+cageCost+chainLinkCost+weldSideCost
		def tax = ((taxPercent/100)*totalCost)
		println'tax ' +tax
		BigDecimal finalCost = totalCost + tax
		println'finalCost '+finalCost
		BigDecimal costPerBird = (finalCost/quotationModelInstance.noOfBirds)
		quotationModelInstance.cost = totalCost
		quotationModelInstance.tax = tax
		quotationModelInstance.totalCost = finalCost
		quotationModelInstance.costPerBird = costPerBird
		
		if (!quotationChainLinkModelInstance.save(flush: true)) {
			quotationChainLinkModelInstance.errors.allErrors.each {
				println it
			}
		}
		
		def chainLinkList = quotationChainLinkModelInstance.quotationChainLinkItems
		def chainLinkItems = new ArrayList()
		
		chainLinkList.each { chainLink ->
			chainLinkItems.add(
				"chainLinkId":chainLink.id,"linkMeshId":chainLink.linkMesh.id,"linkMesh":chainLink.linkMesh.toString(),"wireBrand":chainLink.wireBrand.wireBrand,"length":chainLink.length,"height":chainLink.height,"noOfPieces":chainLink.noOfPieces,"squareFeets":chainLink.squareFeets,"pricePerSqFt":chainLink.pricePerSqFt,"chainLinkItemCost":chainLink.chainLinkItemCost)
		}
		
		def responseData = ["model":["id":quotationModelInstance.id,"cageDesign":quotationModelInstance.cageDesign.toString()],
							
			"chainLinkDetails":["model":["chainLinkCost":quotationChainLinkModelInstance.chainLinkCost],
				
				"parts":["rows":chainLinkItems,"chainLinkCost":quotationChainLinkModelInstance.chainLinkCost,"chainLinkDiscountPercent":quotationChainLinkModelInstance.chainLinkDiscountPercent,"chainLinkDiscount":quotationChainLinkModelInstance.chainLinkDiscount,"netChainLinkCost":quotationChainLinkModelInstance.netChainLinkCost]
				]
			]
		
		println'responseData '+responseData
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "CHAINOK" : "NODATA"
		]}
		
	}
	
	def editWeldSide(){
		
		def weldSideData = JSON.parse(params.requestData)
		println'weldSideData '+weldSideData
		def quotation = weldSideData.quotationId.toBigDecimal()
		def quotationModel = weldSideData.modelId.toBigDecimal()
		def sideMesh = weldSideData.sideMeshId.toBigDecimal()
		def noOfPieces = weldSideData.noOfPieces.toBigDecimal()
		def length = weldSideData.length.toBigDecimal()
		def height = weldSideData.height.toBigDecimal()
		def weldSideId = weldSideData.weldSideId.toBigDecimal()
		def sideMeshInstance = SideMesh.get(sideMesh)
		println'sideMeshInstance '+sideMeshInstance 
		def quotationInstance = Quotation.get(quotation)
		def quotationModelInstance = QuotationModel.get(quotationModel)
		def weldSideInstance = QuotationWeldSide.get(weldSideId)
		def quotationWeldSideModelInstance = quotationModelInstance.quotationWeldSideModel
		def taxPercent = quotationModelInstance.taxation.percent
		
		if (!quotationWeldSideModelInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel'), params.id])
			//redirect(action: "list")
			//return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (quotationWeldSideModelInstance.version > version) {
				quotationWeldSideModelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'quotationWeldSideModel.label', default: 'QuotationWeldSideModel')] as Object[],
						  "Another user has updated this QuotationWeldSideModel while you were editing")
				//render(view: "edit", model: [quotationWeldSideModelInstance: quotationWeldSideModelInstance])
				//return
			}
		}

		//quotationWeldSideModelInstance.properties = params
		def quotationWeldSideItemList = quotationWeldSideModelInstance.quotationWeldSideItems
		
		BigDecimal weldSideCost = 0
		BigDecimal totWeldSideCost = 0
		BigDecimal weldSideDiscount = 0
		BigDecimal totWeldSideDiscount = 0
		
		def length_1 = 0
		def height_1 = 0
		def noOfPieces_1 = 0
		
		quotationWeldSideItemList.each { weldSide ->
			println'weldSide '+weldSide.id
			println'weldSideInstance.id '+weldSideInstance.id
			def wireBrandInstance = weldSide.wireBrand
			if(weldSide.id == weldSideInstance.id) {
				println'in if'
				if(length != ''){
					length_1 = length
				} else {
					length_1 = weldSide.length
				}
				if(height != ''){
					height_1 = height
				}else {
					height_1= weldSide.height
				}
				if(noOfPieces != ''){
					noOfPieces_1 = noOfPieces
				}else {
					noOfPieces_1 = weldSide.noOfPieces
				}
				println'length_1 '+length_1
				println'height_1 '+height_1
				println'noOfPieces_1 '+noOfPieces_1
			}
			
			def wirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sideMeshInstance.wireDiameter)
			def weldSideItemCost = (length_1*height_1*noOfPieces_1*wirePrice.price*sideMeshInstance.weight)
			println'weldSideItemCost '+weldSideItemCost
			weldSideDiscount = (((wirePrice.chainLinkDiscount)/100)*weldSideItemCost)
			totWeldSideCost += weldSideItemCost
			totWeldSideDiscount += weldSideDiscount
			
			weldSide.length = length_1
			weldSide.height = height_1
			weldSide.noOfPieces = noOfPieces_1
			weldSide.squareFeets = (length_1*height_1*noOfPieces_1)
			weldSide.pricePerSqFt = (sideMeshInstance.weight * wirePrice.price)
			weldSide.weldSideItemCost = weldSideItemCost
			
		}
		
		weldSideCost = (totWeldSideCost*quotationInstance.noOfSheds)
		println'WeldSide Cost: '+weldSideCost
				
		def weldSideDiscountPercent = ((totWeldSideDiscount*100)/weldSideCost)
		
		quotationWeldSideModelInstance.weldSideCost = weldSideCost
		quotationWeldSideModelInstance.weldSideDiscount = weldSideDiscount
		quotationWeldSideModelInstance.weldSideDiscountPercent = weldSideDiscountPercent
		quotationWeldSideModelInstance.netWeldSideCost = (weldSideCost-weldSideDiscount)
		if (!quotationWeldSideModelInstance.save(flush: true)) {
			//render(view: "editChainLinkModel", model: [quotationWeldSideModelInstance: quotationWeldSideModelInstance])
			return
		}
		
		BigDecimal meshCost = quotationModelInstance?.quotationMeshModel?.netMeshCost
		BigDecimal cageCost = quotationModelInstance?.quotationCagePartModel?.cagePartCost
		BigDecimal chainLinkCost = quotationModelInstance?.quotationChainLinkModel?.netChainLinkCost
		println'meshCost '+meshCost
		BigDecimal totalCost = meshCost+cageCost+chainLinkCost+weldSideCost
		def tax = ((taxPercent/100)*totalCost)
		println'tax ' +tax
		BigDecimal finalCost = totalCost + tax
		println'finalCost '+finalCost
		BigDecimal costPerBird = (finalCost/quotationModelInstance.noOfBirds)
		quotationModelInstance.cost = totalCost
		quotationModelInstance.tax = tax
		quotationModelInstance.totalCost = finalCost
		quotationModelInstance.costPerBird = costPerBird
		
		if (!quotationWeldSideModelInstance.save(flush: true)) {
			quotationWeldSideModelInstance.errors.allErrors.each {
				log.error it
			}
			
		}
		
		def weldSideList = quotationWeldSideModelInstance.quotationWeldSideItems
		def weldSideItems = new ArrayList()
		
		weldSideList.each { weldSide ->
			weldSideItems.add(
				"sideMeshId":weldSide.sideMesh.id,"sideMesh":weldSide.sideMesh.toString(),"wireBrand":weldSide.wireBrand.wireBrand,"length":weldSide.length,"height":weldSide.height,"noOfPieces":weldSide.noOfPieces,"squareFeets":weldSide.squareFeets,"pricePerSqFt":weldSide.pricePerSqFt,"weldSideItemCost":weldSide.weldSideItemCost)
		}
		
		def responseData = ["model":["id":quotationModelInstance.id,"cageDesign":quotationModelInstance.cageDesign.toString()],
							
			"weldSideMeshDetails":["model":["weldSideCost":quotationWeldSideModelInstance.weldSideCost],
				
				"parts":["rows":weldSideItems,"weldSideCost":quotationWeldSideModelInstance.weldSideCost,"weldSideDiscountPercent":quotationWeldSideModelInstance.weldSideDiscountPercent,"weldSideDiscount":quotationWeldSideModelInstance.weldSideDiscount,"netWeldSideCost":quotationWeldSideModelInstance.netWeldSideCost]
				]
			]
		
		println'responseData '+responseData
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "WELDOK" : "NODATA"
		]}
	}
	
	def quotation(){
		
		println'params '+params
		def enquiryInstance = Enquiry.get(params.enquiry)
		def customerInstance = Customer.get(params.customer)
		println''+enquiryInstance?.status
		if(enquiryInstance?.status == 'REALIZED'){
			
			def quotationInstance = Quotation.findByEnquiry(enquiryInstance)
			println'quotationInstance' +quotationInstance
			redirect(url: "/quotation/quotation#/qid/"+quotationInstance.id)
			
		}
		[enquiryInstance: enquiryInstance, customerInstance: customerInstance]
		
		
	}
	
	def quotationShow() {
		
		println'params '+params
		def quotationData = JSON.parse(params.requestData)
		println'quotationData '+quotationData
		def quotation = quotationData.quotationId.toBigDecimal()
		def quotationInstance = Quotation.get(quotation)
		
		def quotationModel = new ArrayList()
		
		def quotationModelsList = quotationInstance.quotationModels
		println'quotationModelList '+quotationModelsList
		//def quotationMeshModelList = quotationInstance.quotationModels.quotationMeshModel
		def taxation = null
		def noOfBirds
		
		quotationModelsList.each { model ->
			taxation = model?.taxation
			def meshPartList = model?.quotationMeshModel?.quotationMeshParts
			println'meshPartList '+meshPartList
			//def cagePartList = model?.quotationCagePartModel?.quotationCagePartSpecs?.quotationCageParts
			def chainLinkList = model?.quotationChainLinkModel?.quotationChainLinkItems
			def weldSideList = model?.quotationWeldSideModel?.quotationWeldSideItems
			def cagePartSpecifList = model?.quotationCagePartModel?.quotationCagePartSpecs
			println'cagePartSpecifList '+cagePartSpecifList
			//println'cagePartList '+cagePartList	
			/*cagePartSpecifList.each  { cageSpec ->
				println'cageSpec '+cageSpec.cagePartSpecification
				cageSpec.each { cage ->
					println'cage '+cage.quotationCageParts
					
				}
				
			}*/					
			noOfBirds = model?.noOfBirds
			def meshParts = new ArrayList()
			//def cageParts = new ArrayList()
			def chainLinkItems = new ArrayList()
			def weldSideItems = new ArrayList()
			def cagePartSpecs = new ArrayList()
			def rows = new ArrayList()
			
			if(meshPartList?.size() > 0) {
				
				meshPartList.each { meshPart ->
					meshParts.add("sheetSpecId":meshPart.sheetSpecification.id,"sheetId":meshPart.sheetSpecification.sheetSpecId, "wireBrand":meshPart.wireBrand.toString(), "sheetSpecification":meshPart.sheetSpecification.toString(), "noOfMeshParts":meshPart.noOfMeshParts, "costOfMeshPart":meshPart.meshCost)
				}
			}			
			/*if(cagePartList?.size() > 0) {
				cagePartList.each { cagePart ->
					cageParts.add(
						"cagePartId":cagePart.cagePartSpecFormula.id,"cagePartCode":cagePart.cagePartSpecFormula.cagePart.cagePartCode,"cagePart":cagePart.cagePartSpecFormula.cagePart.cagePart,"noOfcageParts":cagePart.noOfCageParts,"priceOfEachCagePart":cagePart.priceOfEachCagePart,"costOfCagePart":cagePart.costOfCagePart)
				}
			}*/
			if(chainLinkList?.size() > 0) {
				chainLinkList.each { chainLink ->
					chainLinkItems.add(
						"chainLinkId":chainLink.id,"linkMeshId":chainLink.linkMesh.id,"linkMesh":chainLink.linkMesh.toString(),"wireBrand":chainLink.wireBrand.wireBrand,"length":chainLink.length,"height":chainLink.height,"noOfPieces":chainLink.noOfPieces,"squareFeets":chainLink.squareFeets,"pricePerSqFt":chainLink.pricePerSqFt,"chainLinkItemCost":chainLink.chainLinkItemCost)
				}
			}
			if(weldSideList?.size() > 0) {
				weldSideList.each { weldSide ->
					weldSideItems.add(
						"weldSideId":weldSide.id,"sideMeshId":weldSide.sideMesh.id,"sideMesh":weldSide.sideMesh.toString(),"wireBrand":weldSide.wireBrand.wireBrand,"length":weldSide.length,"height":weldSide.height,"noOfPieces":weldSide.noOfPieces,"squareFeets":weldSide.squareFeets,"pricePerSqFt":weldSide.pricePerSqFt,"weldSideItemCost":weldSide.weldSideItemCost)
				}
			}
			/*def rows = new ArrayList()
			if(cagePartSpecifList?.size() > 0) {
				cagePartSpecifList.each { cagePartSpec ->
					
					def cagePartSpecVar = new Object()
					cagePartItems.add(
						"cagePartSpecificationId":cagePartSpec.cagePartSpecification.id,"cagePartSpecCost":cagePartSpec.cagePartSpecCost,"costPerBird":cagePartSpec.costPerBird)
					println'cagePartSpec '+cagePartSpec
					cagePartSpecVar.cagePartSpecs = cagePartItems
					//cagePartItems.add("cagePartSpec":cagePartSpecs)
					cagePartSpec.each { cagePart ->
						def cageItems = cagePart.quotationCageParts
						println'cageItems '+cageItems
						cageItems.each { cage ->
							println'cage '+cage
							println'id '+cage.cagePartSpecFormula.id
							cageParts.add("cagePartId":cage.cagePartSpecFormula.id,"cagePartCode":cage.cagePartSpecFormula.cagePart.cagePartCode,"cagePart":cage.cagePartSpecFormula.cagePart.cagePart,"noOfcageParts":cage.noOfCageParts,"priceOfEachCagePart":cage.priceOfEachCagePart,"costOfCagePart":cage.costOfCagePart)
							//cagePartItems.add("cageParts":cageParts)
							println'cagePartItems '+cagePartItems
						}
						cagePartSpecVar.cageParts = cageParts
						cagePart.each { cage ->
							println'cage '+cage.quotationCageParts
							cageParts.add(
								"cagePartId":cagePart.quotationCageParts.cagePartSpecFormula.id,"cagePartCode":cagePart.quotationCageParts.cagePartSpecFormula.cagePart.cagePartCode,"cagePart":cagePart.quotationCageParts.cagePartSpecFormula.cagePart.cagePart,"noOfcageParts":cage.quotationCageParts.noOfCageParts,"priceOfEachCagePart":cage.quotationCageParts.priceOfEachCagePart,"costOfCagePart":cage.quotationCageParts.costOfCagePart)
						}
						//cagePartItems.add("cagePartSpec":cagePartSpecs,"cageParts":cageParts)
						
					}
					cagePartSpec.each { cagePart ->
						cageParts.add(
							"cagePartId":cagePart.cagePartSpecFormula.id,"cagePartCode":cagePart.cagePartSpecFormula.cagePart.cagePartCode,"cagePart":cagePart.cagePartSpecFormula.cagePart.cagePart,"noOfcageParts":cagePart.noOfCageParts,"priceOfEachCagePart":cagePart.priceOfEachCagePart,"costOfCagePart":cagePart.costOfCagePart)
					}
					//println'cagePartItems '+cagePartItems
					println'cagePartSpecVar '+cagePartSpecVar
					rows.add(cagePartSpecVar)
				}
				
			}
			println'cageParts'+cageParts
			println'cagePartSpecs'+cagePartSpecs
			println'cagePartItems '+cagePartItems*/
			//def rows = new ArrayList()
			if(cagePartSpecifList?.size() > 0) {
				
				cagePartSpecifList.each { cagePartSpec ->
					def cageParts = new ArrayList()
					
					cagePartSpec.each { cagePart ->
						def cageItems = cagePart.quotationCageParts
						println'cageParts '+cageParts
						println'cageitems '+cageItems
						cageItems.each { cage ->
							cageParts.add("cagePartId":cage.cagePartSpecFormula.id,"cagePartCode":cage.cagePartSpecFormula.cagePart.cagePartCode,"cagePart":cage.cagePartSpecFormula.cagePart.cagePart,"noOfcageParts":cage.noOfCageParts,"priceOfEachCagePart":cage.priceOfEachCagePart,"costOfCagePart":cage.costOfCagePart)
							
						}
						rows.add("cagePartSpec":["cagePartSpecificationId":cagePartSpec.cagePartSpecification.id,"cagePartSpecification":cagePartSpec.cagePartSpecification.toString(),"cagePartSpecCost":cagePartSpec.cagePartSpecCost,"costPerBird":cagePartSpec.costPerBird,"noOfBirds":noOfBirds],"cageParts":cageParts)
						println'rows '+rows						
					}
															
					
				}				
				
			}
			
			println'rows '+rows
			
			quotationModel.add("model":["id":model.id,"cageDesign":model.cageDesign.toString(),"noOfBirds":model.noOfBirds,"costPerBird":model.costPerBird,"cost":model.cost,"tax":model.tax,"totalCost":model.totalCost],
				"modelInfo":["meshPartsDetails":["model":["cageDesign":model?.quotationMeshModel?.cageDesign.toString(),"wireBrand":model?.quotationMeshModel?.wireBrand?.toString(),"singleBox":model?.quotationMeshModel?.singleBox,"doubleBox":model?.quotationMeshModel?.doubleBox,"costPerBird":model?.quotationMeshModel?.costPerBird,"noOfBirds":model?.quotationMeshModel?.noOfBirds,"meshCost":model?.quotationMeshModel?.netMeshCost],
					"parts":["rows":meshParts,"meshCost":model?.quotationMeshModel?.meshCost,"meshDiscountPercent":model?.quotationMeshModel?.meshDiscountPercent,"meshDiscount":model?.quotationMeshModel?.meshDiscount,"meshTax":model?.quotationMeshModel?.meshTax,"netMeshCost":model?.quotationMeshModel?.netMeshCost]],
				"cagePartsDetails":["model":["cageDesign":model?.quotationCagePartModel?.cageDesign.toString(),"costPerBird":model?.quotationCagePartModel?.costPerBird,"noOfBirds":model?.quotationCagePartModel?.noOfBirds,"cagePartCost":model?.quotationCagePartModel?.cagePartCost],
								"parts":["rows":rows,"cagePartTax":model?.quotationCagePartModel?.cagePartTax,"cagePartCost":model?.quotationCagePartModel?.cagePartCost]],
				"chainLinkDetails":["model":["chainLinkCost":model?.quotationChainLinkModel?.chainLinkCost],
								"parts":["rows":chainLinkItems,"chainLinkCost":model?.quotationChainLinkModel?.chainLinkCost,"chainLinkDiscountPercent":model?.quotationChainLinkModel?.chainLinkDiscountPercent,"chainLinkDiscount":model?.quotationChainLinkModel?.chainLinkDiscount,"chainLinkTax":model?.quotationChainLinkModel?.chainLinkTax,"netChainLinkCost":model?.quotationChainLinkModel?.netChainLinkCost]],
				"weldSideMeshDetails":["model":["weldSideCost":model?.quotationWeldSideModel?.weldSideCost],
								"parts":["rows":weldSideItems,"weldSideCost":model?.quotationWeldSideModel?.weldSideCost,"weldSideDiscountPercent":model?.quotationWeldSideModel?.weldSideDiscountPercent,"weldSideDiscount":model?.quotationWeldSideModel?.weldSideDiscount,"weldSideTax":model?.quotationWeldSideModel?.weldSideTax,"netWeldSideCost":model?.quotationWeldSideModel?.netWeldSideCost]]])
		}
		
		def responseData = [  "taxation":taxation?.id,
			
							   "custInfo":["id":quotationInstance?.customer?.customerId,"compname":quotationInstance?.customer?.companyName,"custname":quotationInstance?.customer?.customerName,"mobile":quotationInstance?.customer?.mobileNumber,"address":quotationInstance?.customer?.address],
			
							   "quotInfo":["id":quotationInstance?.id,"quotation":quotationInstance?.quotationId,"status":quotationInstance?.status,"createdby":quotationInstance?.createdBy?.toString(),"createddate":quotationInstance?.createdDate?.format("dd/MM/yyyy"),"enquiry":quotationInstance?.enquiry?.enquiryId, "comments":quotationInstance?.comments],
							
							   "specsInfo":["cageLength":quotationInstance?.cageLength,"noOfCuttingsInShed":quotationInstance?.noOfCuttingsInShed,"noOfSheds":quotationInstance?.noOfSheds,"fulls":quotationInstance?.fulls,"halfs":quotationInstance?.halfs,"tiers":quotationInstance?.tiers],
							   
							   "quotationModels":quotationModel
							   
						   ]
		
		println'responseData '+responseData
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "OK" : "NODATA"
		]}
		
	}
	
	def quotationPdf1() {
		println'params '+params
		def quotationInstance = Quotation.get(params.id)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
				
		def image = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/grails_logo.jpg"))
		
		renderPdf(template: "quotationPdf1", model: [quotationInstance: quotationInstance, quotationModelInstance: quotationModelInstance, imageBytes: image.bytes], filename: quotationInstance.customer.customerName+".pdf")
	}
	
	def quotationPdf2() {
		println'params '+params
		def quotationInstance = Quotation.get(params.id)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
				
		def image = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/grails_logo.jpg"))
		
		renderPdf(template: "quotationPdf2", model: [quotationInstance: quotationInstance, quotationModelInstance: quotationModelInstance, imageBytes: image.bytes], filename: quotationInstance.customer.customerName+".pdf")
	}
	
	def quotationPdf3() {
		println'params '+params
		def quotationInstance = Quotation.get(params.id)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
				
		def image = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/grails_logo.jpg"))
		
		renderPdf(template: "quotationPdf3", model: [quotationInstance: quotationInstance, quotationModelInstance: quotationModelInstance, imageBytes: image.bytes], filename: quotationInstance.customer.customerName+".pdf")
	}
	
	def quotationPdf4() {
		println'params '+params
		def quotationInstance = Quotation.get(params.id)
		def quotationModelInstance = QuotationModel.get(params.quotationModel)
				
		def image = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/grails_logo.jpg"))
		
		renderPdf(template: "quotationPdf4", model: [quotationInstance: quotationInstance, quotationModelInstance: quotationModelInstance, imageBytes: image.bytes], filename: quotationInstance.customer.customerName+".pdf")
	}
			
}


