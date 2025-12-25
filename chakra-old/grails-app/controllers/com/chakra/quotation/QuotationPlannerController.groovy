package com.chakra.quotation

import grails.converters.JSON
import java.math.RoundingMode
import com.chakra.config.CageDesign
import com.chakra.config.CagePartPrice
import com.chakra.config.CagePartSpecification
import com.chakra.config.Taxation
import com.chakra.config.WireBrand
import com.chakra.config.WirePrice
import com.chakra.customer.Customer
import com.chakra.notifications.Notification
import com.chakra.service.FormulaService
import com.chakra.service.NotificationService

class QuotationPlannerController {
	
	def springSecurityService
	
	def create() {		
		render(view: "quotationPlanner")
	}
    	
	def quotationPlanner() {
		println'params '+params		
		FormulaService formulaService = new FormulaService()
		
		Quotation quotationInstance = new Quotation(params)
		def wireBrandInstance = WireBrand.get(params.wireBrand.id)
		def taxationInstance = Taxation.get(params.taxation.id)
		println'taxationInstance '+taxationInstance
		if(taxationInstance == null){
			println'in if'
			flash.message = "Select Taxation"
			render(view: "quotationPlanner")
			return
		}
				
		def taxPercent = taxationInstance.percent
		log.debug'taxPercent'+taxPercent
		
		def cageDesignList = CageDesign.findAll()
		log.debug'cageDesignList '+cageDesignList
		
		List costList = new ArrayList()
		List noOfBirdsList = new ArrayList()
		List taxList = new ArrayList()
		List totalCostList = new ArrayList()
		List costPerBirdList = new ArrayList()
		
		
		def cagePartSpecList
						
		cageDesignList.each  { cageDesignInstance ->
			
			BigDecimal noOfBirds = 0
			BigDecimal meshCost = 0
			BigDecimal tax = 0
			BigDecimal totalCost = 0
			def totalWeight = 0
			BigDecimal cagePartsTotalCost = 0
			def variables = ["cageLength": quotationInstance.cageLength, "fulls":quotationInstance.fulls,"halfs":quotationInstance.halfs,"noOfCuttingsInShed":quotationInstance.noOfCuttingsInShed,"tiers":quotationInstance.tiers
					,"noOfSingleBottomsPerSheet":cageDesignInstance.noOfSingleBottomsPerSheet,"noOfPartitionsPerSheetLength":cageDesignInstance.noOfPartitionsPerSheetLength,"sheetLength":cageDesignInstance.sheetLength,"noOfBirdsPerCageSingleBox":cageDesignInstance.noOfBirdsPerCageSingleBox,"noOfBirdsPerCageDoubleBox":cageDesignInstance.noOfBirdsPerCageDoubleBox]
	
			def doubleBox = ((( quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.fulls))
			def singleBox = (quotationInstance.cageLength/cageDesignInstance.sheetLength)*(quotationInstance.fulls)*((quotationInstance.tiers-1)*2)+((quotationInstance.cageLength/cageDesignInstance.sheetLength)*quotationInstance.halfs*quotationInstance.tiers)
			noOfBirds = (doubleBox*2*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageDoubleBox)+(singleBox*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageSingleBox)
									
			def sheetSpecFormList = cageDesignInstance.cageDesignSheetSpecFormula
			BigDecimal noSheetPerSheetSpec = 0
			def totMeshSheetCost = 0
			def meshSheetCost = 0
			
			if(wireBrandInstance != null) {
				sheetSpecFormList.each { sheetSpecFor ->
					
					noSheetPerSheetSpec = formulaService.evalFormula(variables, sheetSpecFor.formula)
					log.debug'noSheetPerSheetSpec '+noSheetPerSheetSpec
					
					noSheetPerSheetSpec = noSheetPerSheetSpec.setScale(0, RoundingMode.UP)
					println'noSheetPerSheetSpec '+noSheetPerSheetSpec
					
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
					
					meshCost = (totMeshSheetCost*quotationInstance.noOfSheds)
					log.debug'Mesh cost: '+meshCost
				
				}
				
			}
			
			log.debug 'params'+params
			cagePartSpecList = params.cagePartSpecification
			def cagePartTypeList = params.cagePartType
			log.debug 'cagePartSpecList '+cagePartSpecList
			log.debug'cagePartTypeList '+cagePartTypeList
	
				for(int i=0;(i<=cagePartSpecList.size()-1);i++) {
										
					if (!(cagePartSpecList.getAt(i) ==  "null")) {
						log.debug'cagePartSpecList.getAt(i)'+cagePartSpecList.getAt(i)
						CagePartSpecification cagePartSpecification = CagePartSpecification.get(cagePartSpecList.getAt(i))
						log.debug "cagePartSpecification "+cagePartSpecification
						def cagePartSpecFormulaList = cagePartSpecification.cagePartSpecFormulaList
						cagePartSpecFormulaList.each { cagePartSpecFormula ->
							log.debug "cagePartType.formula "+cagePartSpecFormula.formula
							BigDecimal noOfParts = formulaService.evalFormula(variables, cagePartSpecFormula.formula)
							log.debug 'noOfParts '+noOfParts
							noOfParts = noOfParts.setScale(0, RoundingMode.UP)
							log.debug''+cagePartSpecFormula.cagePart+':'+noOfParts
	
	
							QuotationCagePart quotationCagePart = new QuotationCagePart()
	
							quotationCagePart.noOfCageParts = noOfParts
							quotationCagePart.cagePartSpecFormula = cagePartSpecFormula
	
	
							List cagePartPriceList = CagePartPrice.findAllByCagePart(cagePartSpecFormula.cagePart)
							log.debug'cagePartPrice'+cagePartPriceList
								
							CagePartPrice cagePartPrice = cagePartPriceList.get(0)
	
							quotationCagePart.priceOfEachCagePart = cagePartPrice.price
							quotationCagePart.costOfCagePart = (quotationCagePart.noOfCageParts * quotationCagePart.priceOfEachCagePart)
							cagePartsTotalCost += quotationCagePart.costOfCagePart
							
						}
	
					}
							
				}
	
			println "cagePartsTotalCost "+ cagePartsTotalCost
			cagePartsTotalCost = cagePartsTotalCost*quotationInstance.noOfSheds
			println "cagePartsTotalCost "+ cagePartsTotalCost
					
			println'cageDesign '+cageDesignInstance.cageDesign
			println'meshCost '+meshCost
			println'noOfBirds '+noOfBirds
						
			BigDecimal cost = meshCost+cagePartsTotalCost
			println'cost '+cost
			tax = ((taxPercent/100)*cost)
			totalCost = cost+tax
			def costPerBird = (totalCost/noOfBirds)
			println'costPerBird '+costPerBird
			costList.add(meshCost+cagePartsTotalCost)
			noOfBirdsList.add(noOfBirds)
			taxList.add(tax)
			totalCostList.add(totalCost)
			costPerBirdList.add(costPerBird)
				
		}
		println'cageDesignList '+cageDesignList
		println'noOfBirdsList '+noOfBirdsList
		println'totalCostList '+totalCostList
		println'costPerBirdList '+costPerBirdList
						
		[cageLength: quotationInstance.cageLength, fulls: quotationInstance.fulls, halfs: quotationInstance.halfs, tiers: quotationInstance.tiers, noOfCuttingsInShed: quotationInstance.noOfCuttingsInShed, noOfSheds: quotationInstance.noOfSheds, cageDesignInstance: cageDesignList, wireBrand: wireBrandInstance, noOfBirds: noOfBirdsList, cost: costList, taxation: taxationInstance, tax: taxList, totalCost: totalCostList, cagePartSpecList: cagePartSpecList, costPerBird: costPerBirdList]
	}
	
	def createQuotation() {
		
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
		
		List meshParts = new ArrayList()
		List cageParts = new ArrayList()
		
		//[quotationInstance: new Quotation(params), cageDesign: cageDesignInstance, wireBrand: wireBrandInstance, taxation: taxationInstance, noOfBirds: noOfBirds, cost:cost, tax: tax, totalCost: totalCost, cagePartSpecList: cagePartSpecList]
		
		FormulaService formulaService = new FormulaService()
		
		def variables = ["cageLength": cageLength, "fulls":fulls,"halfs":halfs,"noOfCuttingsInShed":noOfCuttingsInShed,"tiers":tiers
					,"noOfSingleBottomsPerSheet":cageDesignInstance.noOfSingleBottomsPerSheet,"noOfPartitionsPerSheetLength":cageDesignInstance.noOfPartitionsPerSheetLength,"sheetLength":cageDesignInstance.sheetLength,"noOfBirdsPerCageSingleBox":cageDesignInstance.noOfBirdsPerCageSingleBox,"noOfBirdsPerCageDoubleBox":cageDesignInstance.noOfBirdsPerCageDoubleBox]

		def doubleBox = ((( cageLength/cageDesignInstance.sheetLength)*fulls))
		def singleBox = (cageLength/cageDesignInstance.sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/cageDesignInstance.sheetLength)*halfs*tiers)
		def noOfBirds = (doubleBox*2*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageDoubleBox)+(singleBox*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageSingleBox)
		println'noOfBirds '+noOfBirds
		
		BigDecimal meshCost = 0
		BigDecimal noSheetPerSheetSpec = 0
		def totMeshSheetCost = 0
		def meshSheetCost = 0
		def sheetSpecDiscount = 0
		def totSheetSpecDiscount = 0
		def netMeshCost = 0
			
		def sheetSpecForList = cageDesignInstance.cageDesignSheetSpecFormula
		println'sheetSpecForList '+sheetSpecForList
		
		if(wireBrandInstance != null) {
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
				meshParts.add(sheetSpecFor.sheetSpecification.id)				
			}
	
			
			meshCost = (totMeshSheetCost*noOfSheds)
			println'Mesh cost: '+meshCost
			
			def meshDiscountPercent = ((totSheetSpecDiscount*100)/meshCost)
			netMeshCost = (meshCost-totSheetSpecDiscount)
		}
		
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
					BigDecimal noOfParts = formulaService.evalFormula(variables, cagePartSpecFormula.formula)
					println 'noOfParts '+noOfParts
					noOfParts = noOfParts.setScale(0, RoundingMode.UP)
					println''+cagePartSpecFormula.cagePart+':'+noOfParts
		
