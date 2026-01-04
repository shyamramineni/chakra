package com.chakra.service

import com.chakra.config.SideMesh
import com.chakra.config.WireBrand
import com.chakra.production.WeldSideMeshReporting
import com.chakra.production.WeldSideMeshReportingWireWeight
import com.chakra.rawmaterial.WireReceiptReporting
import com.chakra.stock.WeldSideMeshStock

class WeldSideMeshService {

	static transactional = true
	
	def weldSideMeshSave(params, wireBrand, sideMesh) {
		
		def weldSideMeshReportingInstance = new WeldSideMeshReporting(params)
		def wireBrandInstance = WireBrand.get(params.wireBrand.id)
		println'wireBrandInstance '+wireBrandInstance
		def sideMeshInstance = SideMesh.get(params.sideMesh.id)
		println'sideMeshInstance '+sideMeshInstance
		
		BigDecimal wireWeight =  sideMeshInstance.weight * weldSideMeshReportingInstance.totalQuantity
		println'wireWeight '+wireWeight
		
		def wireInventoryList = WireReceiptReporting.findAllByAvailabilityStatusAndWireDiameterAndWireBrand(true,sideMeshInstance.wireDiameter, wireBrand)
		println'wireInventoryList '+wireInventoryList
		
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
		
			println'rem Weight '+remainingWtg
			if(remainingWtg > 0) {
	
				println "Wire Not available so returning"
				weldSideMeshReportingInstance.errors.reject('wire.not.found.message')
				return
			}
		//}
		
		//if(remainingWtg > 0) {
					
			//wireInventoryList.each { wireInventory ->
				
				WeldSideMeshReportingWireWeight weldSideMeshReportWireWeight = new WeldSideMeshReportingWireWeight()
				weldSideMeshReportWireWeight.wireBrand = wireBrandInstance
				weldSideMeshReportWireWeight.wireConsumptionDate = weldSideMeshReportingInstance.stockManufacturedTime
				weldSideMeshReportWireWeight.diameter = sideMeshInstance.wireDiameter
				weldSideMeshReportWireWeight.wireReceiptReporting = wireInventory
				
				if (wireInventory.weightInStock >= wireWeight) {
					weldSideMeshReportWireWeight.weight = wireWeight
					wireInventory.weightInStock -= wireWeight
					remainingWtg = 0;
				} else if(wireInventory.weightInStock < wireWeight)  {
					weldSideMeshReportWireWeight.weight = wireInventory.weightInStock
					wireWeight -= wireInventory.weightInStock
					wireInventory.weightInStock = 0
				}
				
				if (wireInventory.weightInStock <= 0) {
					wireInventory.availabilityStatus = false
				}
				println "Updating wire inventory"
				if (!wireInventory.save(flush: true)) {
					//flash.message = "Error saving RawMaterial";
					//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
					weldSideMeshReportingInstance.errors.reject('error.saving.mesage')
					return
				}
				println "Adding WeldSideMeshReportingWireWeight"
				weldSideMeshReportingInstance.addToWeldSideMeshReportingWireWeightList(weldSideMeshReportWireWeight)
			//}
		}
		
		if (!weldSideMeshReportingInstance.save(flush: true)) {
			//flash.message = "Error saving ProductionReporting"
			//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
			weldSideMeshReportingInstance.errors.reject("error.saving.mesage")
			return
		}
		
		
		log.debug "Saved weldSideMeshReportingInstance"
		log.debug "Saving stock"
		
		def weldSideMeshStockInstance = new WeldSideMeshStock()
		weldSideMeshStockInstance.noOfInStock = weldSideMeshReportingInstance.totalQuantity
		weldSideMeshStockInstance.machine = weldSideMeshReportingInstance.machine
		weldSideMeshStockInstance.sideMesh = weldSideMeshReportingInstance.sideMesh
		weldSideMeshStockInstance.wireBrand = weldSideMeshReportingInstance.wireBrand
		weldSideMeshStockInstance.noOfManufactured = weldSideMeshReportingInstance.totalQuantity
		
		weldSideMeshStockInstance.availabilityStatus = true
		weldSideMeshStockInstance.weldSideMeshStockId = 'WMST'+weldSideMeshReportingInstance.stockManufacturedTime.format("ddMMyyhhmmss")
		
		weldSideMeshStockInstance.stockManufacturedTime = weldSideMeshReportingInstance.stockManufacturedTime
		println "Saved stock"
		
		println"Saving New stock"
				
		if (!weldSideMeshStockInstance.save(flush: true)) {
			weldSideMeshStockInstance.errors.each {
				println it
			}
			//flash.message = "Problem with stock saving"
			throw new RuntimeException("Error saving WeldSideMeshStock")
			//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
			return
		}
		
		log.debug "Saved New stock"
		
		weldSideMeshReportingInstance.weldSideMeshStock = weldSideMeshStockInstance
		//def emptyList = []
		//emptyList.get(1)
		if (!weldSideMeshReportingInstance.save(flush: true)) {
			weldSideMeshReportingInstance.errors.each {
				println it
			}
			//flash.message = "Problem with production reporting saving"
			throw new RuntimeException("Error saving WeldSideMeshReporting")
			return
		}
		
		return weldSideMeshReportingInstance
	}
	
}
