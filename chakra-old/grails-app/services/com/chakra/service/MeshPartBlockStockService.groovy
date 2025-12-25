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
		
								
			
			/*if(stockAvailable && cageStockAvailable && chainLinkStockAvailable && weldSideStockAvailable) {
				
			}*/
		
		
		//}
		
		/*corderInstance.shippingStatus = Corder.STATUS_ALLOCATED
		if (!corderInstance.save()) {
			
			throw new RuntimeException("Error saving Corder")
			return
		}
		return corderInstance*/
	
			
		/*log.debug "blockStock Action"
		log.debug "checkingStock Availability"
		//def corderInstance = Corder.get(params.id)
		// Checking availability of stock
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
		//render(view: "show", model: [corderInstance: corderInstance])
				//return
			}
		}
		
		if(!stockAvailable) {
			log.debug "Stock Not available so returning"
			log.debug availabilityMesh
			//flash.message = availabilityMesh;
			//render(view: "show", model: [corderInstance: corderInstance])
			corderInstance.errors.reject("corderInstance",availabilityMesh)
			return
		}
		// End of checking availability of stock logic
		
		
		log.debug "blockCageStock Action"
		log.debug "checkingStock Availability"
		//def corderInstance = Corder.get(params.id)
		// Checking availability of stock
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
			log.debug "Stock Not available so returning"
			log.debug availabilityCage
			//flash.message = availabilityCage;
			//render(view: "show", model: [corderInstance: corderInstance])
			return
		}
		// End of checking availability of stock logic
		
		if(corderInstance.corderMeshParts.size() > 0 && corderInstance.corderCageParts.size() == 0){
			if(stockAvailable) {
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
		
		if(corderInstance.corderCageParts.size() > 0 && corderInstance.corderMeshParts.size() == 0) {
			if(cageStockAvailable) {
				
				log.debug "CageStock Available so allocating it"
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
								flash.message = "There is some problem with updating stock when blocking stock for "+corderInstance.id
								render(view: "show", model: [corderInstance: corderInstance])
								return
							}
						}
						noOfMeshParts = noOfMeshParts - stockForOrder
						log.debug "after each iteration of stock orderMeshPart "+noOfMeshParts
					}
					
					if (noOfMeshParts > 0) {
						flash.message = "There is no enough stock for "+orderMeshPart.sheetSpecification
						render(view: "show", model: [corderInstance: corderInstance])
						return
					}
				}
				// Allocating stock for Order
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
								render(view: "show", model: [corderInstance: corderInstance])
								return
							}
						}
						noOfCageParts = noOfCageParts - cageStockForOrder
						log.debug "after each iteration of stock orderCagePart "+noOfCageParts
					}
					
					if (noOfCageParts > 0) {
						flash.message = "There is no enough stock for "+orderCagePart.cagePartSpecFormula
						render(view: "show", model: [corderInstance: corderInstance])
						return
					}
				}
				
			}
		}
		
		if(corderInstance.corderMeshParts.size() > 0 && corderInstance.corderCageParts.size() > 0) {
			if(stockAvailable && cageStockAvailable) {
				
			
				log.debug "CageStock Available so allocating it"
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
								flash.message = "There is some problem with updating stock when blocking stock for "+corderInstance.id
								render(view: "show", model: [corderInstance: corderInstance])
								return
							}
						}
						noOfMeshParts = noOfMeshParts - stockForOrder
						log.debug "after each iteration of stock orderMeshPart "+noOfMeshParts
					}
					
					if (noOfMeshParts > 0) {
						flash.message = "There is no enough stock for "+orderMeshPart.sheetSpecification
						render(view: "show", model: [corderInstance: corderInstance])
						return
					}
				}
				// Allocating stock for Order
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
								render(view: "show", model: [corderInstance: corderInstance])
								return
							}
						}
						noOfCageParts = noOfCageParts - cageStockForOrder
						log.debug "after each iteration of stock orderCagePart "+noOfCageParts
					}
					
					if (noOfCageParts > 0) {
						flash.message = "There is no enough stock for "+orderCagePart.cagePartSpecFormula
						render(view: "show", model: [corderInstance: corderInstance])
						return
					}
				}
	
			}
		}
		
		*/
		
		

