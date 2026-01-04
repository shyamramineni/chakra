package com.chakra.service

import org.springframework.web.context.request.RequestContextHolder

import com.chakra.order.Corder
import com.chakra.stock.WeldSideMeshStock
import com.chakra.stock.WeldSideMeshStockOrder

class WeldSideBlockStockService {
	
	static transactional = true
	
	def weldSideStockAvailable(corder,stockAvailableMsg) {
		
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		def corderInstance = Corder.get(corder.id)
		println'corderInstance '+corderInstance
		
		println "blockStock Action"
		println "checkingStock Availability"
		
		boolean weldSideStockAvailable = true
			
		String availabilityWeldSide
		
		corderInstance.corderWeldSideItems.each { orderWeldSide ->
			
			println "orderWeldSide "+orderWeldSide
			BigDecimal weldSideSqfts = orderWeldSide.squareFeets
			def stockForOrder = 0
			def weldSideSqfts_1=weldSideSqfts
			def weldSideStockList = WeldSideMeshStock.findAllAvailabilityStatusByWireBrandAndSideMesh(orderWeldSide.wireBrand, orderWeldSide.sideMesh)
			
			weldSideStockList.each { weldSideStock ->
				
				def weldSideStockInstance = WeldSideMeshStock.get(weldSideStock.id)
				println "weldSideStock "+weldSideStockInstance
				println "weldSideSqfts "+weldSideSqfts
				if (weldSideSqfts == 0) {
					println "stock already Identified so returning"
					return
				}
				
				if (weldSideStockInstance.noOfInStock > 0) {
								
					if (weldSideStockInstance.noOfInStock  >= weldSideSqfts_1) {
						
						stockForOrder += weldSideSqfts_1
						weldSideSqfts_1=0
					}  else if (weldSideStockInstance.noOfInStock > 0) {
						weldSideSqfts_1 = weldSideSqfts_1 - weldSideStockInstance.noOfInStock
						stockForOrder+=weldSideStockInstance.noOfInStock
					}
					println "stockForOrder "+stockForOrder
				}
				println "after each iteration of stock orderWeldSide "+weldSideSqfts
			}
			weldSideSqfts = weldSideSqfts - stockForOrder
			
			if (weldSideSqfts > 0) {
				if(availabilityWeldSide) {
					availabilityWeldSide += "There is no enough weldSide stock for "+orderWeldSide.sideMesh +"</br>"
				} else {
					availabilityWeldSide = "There is no enough weldSide stock for "+orderWeldSide.sideMesh +"</br>"
				}
				weldSideStockAvailable = false
		
			}
		}
		
		if(!weldSideStockAvailable) {
			println "Stock Not available so returning"
			println availabilityWeldSide
			//session.setAttribute("stockAvailableMsg", session.stockAvailableMsg += availabilityWeldSide)
			//corderInstance.errors.reject("corderInstance",availabilityWeldSide)
			println'session.stockAvailableMsg'+session.stockAvailableMsg
			if(session.stockAvailableMsg != null){
				println'in if condition'
				session.setAttribute("stockAvailableMsg", session.stockAvailableMsg += availabilityWeldSide)
			} else {
				session.setAttribute("stockAvailableMsg", availabilityWeldSide)
			}
			return
		}
		return weldSideStockAvailable
		
	}
	
	def weldSideBlockStock(corder) {
		
		def corderInstance = corder
		log.debug "Stock Available so allocating it"
		// Allocating stock for Order
		corderInstance.corderWeldSideItems.each { orderWeldSide ->
			
			log.debug "orderWeldSide "+orderWeldSide
			BigDecimal squareFeets = orderWeldSide.squareFeets
			def squareFeets_1=squareFeets
			def weldSideStockList = WeldSideMeshStock.findAllAvailabilityStatusBySideMeshAndWireBrand(orderWeldSide.linkMesh, orderWeldSide.wireBrand)
			weldSideStockList.each { weldSideStock ->
				
				def weldSideStockInstance = WeldSideMeshStock.get(weldSideStock.id)
				log.debug "weldSideStock "+weldSideStockInstance
				log.debug "squareFeets "+squareFeets
				if (squareFeets == 0) {
					log.debug "stock already allocated so returning"
					return
				}
				
				def stockForOrder = 0
				if (weldSideStockInstance.noOfInStock > 0) {
								
					if (weldSideStockInstance.noOfInStock  >= squareFeets_1) {
						stockForOrder += squareFeets_1
						squareFeets_1=0
					}  else if (weldSideStockInstance.noOfInStock > 0) {
						squareFeets_1 = squareFeets_1 - weldSideStockInstance.noOfInStock
						stockForOrder+=weldSideStockInstance.noOfInStock
					}
					
					log.debug "stockForOrder "+stockForOrder
					
					weldSideStockInstance.addToWeldSideMeshStockOrderItems(new WeldSideMeshStockOrder(corder: corderInstance, weldSideMeshStock: weldSideStockInstance, weldSideMeshStockForOrder: stockForOrder, weldSideMeshStockOrderBlockTime: new Date()))
					weldSideStockInstance.noOfInStock =  weldSideStockInstance.noOfInStock - stockForOrder
					if (weldSideStockInstance.noOfInStock == 0) {
						weldSideStockInstance.availabilityStatus = false
					}
					
					log.debug "Adding StockOrder and updating stock"
					
					if (!weldSideStockInstance.save(flush: true)) {
						log.debug "There is some problem with updating stock when blocking stock for "+corderInstance.id
						weldSideStockInstance.errors.each {
							log.error it
						}
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
