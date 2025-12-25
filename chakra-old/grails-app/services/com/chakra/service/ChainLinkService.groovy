package com.chakra.service

import com.chakra.config.LinkMesh
import com.chakra.config.WireBrand
import com.chakra.production.ChainLinkReporting
import com.chakra.production.ChainLinkReportingWireWeight
import com.chakra.rawmaterial.WireReceiptReporting
import com.chakra.stock.ChainLinkStock

class ChainLinkService {

	static transactional = true
	
	def springSecurityService
	
	def chainLinkSave(params, wireBrand, linkMesh) {
		
		def chainLinkReportingInstance = new ChainLinkReporting(params)
		def wireBrandInstance = WireBrand.get(params.wireBrand.id)
		println'wireBrandInstance '+wireBrandInstance
		def linkMeshInstance = LinkMesh.get(params.linkMesh.id)
		println'linkMeshInstance '+linkMeshInstance
		
		BigDecimal wireWeight =  linkMeshInstance.weight * chainLinkReportingInstance.totalQuantity
		println'wireWeight '+wireWeight
		
		def wireInventoryList = WireReceiptReporting.findAllByAvailabilityStatusAndWireDiameterAndWireBrand(true,linkMeshInstance.wireDiameter, wireBrand)
		println'wireInventoryList '+wireInventoryList
		
		boolean wireAvailable = true
		//println'rem Weight'+remainingWtg
		wireInventoryList.each { wireInventory ->
			//println"in wireInventoryList"+wireInventoryList
			if (wireInventory.weightInStock >= wireWeight) {
				wireAvailable = true
			} else if(wireInventory.weightInStock < wireWeight)  {
				//remainingWtg -= wireInventory.weightInStock
				wireAvailable = false
			}
			//println'rem Weight'+remainingWtg
		
			//println'rem Weight '+remainingWtg
			if(!wireAvailable) {
	
				println "Wire Not available so returning"
				chainLinkReportingInstance.errors.reject('wire.not.found.message')
				return
			}
		}
		
		if(wireAvailable) {
					
			wireInventoryList.each { wireInventory ->
				
				ChainLinkReportingWireWeight chainLinkReportWireWeight = new ChainLinkReportingWireWeight()
				chainLinkReportWireWeight.wireBrand = wireBrandInstance
				chainLinkReportWireWeight.wireConsumptionDate = chainLinkReportingInstance.stockManufacturedTime
				chainLinkReportWireWeight.diameter = linkMeshInstance.wireDiameter
				chainLinkReportWireWeight.wireReceiptReporting = wireInventory
				
				if (wireInventory.weightInStock >= wireWeight) {
					chainLinkReportWireWeight.weight = wireWeight
					wireInventory.weightInStock -= wireWeight
					//remainingWtg = 0;
				} else if(wireInventory.weightInStock < wireWeight)  {
					chainLinkReportWireWeight.weight = wireInventory.weightInStock
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
					chainLinkReportingInstance.errors.reject('error.saving.mesage')
					return
				}
				println "Adding WeldsideMeshReportingWireWeight"
				chainLinkReportingInstance.addToChainLinkReportingWireWeightList(chainLinkReportWireWeight)			
			}
		}
		
		if (!chainLinkReportingInstance.save(flush: true)) {
			//flash.message = "Error saving ProductionReporting"
			//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
			chainLinkReportingInstance.errors.reject("chainLinkReportingInstance","Error saving ChainLinkReporting")
			return
		}
		
		
		log.debug "Saved chainLinkReportingInstance"
		log.debug "Saving stock"
		
		def chainLinkStockInstance = new ChainLinkStock()
		chainLinkStockInstance.noOfInStock = chainLinkReportingInstance.totalQuantity
		chainLinkStockInstance.machine = chainLinkReportingInstance.machine
		chainLinkStockInstance.linkMesh = chainLinkReportingInstance.linkMesh
		chainLinkStockInstance.wireBrand = chainLinkReportingInstance.wireBrand
		chainLinkStockInstance.noOfManufactured = chainLinkReportingInstance.totalQuantity
		
		chainLinkStockInstance.availabilityStatus = true
		chainLinkStockInstance.chainLinkStockId = 'CLST'+chainLinkReportingInstance.stockManufacturedTime.format("ddMMyyhhmmss")
		
		chainLinkStockInstance.stockManufacturedTime = chainLinkReportingInstance.stockManufacturedTime
		println "Saved stock"
		
		println"Saving New stock"
				
		if (!chainLinkStockInstance.save(flush: true)) {
			chainLinkStockInstance.errors.each {
				println it
			}
			//flash.message = "Problem with stock saving"
			throw new RuntimeException("Error saving ChainLinkStock")
			//render(view: "create", model: [productionReportingInstance: productionReportingInstance])
			return
		}
		
		log.debug "Saved New stock"
		
		chainLinkReportingInstance.chainLinkStock = chainLinkStockInstance
		//def emptyList = []
		//emptyList.get(1)
		if (!chainLinkReportingInstance.save(flush: true)) {
			chainLinkReportingInstance.errors.each {
				println it
			}
			//flash.message = "Problem with production reporting saving"
			throw new RuntimeException("Error saving ChainLinkReporting")
			return
		}
		
		return chainLinkReportingInstance
	}
}
