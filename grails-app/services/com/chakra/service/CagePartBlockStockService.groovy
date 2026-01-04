package com.chakra.service

import org.springframework.web.context.request.RequestContextHolder

import com.chakra.order.Corder
import com.chakra.stock.CageStock
import com.chakra.stock.CageStockOrder

class CagePartBlockStockService {
	
	static transactional = true
	
	def cageStockAvailable(corder, stockAvailableMsg) {
		
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		def corderInstance = Corder.get(corder.id)
		println'corderInstance '+corderInstance
		
		println "blockStock Action"
		println "checkingStock Availability"
		
		boolean cageStockAvailable = true
			
		String availabilityCage
		
		corderInstance.corderCageParts.each { orderCagePart ->
			
			log.debug "orderCagePart "+orderCagePart
			BigDecimal noOfCageParts = orderCagePart.noOfCageParts
			def stockForOrder = 0
			def noOfCageParts_1=noOfCageParts
			def cageStockList = CageStock.findAllAvailabilityStatusByCagePartSpecFormula(orderCagePart.cagePartSpecFormula)
			
			cageStockList.each { cageStock ->
				
				def cageStockInstance = CageStock.get(cageStock.id)
				log.debug "stock "+cageStockInstance
				log.debug "noOfCageParts "+noOfCageParts
				if (noOfCageParts == 0) {
					log.debug "stock already Identified so returning"
					return
				}
				
				if (cageStockInstance.noOfInStock > 0) {
								
					if (cageStockInstance.noOfInStock  >= noOfCageParts_1) {
						
						stockForOrder += noOfCageParts_1
						noOfCageParts_1=0
					}  else if (cageStockInstance.noOfInStock > 0) {
						noOfCageParts_1 = noOfCageParts_1 - cageStockInstance.noOfInStock
						stockForOrder+=cageStockInstance.noOfInStock
					}
					log.debug "stockForOrder "+stockForOrder
				}
				log.debug "after each iteration of stock orderCagePart "+noOfCageParts
			}
			noOfCageParts = noOfCageParts - stockForOrder
			
			if (noOfCageParts > 0) {
				if(availabilityCage) {
					availabilityCage += "There is no enough cage stock for "+orderCagePart.cagePartSpecFormula +"</br>"
				} else {
					availabilityCage = "There is no enough cage stock for "+orderCagePart.cagePartSpecFormula +"</br>"
				}
				cageStockAvailable = false
		
			}
		}
		
		
		
		if(!cageStockAvailable) {
			println "Stock Not available so returning"
			println availabilityCage
			println'session.stockAvailableMsg'+session.stockAvailableMsg
			if(session.stockAvailableMsg != null){
				println'in if condition'
				session.setAttribute("stockAvailableMsg", session.stockAvailableMsg += availabilityCage)
			} else {
				session.setAttribute("stockAvailableMsg", availabilityCage)
			}
			//corderInstance.errors.reject("corderInstance",availabilityCage)
			return
		}
		return cageStockAvailable
	
	}
	
	def cageBlockStock(corder) {
		
		def corderInstance = corder
		
		corderInstance.corderCageParts.each { orderCagePart ->
			
			log.debug "orderCagePart "+orderCagePart
			BigDecimal noOfCageParts = orderCagePart.noOfCageParts
			def noOfCageParts_1=noOfCageParts
			def cageStockList = CageStock.findAllAvailabilityStatusByCagePartSpecFormula(orderCagePart.cagePartSpecFormula)
			cageStockList.each { cageStock ->
				
				def cageStockInstance = CageStock.get(cageStock.id)
				log.debug "stock "+cageStockInstance
				log.debug "noOfCageParts "+noOfCageParts
				if (noOfCageParts == 0) {
					log.debug "stock already allocated so returning"
					return
				}
				
				def cageStockForOrder = 0
				if (cageStockInstance.noOfInStock > 0) {
								
					if (cageStockInstance.noOfInStock  >= noOfCageParts_1) {
						
						cageStockForOrder += noOfCageParts_1
						noOfCageParts_1=0
					}  else if (cageStockInstance.noOfInStock > 0) {
						noOfCageParts_1 = noOfCageParts_1 - cageStockInstance.noOfInStock
						cageStockForOrder+=cageStockInstance.noOfInStock
					}
					
					log.debug "cageStockForOrder "+cageStockForOrder
					
					//def stockOrder = new StockOrder(corder: corderInstance, stock: stockInstance, stockForOrder: stockForOrder)
					cageStockInstance.addToCageStockOrderItems(new CageStockOrder(corder: corderInstance, cageStock: cageStockInstance, cageStockForOrder: cageStockForOrder, cageStockOrderBlockTime: new Date()))
					cageStockInstance.noOfInStock =  cageStockInstance.noOfInStock - cageStockForOrder
					if (cageStockInstance.noOfInStock == 0) {
						cageStockInstance.availabilityStatus = false
					}
					
					log.debug "Adding StockOrder and updating stock"
					
					if (!cageStockInstance.save(flush: true)) {
						log.debug "There is some problem with updating stock when blocking stock for "+corderInstance.id
						cageStockInstance.errors.each {
							log.error it
						}
						flash.message = "There is some problem with updating stock when blocking stock for "+corderInstance.id
						//render(view: "show", model: [corderInstance: corderInstance])
						return
					}
				}
				noOfCageParts = noOfCageParts - cageStockForOrder
				log.debug "after each iteration of stock orderCagePart "+noOfCageParts
			}
			
			if (noOfCageParts > 0) {
				flash.message = "There is no enough stock for "+orderCagePart.cagePartSpecFormula
				//render(view: "show", model: [corderInstance: corderInstance])
				return
			}
			
		}
		
	}
    
}