					List cagePartPriceList = CagePartPrice.findAllByCagePart(cagePartSpecFormula.cagePart)
					println'cagePartPrice'+cagePartPriceList
					
					CagePartPrice cagePartPrice = cagePartPriceList.get(0)
	
					def priceOfEachCagePart = cagePartPrice.price
					def costOfCagePart = (priceOfEachCagePart*noOfParts)
					cagePartsTotalCost += costOfCagePart
					
				}
				cageParts.add(cagePartSpecList.getAt(i))
	
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
		
		/*def quotationPalnnerModelInfo = ["cageDesign":cageDesignInstance.id,"noOfBirds":noOfBirds,"cost":cost,"tax":tax,"totalCost":totalCost,
			
			"modelInfo":[
				"meshPartsDetails":["model":["cageDesign":cageDesignInstance.id,"wireBrand":wireBrandInstance.id,"singleBox":singleBox,"doubleBox":doubleBox,"costPerBird":costPerBird,"noOfBirds":noOfBirds,"meshCost":meshCost],
					"parts":["rows":meshParts,"meshCost":meshCost,"meshDiscountPercent":meshDiscountPercent,"meshDiscount":totSheetSpecDiscount,"netMeshCost":netMeshCost],
				],
				"cagePartsDetails":["model":["cageDesign":cageDesignInstance.id,"costPerBird":costPerBird,"noOfBirds":noOfBirds,"cagePartCost":cagePartsTotalCost],
					"parts":["rows":cageParts,"cagePartCost":cagePartsTotalCost]
				]
			]
		]*/
		def quotationPalnnerModelInfo = ["cageDesign":cageDesignInstance.id,"wireBrand":wireBrandInstance?.id,"taxation":taxationInstance.id,"meshParts":meshParts,"cageParts":cageParts]
		render(view: "/quotation/quotation", model: [taxationInstance: taxationInstance, quotationPlannerSpecs: quotationPlannerSpecs as JSON, quotationPalnnerModelInfo: quotationPalnnerModelInfo as JSON])
	}
	
	def quotationPlannerSubmit(){
		
		println'params '+params
		def quotationPlanData = JSON.parse(params.requestData)
		println'quotationPlanData '+quotationPlanData
		def quotationData = quotationPlanData.modelInfo
		def quotationSpecs = quotationPlanData.quotSpecs
		def customer = quotationPlanData.customerId.toBigDecimal()
		def cageDesign = quotationData.cageDesign.toBigDecimal()
		def wireBrand = quotationData.wireBrand.toString()
		def taxation = quotationData.taxation.toBigDecimal()
		println'quotationData'+quotationData
		println'quotationSpecs'+quotationSpecs
		println'customer'+customer
		println'wireBrand '+wireBrand
		def cagePartSpecList = quotationData.cageParts
		def cageLength = quotationSpecs.cageLength.toBigDecimal()
		def fulls = quotationSpecs.fulls.toBigDecimal()
		def halfs = quotationSpecs.halfs.toBigDecimal()
		def tiers = quotationSpecs.tiers.toBigDecimal()
		def noOfCuttingsInShed = quotationSpecs.noOfCuttingsInShed.toBigDecimal()
		def noOfSheds = quotationSpecs.noOfSheds.toBigDecimal()
		println'cagePartSpecList '+cagePartSpecList		
		def customerInstance = Customer.get(customer)
		def	wireBrandInstance = null
		if(wireBrand != 'null'){
			wireBrandInstance = WireBrand.get(wireBrand.toBigDecimal())
		}
		def cageDesignInstance = CageDesign.get(cageDesign)
		def taxationInstance =  Taxation.get(taxation)
		println'taxationInstance '+taxationInstance
		def taxPercent = taxationInstance.percent
		
		FormulaService formulaService = new FormulaService()
		
		def variables = ["cageLength": cageLength, "fulls":fulls,"halfs":halfs,"noOfCuttingsInShed":noOfCuttingsInShed,"tiers":tiers
					,"noOfSingleBottomsPerSheet":cageDesignInstance.noOfSingleBottomsPerSheet,"noOfPartitionsPerSheetLength":cageDesignInstance.noOfPartitionsPerSheetLength,"sheetLength":cageDesignInstance.sheetLength,"noOfBirdsPerCageSingleBox":cageDesignInstance.noOfBirdsPerCageSingleBox,"noOfBirdsPerCageDoubleBox":cageDesignInstance.noOfBirdsPerCageDoubleBox]

		def doubleBox = ((( cageLength/cageDesignInstance.sheetLength)*fulls))
		def singleBox = (cageLength/cageDesignInstance.sheetLength)*(fulls)*((tiers-1)*2)+((cageLength/cageDesignInstance.sheetLength)*halfs*tiers)
		def noOfBirds = (doubleBox*2*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageDoubleBox)+(singleBox*cageDesignInstance.noOfPartitionsPerSheetLength*cageDesignInstance.noOfBirdsPerCageSingleBox)
		println'noOfBirds '+noOfBirds
		
		BigDecimal meshCost = 0
		BigDecimal noSheetPerSheetSpec = 0
		def totMeshSheetCost = 0
		def meshSheetCost = 0
		def sheetSpecDiscount = 0
		def totSheetSpecDiscount = 0
		def netMeshCost = 0
			
		def sheetSpecForList = cageDesignInstance.cageDesignSheetSpecFormula
		println'sheetSpecForList '+sheetSpecForList
		
		Quotation quotationInstance = new Quotation()
		
		quotationInstance.fulls = fulls
		quotationInstance.halfs = halfs
		quotationInstance.tiers = tiers
		quotationInstance.cageLength = cageLength
		quotationInstance.noOfCuttingsInShed = noOfCuttingsInShed
		quotationInstance.noOfSheds = noOfSheds
		quotationInstance.customer = customerInstance
		if (!quotationInstance.save(flush: true)) {
			quotationInstance.errors.each {
				println it
			}			
		}
		
		QuotationModel quotationModel = new QuotationModel()
		
		QuotationCagePartModel quotationCagePartModel = new QuotationCagePartModel()
		QuotationMeshModel quotationMeshModel =  new QuotationMeshModel()
		QuotationChainLinkModel quotationChainLinkModel = new QuotationChainLinkModel()
		QuotationWeldSideModel quotationWeldSideModel =  new QuotationWeldSideModel()
		
		QuotationCagePart quotationCagePart = null
		QuotationMeshPart quotationMeshPart = null
		
		if(wireBrand != 'null') {
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
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec) * (crossWirePrice.sheetSpecDiscount/100)) +( ((lineWireWeight2*lineWirePrice2.price) * noSheetPerSheetSpec )*(lineWirePrice2.sheetSpecDiscount/100))
					println'sheetSpecDiscount'+sheetSpecDiscount
					
					println'meshSheetCost '+meshSheetCost
				} else if(sheetSpecFor.sheetSpecification.lineWireDiameter1 > 0) {
				
					meshSheetCost = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec)
					println'meshSheetCost '+meshSheetCost
					sheetSpecDiscount = ((((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)) * noSheetPerSheetSpec) * (crossWirePrice.sheetSpecDiscount/100))
					println'sheetSpecDiscount'+sheetSpecDiscount
				}
				totMeshSheetCost += meshSheetCost
				totSheetSpecDiscount += sheetSpecDiscount
				println'totMeshSheetCost '+totMeshSheetCost
				
				quotationMeshPart = new QuotationMeshPart()
				quotationMeshPart.wireBrand = wireBrandInstance
				quotationMeshPart.sheetSpecification = sheetSpecFor.sheetSpecification
				quotationMeshPart.noOfMeshParts = noSheetPerSheetSpec
				quotationMeshPart.meshCost = meshSheetCost
				quotationMeshModel.addToQuotationMeshParts(quotationMeshPart)
			}
		
		meshCost = (totMeshSheetCost*noOfSheds)
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
		
		}
		
		BigDecimal cagePartsTotalCost = 0
				
		/*for(int i=0;(i<=cagePartSpecList.size()-1);i++) {
			
			if (!(cagePartSpecList.getAt(i) ==  "null")) {
	
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
	
	
					quotationCagePart = new QuotationCagePart()
	
					quotationCagePart.noOfCageParts = noOfParts
					quotationCagePart.cagePartSpecFormula = cagePartSpecFormula
	
	
					List cagePartPriceList = CagePartPrice.findAllByCagePart(cagePartSpecFormula.cagePart)
					println'cagePartPrice'+cagePartPriceList
					
					CagePartPrice cagePartPrice = cagePartPriceList.get(0)
	
					quotationCagePart.priceOfEachCagePart = cagePartPrice.price
					quotationCagePart.costOfCagePart = (quotationCagePart.noOfCageParts * quotationCagePart.priceOfEachCagePart)
					cagePartsTotalCost += quotationCagePart.costOfCagePart
					quotationCagePartModel.addToQuotationCageParts(quotationCagePart)
				}
	
			}
		}*/
		println'cagePartSpecList.size() '+cagePartSpecList.size()
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
	
	
					quotationCagePart = new QuotationCagePart()
	
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
				quotationCagePartSpecification.cagePartSpecCost = cagePartSpecCost
				quotationCagePartSpecification.costPerBird = ((cagePartSpecCost+cagePartSpecTax)/noOfBirds)
				quotationCagePartModel.addToQuotationCagePartSpecs(quotationCagePartSpecification)
			}
		}
	
		println "cagePartsTotalCost "+ cagePartsTotalCost
		cagePartsTotalCost = cagePartsTotalCost*noOfSheds
		println "cagePartsTotalCost "+cagePartsTotalCost
		
		def cagePartTax = ((taxPercent/100)*cagePartsTotalCost)
		
		quotationCagePartModel.cageDesign = cageDesignInstance
		quotationCagePartModel.costPerBird = ((cagePartsTotalCost+cagePartTax)/noOfBirds)
		quotationCagePartModel.noOfBirds = noOfBirds
		quotationCagePartModel.cagePartCost = (cagePartsTotalCost+cagePartTax)
		quotationCagePartModel.cagePartTax = cagePartTax 
		
		BigDecimal cost = cagePartsTotalCost+netMeshCost
		BigDecimal tax = ((taxPercent/100)*cost)
		BigDecimal totalCost = (cost+tax)
		BigDecimal costPerBird = (totalCost/noOfBirds)
		println'cost '+cost
		println'tax '+tax
		println'totalCost '+totalCost
		
		quotationModel.cost = cost
		quotationModel.tax = tax
		quotationModel.noOfBirds = noOfBirds
		quotationModel.totalCost =totalCost
		quotationModel.costPerBird = costPerBird
		quotationModel.cageDesign = cageDesignInstance
		quotationModel.taxation = taxationInstance
		quotationModel.quotationMeshModel = quotationMeshModel
		quotationModel.quotationCagePartModel = quotationCagePartModel
		quotationModel.quotationChainLinkModel = quotationChainLinkModel
		quotationModel.quotationWeldSideModel = quotationWeldSideModel
		
		if(wireBrand == 'null') {
			quotationInstance.isMeshQuotation = false
		} else {
			quotationInstance.isMeshQuotation = true
		}
		if(cagePartSpecList.size() == 0) {
			quotationInstance.isCageQuotation = false
		} else {
			quotationInstance.isCageQuotation = true
		}
		
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
		
		List meshParts = new ArrayList()
		//List cageParts = new ArrayList()
		def rows = new ArrayList()
		
		def cagePartData = quotationModel?.quotationCagePartModel?.quotationCagePartSpecs
		println'cagePartData '+cagePartData
		def meshPartData = quotationModel?.quotationMeshModel?.quotationMeshParts
		
		if(meshPartData?.size() > 0) {
			meshPartData.each { meshPart ->
				meshParts.add(
					"sheetSpecId":meshPart.sheetSpecification.id,"sheetId":meshPart.sheetSpecification.sheetSpecId, "wireBrand":meshPart.wireBrand.toString(), "sheetSpecification":meshPart.sheetSpecification.toString(), "noOfMeshParts":meshPart.noOfMeshParts, "costOfMeshPart":meshPart.meshCost)
			}
		}
		if(cagePartData?.size() > 0) {
				
				cagePartData.each { cagePartSpec ->
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
		
		def responseData = [
			
			"quotationId":quotationInstance.quotationId,
			"quotationInfo":["id":quotationInstance?.id,"quotation":quotationInstance?.quotationId,"status":quotationInstance?.status,"createdby":quotationInstance?.createdBy.toString(),"createddate":quotationInstance?.createdDate?.format("dd/MM/yyyy"),"comments":quotationInstance?.comments],
			"quotationSpecs":["cageLength":quotationInstance?.cageLength,"noOfCuttingsInShed":quotationInstance?.noOfCuttingsInShed,"noOfSheds":quotationInstance?.noOfSheds,"fulls":quotationInstance?.fulls,"halfs":quotationInstance?.halfs,"tiers":quotationInstance?.tiers],
			"quotationModel":[
				"model":["id":quotationModel?.id,"cageDesign":cageDesignInstance?.toString(),"noOfBirds":quotationModel?.noOfBirds,"costPerBird":quotationModel?.costPerBird,"cost":quotationModel?.cost,"tax":quotationModel?.tax,"totalCost":quotationModel?.totalCost],
				"modelInfo":["meshPartsDetails":["model":["cageDesign":quotationMeshModel?.cageDesign?.toString(),"wireBrand":quotationMeshModel?.wireBrand?.toString(),"singleBox":quotationMeshModel?.singleBox,"doubleBox":quotationMeshModel?.doubleBox,"costPerBird":quotationMeshModel?.costPerBird,"noOfBirds":quotationMeshModel?.noOfBirds,"meshCost":quotationMeshModel?.netMeshCost],
								"parts":["rows":meshParts,"meshCost":quotationModel?.quotationMeshModel?.meshCost,"meshDiscountPercent":quotationModel?.quotationMeshModel?.meshDiscountPercent,"meshDiscount":quotationModel?.quotationMeshModel?.meshDiscount,"meshTax":quotationModel?.quotationMeshModel?.meshTax,"netMeshCost":quotationModel?.quotationMeshModel?.netMeshCost]
								],
							"cagePartsDetails":["model":["cageDesign":quotationModel?.quotationCagePartModel?.cageDesign?.cageDesign,"costPerBird":quotationModel?.quotationCagePartModel?.costPerBird, "noOfBirds":quotationModel?.quotationCagePartModel?.noOfBirds,"cagePartCost":quotationModel?.quotationCagePartModel?.cagePartCost],
								"parts":["rows":rows,"cagePartTax":quotationModel?.quotationCagePartModel?.cagePartTax,"cagePartCost":quotationModel?.quotationCagePartModel?.cagePartCost]
								]
							]
				]
			]
		
		println'responseData '+responseData
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': responseData ? "OK" : "NODATA"
		]}
	
	}
	
}
