package com.chakra.service

import com.chakra.config.SheetSpecification
import com.chakra.config.WireBrand
import com.chakra.production.ProductionReporting
import com.chakra.production.ProductionReportingWireWeight
import com.chakra.rawmaterial.WireReceiptReporting
import com.chakra.stock.Stock

class ProductionService {

    static transactional = true
	
	def springSecurityService
	
		def productionSave(params, wireBrand, sheetSpecification) {
		
		def productionReportingInstance = new ProductionReporting(params)
		def wireBrandInstance = WireBrand.get(params.wireBrand.id)
		log.debug'wireBrandInstance '+wireBrandInstance
		def sheetSpecificationInstance = SheetSpecification.get(params.sheetSpecifcation.id)
		log.debug'sheetSpecificationInstance '+sheetSpecificationInstance
										
		BigDecimal noOfCrossWires = (sheetSpecificationInstance.length/sheetSpecificationInstance.pitch)+1
		BigDecimal crossWireLength = noOfCrossWires*(sheetSpecificationInstance.width+(2*sheetSpecificationInstance.projection))
		BigDecimal lineWireLength1 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires1
		BigDecimal lineWireLength2 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires2
		
		BigDecimal crossWireWeight = ((crossWireLength/6588)*(sheetSpecificationInstance.crossWireDiameter*sheetSpecificationInstance.crossWireDiameter))
		BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(sheetSpecificationInstance.lineWireDiameter1*sheetSpecificationInstance.lineWireDiameter1))
		BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(sheetSpecificationInstance.lineWireDiameter2*sheetSpecificationInstance.lineWireDiameter2))
		
		log.debug'crossWireDiameter'+sheetSpecificationInstance.crossWireDiameter
		log.debug'lineWireDiameter1'+sheetSpecificationInstance.lineWireDiameter1
		log.debug'lineWireDiameter2'+sheetSpecificationInstance.lineWireDiameter2
		
		log.debug'crossWireWeight'+crossWireWeight
		log.debug'lineWireWeight1'+lineWireWeight1
		log.debug'lineWireWeight2'+lineWireWeight2
		
		//Checking if Raw material is available- start
		log.debug "Checking if Raw material is available- start"
		if ((sheetSpecificationInstance.crossWireDiameter == sheetSpecificationInstance.lineWireDiameter1)
			&& (sheetSpecificationInstance.lineWireDiameter2 == 0)) {
	
				log.debug "Model1"
				BigDecimal wireWeight =  (crossWireWeight + lineWireWeight1) * productionReportingInstance.totalQuantity
				log.debug'wireWeight '+wireWeight
				def wireInventoryList = WireReceiptReporting.findAllByAvailabilityStatusAndWireDiameterAndWireBrand(true,sheetSpecificationInstance.crossWireDiameter, wireBrandInstance)
	
				// Checking if Rawmaterial Inventory available
				BigDecimal remainingWtg = wireWeight;
				//println'rem Weight'+remainingWtg
				wireInventoryList.each { wireInventory ->
					//println"in wireInventoryList"+wireInventoryList
					if (wireInventory.weightInStock >= remainingWtg) {
						remainingWtg = 0;
					} else if(wireInventory.weightInStock < remainingWtg)  {
						remainingWtg -= wireInventory.weightInStock
					}
					//println'rem Weight'+remainingWtg
				}
				log.debug'rem Weight '+remainingWtg
				if(remainingWtg > 0) {
	
					log.debug "Wire Not available so returning"
					productionReportingInstance.errors.reject('wire.not.found.message')
					//flash.message = "Raw Material Inventory not available";
					//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
					return
				}
				// Checking if Rawmaterial Inventory available end
	
				
			} else if ((sheetSpecificationInstance.crossWireDiameter == sheetSpecificationInstance.lineWireDiameter1)
				&& (sheetSpecificationInstance.lineWireDiameter2 > 0)) {
				
				// Checking if Rawmaterial Inventory available
				log.debug "Model2"
				BigDecimal wireWeight1 =  (crossWireWeight + lineWireWeight1) * productionReportingInstance.totalQuantity
				BigDecimal wireWeight2 =  (lineWireWeight2) * productionReportingInstance.totalQuantity
	
				log.debug'wireWeight'+wireWeight1
				log.debug'wireWeight'+wireWeight2
	
				def wireInventoryList1 = WireReceiptReporting.findAllByAvailabilityStatusAndWireDiameterAndWireBrand(true,sheetSpecificationInstance.crossWireDiameter, wireBrandInstance)
				def wireInventoryList2 = WireReceiptReporting.findAllByAvailabilityStatusAndWireDiameterAndWireBrand(true,sheetSpecificationInstance.crossWireDiameter, wireBrandInstance)
	
				BigDecimal remainingWtg = wireWeight1;
				log.debug'rem Weight'+remainingWtg
				wireInventoryList1.each { wireInventory ->
					log.debug"in wireInventoryList"+wireInventoryList1
					if (wireInventory.weightInStock >= remainingWtg) {
						remainingWtg = 0;
					} else if(wireInventory.weightInStock < remainingWtg)  {
						remainingWtg -= wireInventory.weightInStock
					}
					log.debug'rem Weight'+remainingWtg
				}
				log.debug'rem Weight'+remainingWtg
				if(remainingWtg > 0) {
	
					log.debug "Wire Not available so returning"
					//flash.message = "Raw Material Inventory not available";
					//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
					//productionReportingInstance.errors.reject("Raw Material Inventory not available")
					return productionReportingInstance.errors.reject('wire.not.found.message')
				}
				// Checking if Rawmaterial Inventory available end
	
				
				// Checking if Rawmaterial Inventory available
				BigDecimal remainingWtg2 = wireWeight2;
				log.debug'rem Weight'+remainingWtg2
				wireInventoryList2.each { wireInventory2 ->
					log.debug"in wireInventoryList"+wireInventoryList2
					if (wireInventory2.weightInStock >= remainingWtg2) {
						remainingWtg2 = 0;
					} else if(wireInventory2.weightInStock < remainingWtg2)  {
						remainingWtg2 -= wireInventory2.weightInStock
					}
					log.debug'rem Weight'+remainingWtg2
				}
				log.debug'rem Weight'+remainingWtg2
				if(remainingWtg2 > 0) {
	
					log.debug "Wire Not available so returning"
					//flash.message = "Raw Material Inventory not available";
					//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
					productionReportingInstance.errors.reject('wire.not.found.message')
					return
				}
				// Checking if Rawmaterial Inventory available end
	
				
			}
		log.debug "Checking if Raw material is available- end"
		//Checking if Raw material is available- end
		
		
		// Allocating Raw material start
		log.debug "Allocating Raw material start"
		if ((sheetSpecificationInstance.crossWireDiameter == sheetSpecificationInstance.lineWireDiameter1)
		&& (sheetSpecificationInstance.lineWireDiameter2 == 0)) {
			
			log.debug "Model1"
			BigDecimal wireWeight =  (crossWireWeight + lineWireWeight1) * productionReportingInstance.totalQuantity
			 log.debug'wireWeight'+wireWeight
			// So drecementing raw material
			BigDecimal remainingWtg = wireWeight;
			def wireInventoryList = WireReceiptReporting.findAllByAvailabilityStatusAndWireDiameterAndWireBrand(true,sheetSpecificationInstance.crossWireDiameter, wireBrandInstance)
			wireInventoryList.each { wireInventory ->
				log.debug "Iterating remainingWtg "+remainingWtg
				if(remainingWtg > 0) {
					
					ProductionReportingWireWeight prodReportWireWeight1 = new ProductionReportingWireWeight()
					prodReportWireWeight1.wireBrand = wireBrandInstance
					prodReportWireWeight1.wireConsumptionDate = productionReportingInstance.stockManufacturedTime
					prodReportWireWeight1.diameter = sheetSpecificationInstance.crossWireDiameter
					prodReportWireWeight1.wireReceiptReporting = wireInventory
					
					if (wireInventory.weightInStock >= remainingWtg) {
						prodReportWireWeight1.weight = remainingWtg
						wireInventory.weightInStock -= remainingWtg
						remainingWtg = 0;
					} else if(wireInventory.weightInStock < remainingWtg)  {
						prodReportWireWeight1.weight = wireInventory.weightInStock
						remainingWtg -= wireInventory.weightInStock
						wireInventory.weightInStock = 0
					}
					
					if (wireInventory.weightInStock <= 0) {
						wireInventory.availabilityStatus = false
					}
					log.debug "Updating wire inventory"
					if (!wireInventory.save(flush: true)) {
						//flash.message = "Error saving RawMaterial";
						//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
						productionReportingInstance.errors.reject('error.saving.mesage')
						return
					}
					log.debug "Adding ProductionReportingWireWeight"
					productionReportingInstance.addToProductionReportingWireWeightList(prodReportWireWeight1)
				}
			}
		} else if ((sheetSpecificationInstance.crossWireDiameter == sheetSpecificationInstance.lineWireDiameter1)
			&& (sheetSpecificationInstance.lineWireDiameter2 > 0)) {
			
			log.debug "Model2"
			BigDecimal wireWeight1 =  (crossWireWeight + lineWireWeight1) * productionReportingInstance.totalQuantity
			BigDecimal wireWeight2 =  (lineWireWeight2) * productionReportingInstance.totalQuantity

			log.debug'wireWeight'+wireWeight1
			log.debug'wireWeight'+wireWeight2

			def wireInventoryList1 = WireReceiptReporting.findAllByAvailabilityStatusAndWireDiameterAndWireBrand(true,sheetSpecificationInstance.crossWireDiameter, wireBrandInstance)
			def wireInventoryList2 = WireReceiptReporting.findAllByAvailabilityStatusAndWireDiameterAndWireBrand(true,sheetSpecificationInstance.lineWireDiameter2, wireBrandInstance)

			// So drecementing raw material
			BigDecimal remainingWtg = wireWeight1;
			wireInventoryList1.each { wireInventory ->
				
				log.debug "Iterating remainingWtg "+remainingWtg
				if(remainingWtg > 0) {
					ProductionReportingWireWeight prodReportWireWeight1 = new ProductionReportingWireWeight()
					prodReportWireWeight1.wireBrand = wireBrandInstance
					prodReportWireWeight1.wireConsumptionDate = productionReportingInstance.stockManufacturedTime
					prodReportWireWeight1.diameter = sheetSpecificationInstance.crossWireDiameter
					prodReportWireWeight1.wireReceiptReporting = wireInventory
					
					if (wireInventory.weightInStock >= remainingWtg) {
						prodReportWireWeight1.weight = remainingWtg
						wireInventory.weightInStock -= remainingWtg
						remainingWtg = 0;
					} else if(wireInventory.weightInStock < remainingWtg)  {
						prodReportWireWeight1.weight = wireInventory.weightInStock
						remainingWtg -= wireInventory.weightInStock
						wireInventory.weightInStock = 0
					}
					if (wireInventory.weightInStock <= 0) {
						wireInventory.availabilityStatus = false
					}
					if (!wireInventory.save(flush: true)) {
						//flash.message = "Error saving RawMaterial";
						//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
						wireInventory.errors.reject('Error')
						return
					}
					productionReportingInstance.addToProductionReportingWireWeightList(prodReportWireWeight1)
				}
			}
			

			// So drecementing raw material
			remainingWtg = wireWeight2;
			wireInventoryList2.each { wireInventory ->
				log.debug "Iterating remainingWtg2 "+remainingWtg
				if(remainingWtg > 0) {
					ProductionReportingWireWeight prodReportWireWeight2 = new ProductionReportingWireWeight()
					prodReportWireWeight2.wireBrand = wireBrandInstance
					prodReportWireWeight2.wireConsumptionDate = productionReportingInstance.stockManufacturedTime
					prodReportWireWeight2.diameter =sheetSpecificationInstance. crossWireDiameter
					prodReportWireWeight2.wireReceiptReporting = wireInventory
					
					if (wireInventory.weightInStock >= remainingWtg) {
						prodReportWireWeight2.weight = remainingWtg
						wireInventory.weightInStock -= remainingWtg
						remainingWtg = 0;
					} else if(wireInventory.weightInStock < remainingWtg)  {
						prodReportWireWeight2.weight = wireInventory.weightInStock
						remainingWtg -= wireInventory.weightInStock
						wireInventory.weightInStock = 0
					}
					if (wireInventory.weightInStock <= 0) {
						wireInventory.availabilityStatus = false
					}
					if (!wireInventory.save(flush: true)) {
						//flash.message = "Error saving RawMaterial";
						//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
						productionReportingInstance.errors.reject("productionReportingInstance","Error saving RawMaterial")
						return
					}
					productionReportingInstance.addToProductionReportingWireWeightList(prodReportWireWeight2)
				}
			}
			
		}
		log.debug "Allocating Raw material end"
		// Allocating Raw material end
		log.debug "Saving productionReportingInstance"
		if (!productionReportingInstance.save(flush: true)) {
			//flash.message = "Error saving ProductionReporting"
			//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
			productionReportingInstance.errors.reject("productionReportingInstance","Error saving ProductionReporting")
			return
		}
		
		
		log.debug "Saved productionReportingInstance"
		log.debug "Saving stock"
		
		def stockInstance = new Stock()
		stockInstance.noOfInStock = (productionReportingInstance.totalQuantity-productionReportingInstance.mending)
		stockInstance.machine = productionReportingInstance.machine
		stockInstance.sheetSpec = productionReportingInstance.sheetSpecifcation
		stockInstance.wireBrand = productionReportingInstance.wireBrand
		stockInstance.noOfManufactured = productionReportingInstance.totalQuantity
		
		stockInstance.availabilityStatus = true
		stockInstance.stockId = 'ST'+productionReportingInstance.stockManufacturedTime.format("ddMMyyhhmmss")
		
		stockInstance.stockManufacturedTime = productionReportingInstance.stockManufacturedTime
		log.debug "Saved stock"
		
		log.debug "Saving New stock"
		productionReportingInstance.comments = params.comments+" "+"Created By "+springSecurityService.currentUser.toString()+new Date().format("dd/MM/yy-hh:mm")+"<br>"
		
		if (!stockInstance.save(flush: true)) {
			stockInstance.errors.each {
				log.error it
			}
			//flash.message = "Problem with stock saving"
			throw new RuntimeException("Error saving Stock")
			//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
			return
		}
		
		log.debug "Saved New stock"
		
		productionReportingInstance.stock = stockInstance
		//def emptyList = []
		//emptyList.get(1)
		if (!productionReportingInstance.save(flush: true)) {
			productionReportingInstance.errors.each {
				log.error it				
			}
			//flash.message = "Problem with production reporting saving"
			throw new RuntimeException("Error saving ProductionReporting")
			return
		}
		
		return productionReportingInstance
	}
}
