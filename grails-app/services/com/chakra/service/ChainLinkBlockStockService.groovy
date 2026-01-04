package com.chakra.service

import org.springframework.web.context.request.RequestContextHolder

import com.chakra.order.Corder
import com.chakra.stock.ChainLinkStock
import com.chakra.stock.ChainLinkStockOrder

class ChainLinkBlockStockService {
	
	static transactional = true

	def chainLinkStockAvailable(corder,stockAvailableMsg) {
		
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		def corderInstance = Corder.get(corder.id)
		println'corderInstance '+corderInstance
		
		println "blockStock Action"
		println "checkingStock Availability"
		
		boolean chainLinkStockAvailable = true
			
		String availabilityChainLink
		
		corderInstance.corderChainLinkItems.each { orderChainLink ->
			
			println "orderChainLink "+orderChainLink
			BigDecimal chainLinkSqfts = orderChainLink.squareFeets
			def stockForOrder = 0
			def chainLinkSqfts_1=chainLinkSqfts
			def chainLinkStockList = ChainLinkStock.findAllAvailabilityStatusByWireBrandAndLinkMesh(orderChainLink.wireBrand, orderChainLink.linkMesh)
			
			chainLinkStockList.each { chainLinkStock ->
				
				def chainLinkStockInstance = ChainLinkStock.get(chainLinkStock.id)
				println "chainLinkStock "+chainLinkStockInstance
				println "chainLinkSqfts "+chainLinkSqfts
				if (chainLinkSqfts == 0) {
					println "stock already Identified so returning"
					return
				}
				
				if (chainLinkStockInstance.noOfInStock > 0) {
								
					if (chainLinkStockInstance.noOfInStock  >= chainLinkSqfts_1) {
						
						stockForOrder += chainLinkSqfts_1
						chainLinkSqfts_1=0
					}  else if (chainLinkStockInstance.noOfInStock > 0) {
						chainLinkSqfts_1 = chainLinkSqfts_1 - chainLinkStockInstance.noOfInStock
						stockForOrder+=chainLinkStockInstance.noOfInStock
					}
					println "stockForOrder "+stockForOrder
				}
				println "after each iteration of stock orderChainLink "+chainLinkSqfts
			}
			chainLinkSqfts = chainLinkSqfts - stockForOrder
			
			if (chainLinkSqfts > 0) {
				if(availabilityChainLink) {
					availabilityChainLink += "There is no enough chainLink stock for "+orderChainLink.linkMesh +"</br>"
				} else {
					availabilityChainLink = "There is no enough chainLink stock for "+orderChainLink.linkMesh +"</br>"
				}
				
				return chainLinkStockAvailable = false						
			}
			
			 //return chainLinkStockAvailable = true 
		}
		
		if(!chainLinkStockAvailable) {
			println "Stock Not available so returning"
			println availabilityChainLink
			//session.setAttribute("stockAvailableMsg", session.stockAvailableMsg += availabilityChainLink)
			//corderInstance.errors.reject("corderInstance",availabilityChainLink)
			println'session.stockAvailableMsg'+session.stockAvailableMsg
			if(session.stockAvailableMsg != null){
				println'in if condition'
				session.setAttribute("stockAvailableMsg", session.stockAvailableMsg += availabilityChainLink)
			} else {
				session.setAttribute("stockAvailableMsg", availabilityChainLink)
			}
			return
		}
		return chainLinkStockAvailable
	}
	
	def chainLinkBlockStock(corder) {
		
		def corderInstance = corder
		log.debug "Stock Available so allocating it"
		// Allocating stock for Order
		corderInstance.corderChainLinkItems.each { orderChainLink ->
			
			log.debug "orderChainLink "+orderChainLink
			BigDecimal squareFeets = orderChainLink.squareFeets
			def squareFeets_1=squareFeets
			def chainLinkStockList = ChainLinkStock.findAllAvailabilityStatusByLinkMeshAndWireBrand(orderChainLink.linkMesh, orderChainLink.wireBrand)
			chainLinkStockList.each { chainLinkStock ->
				
				def chainLinkStockInstance = ChainLinkStock.get(chainLinkStock.id)
				log.debug "chainLinkStock "+chainLinkStockInstance
				log.debug "squareFeets "+squareFeets
				if (squareFeets == 0) {
					log.debug "stock already allocated so returning"
					return
				}
				
				def stockForOrder = 0
				if (chainLinkStockInstance.noOfInStock > 0) {
								
					if (chainLinkStockInstance.noOfInStock  >= squareFeets_1) {
						//stockForOrder = noOfMeshParts - stockInstance.noOfInStock
						stockForOrder += squareFeets_1
						squareFeets_1=0
					}  else if (chainLinkStockInstance.noOfInStock > 0) {
						squareFeets_1 = squareFeets_1 - chainLinkStockInstance.noOfInStock
						stockForOrder+=chainLinkStockInstance.noOfInStock
					}
					
					log.debug "stockForOrder "+stockForOrder
					
					chainLinkStockInstance.addToChainLinkStockOrderItems(new ChainLinkStockOrder(corder: corderInstance, chainLinkStock: chainLinkStockInstance, chainLinkStockForOrder: stockForOrder, chainLinkStockOrderBlockTime: new Date()))
					chainLinkStockInstance.noOfInStock =  chainLinkStockInstance.noOfInStock - stockForOrder
					if (chainLinkStockInstance.noOfInStock == 0) {
						chainLinkStockInstance.availabilityStatus = false
					}
					
					log.debug "Adding StockOrder and updating stock"
					
					if (!chainLinkStockInstance.save(flush: true)) {
						log.debug "There is some problem with updating stock when blocking stock for "+corderInstance.id
						chainLinkStockInstance.errors.each {
							log.error it
						}
						//flash.message = "There is some problem with updating stock when blocking stock for "+corderInstance.id
						//render(view: "show", model: [corderInstance: corderInstance])
						corderInstance.errors.reject("corderInstance","There is some problem with updating stock when blocking stock")
						return
					}
				}
				squareFeets = squareFeets - stockForOrder
				log.debug "after each iteration of stock orderChainLink "+squareFeets
			}
			
			if (squareFeets > 0) {
				corderInstance.errors.reject("corderInstance","There is no enough stock for ")
				return
			}
		}
		
	}
}
