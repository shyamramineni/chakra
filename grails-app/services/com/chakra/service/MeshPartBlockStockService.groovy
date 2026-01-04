package com.chakra.service

import org.springframework.web.context.request.RequestContextHolder

import com.chakra.stock.Stock
import com.chakra.stock.StockOrder

class MeshPartBlockStockService {

    static transactional = true
	
	def meshStockAvailable(corder, stockAvailableMsg) {		
		
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		def corderInstance = corder
		log.debug'corderInstance '+corderInstance
		
		log.debug "blockStock Action"
		log.debug "checkingStock Availability"
		
		boolean stockAvailable = true
		String availabilityMesh
		
		corderInstance.corderMeshParts.each { orderMeshPart ->
			
			log.debug "orderMeshPart "+orderMeshPart
			BigDecimal noOfMeshParts = orderMeshPart.noOfMeshParts
			def stockForOrder = 0
			def noOfMeshParts_1=noOfMeshParts
			def stockList = Stock.findAllAvailabilityStatusBySheetSpecAndWireBrand(orderMeshPart.sheetSpecification, orderMeshPart.wireBrand)
			stockList.each { stock ->
				
				def stockInstance = Stock.get(stock.id)
				log.debug "stock "+stockInstance
				log.debug "noOfMeshParts "+noOfMeshParts
				if (noOfMeshParts == 0) {
					log.debug "stock already Identified so returning"
					return
				}
				
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
				}
				log.debug "after each iteration of stock orderMeshPart "+noOfMeshParts
			}
			noOfMeshParts = noOfMeshParts - stockForOrder
			
			if (noOfMeshParts > 0) {
				if(availabilityMesh) {
					availabilityMesh += "There is no enough stock for "+orderMeshPart.sheetSpecification +"</br>"
				} else {
					availabilityMesh = "There is no enough stock for "+orderMeshPart.sheetSpecification +"</br>"
				}
				stockAvailable = false
		
			}
		}
				
					
		if(!stockAvailable) {
			println "Stock Not available so returning"
			println availabilityMesh
			//stockAvailableMsg = availabilityMesh
			session.setAttribute("stockAvailableMsg", availabilityMesh)
			println'stockAvail '+stockAvailableMsg
			//corder.errors.reject("stock.not.available",availabilityMesh)
			return 
		}
		return stockAvailable
    }
	
	
	def meshBlockStock(corder) {
		
		def corderInstance = corder
		
		log.debug "Stock Available so allocating it"
		// Allocating stock for Order
		corderInstance.corderMeshParts.each { orderMeshPart ->
			
			log.debug "orderMeshPart "+orderMeshPart
			BigDecimal noOfMeshParts = orderMeshPart.noOfMeshParts
			def noOfMeshParts_1=noOfMeshParts
			def stockList = Stock.findAllAvailabilityStatusBySheetSpecAndWireBrand(orderMeshPart.sheetSpecification, orderMeshPart.wireBrand)
			stockList.each { stock ->
				
				def stockInstance = Stock.get(stock.id)
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
						//flash.message = "There is some problem with updating stock when blocking stock for "+corderInstance.id
						//render(view: "show", model: [corderInstance: corderInstance])
						corderInstance.errors.reject("corderInstance","There is some problem with updating stock when blocking stock")
						return
					}
				}
				noOfMeshParts = noOfMeshParts - stockForOrder
				log.debug "after each iteration of stock orderMeshPart "+noOfMeshParts
			}
			
			if (noOfMeshParts > 0) {
				//flash.message = "There is no enough stock for "+orderMeshPart.sheetSpecification
				//render(view: "show", model: [corderInstance: corderInstance])
				corderInstance.errors.reject("corderInstance","There is no enough stock for ")
				return
			}
		}		
			
    }
	
}
