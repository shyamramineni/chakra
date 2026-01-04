package com.chakra.production

import org.springframework.dao.DataIntegrityViolationException

import com.chakra.config.SheetSpecification
import com.chakra.config.WireBrand
import com.chakra.notifications.Notification
import com.chakra.rawmaterial.WireReceiptReporting
import com.chakra.security.DummyUser
import com.chakra.service.NotificationService
import com.chakra.stock.Stock

class ProductionReportingController {
	
	def productionService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index() {
        redirect(action: "list", params: params)
    }

	def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [productionReportingInstanceList: ProductionReporting.list(params), productionReportingInstanceTotal: ProductionReporting.count()]
    }

	def create() {
			
        [productionReportingInstance: new ProductionReporting(params)]
    }
	
	def save() {
		
		def wireBrand = WireBrand.get(params.wireBrand.id)
		log.debug'wireBrand '+wireBrand
		def sheetSpecification = SheetSpecification.get(params.sheetSpecifcation.id)
		log.debug'sheetSpecification '+sheetSpecification
				
		def productionReportingInstance = productionService.productionSave(params, wireBrand, sheetSpecification)
		log.debug'productionReportingInstance'+productionReportingInstance
		
		if(!productionReportingInstance) {
			flash.message = message(code: 'wire.not.found.message')
			render(view: "create", model: [productionReportingInstance: productionReportingInstance])
			return						
		}
		flash.message = message(code: 'default.created.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), productionReportingInstance.id])
		redirect(action: "show", id: productionReportingInstance.id)		
			
    }		
	
	def show() {
        def productionReportingInstance = ProductionReporting.get(params.id)
        if (!productionReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), params.id])
            redirect(action: "list")
            return
        }

        [productionReportingInstance: productionReportingInstance]
    }

	def cancel() {
		
		// Revert code start
		def productionReportingInstance = ProductionReporting.get(params.id)
		NotificationService notificationService = new NotificationService()
		def users = new DummyUser(username: 'admin')
		log.debug'user '+ users.username
		
		log.debug'productionReportingInstance '+productionReportingInstance
		def prodReportWireWeightList = []
		prodReportWireWeightList += productionReportingInstance.productionReportingWireWeightList
		log.debug"prodReportWireWeightList "+prodReportWireWeightList
		
		prodReportWireWeightList.each { productionReportingWireWeightInstance ->
			
			log.debug'prodReportingWireWeightInstance '+productionReportingWireWeightInstance
			
			def wireReceiptReportingInstance = WireReceiptReporting.find(productionReportingWireWeightInstance.wireReceiptReporting)
			wireReceiptReportingInstance.weightInStock += productionReportingWireWeightInstance.weight
			if(wireReceiptReportingInstance.availabilityStatus == false) {
				wireReceiptReportingInstance.availabilityStatus = true
			}
			if (!wireReceiptReportingInstance.save(flush: true)) {
				wireReceiptReportingInstance.errors.each {
					log.error it
				}
			}
						
			if (!productionReportingWireWeightInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
				redirect(action: "list")
				return
			}
	
			try {
				productionReportingInstance.removeFromProductionReportingWireWeightList(productionReportingWireWeightInstance)
				productionReportingWireWeightInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
				
				//redirect(controller:"productionReporting", action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
				redirect(action: "show", id: params.id)
			}
										
		}
		
		//Reverted all child table os deleteing ProductionReporting
		// todo delete ProductionReporting
		// Revert logic done
		//def productionReportingInstance = ProductionReporting.get(params.id)
		
				
		if (!productionReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), params.id])
			redirect(action: "list")
			return
		}

		try {
			
			productionReportingInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), params.id])
			//redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), params.id])
			redirect(action: "show", id: params.id)
		}
		
		def stockInstance = productionReportingInstance.stock
		log.debug'stockInstance '+stockInstance
		log.debug productionReportingInstance.stock.stockOrderItems
		
		def stockOrderList = stockInstance.stockOrderItems
		if(stockOrderList.size() > 0) {
		//	notificationService.addNotification(users.username, Notification.NOTIFMSG_PROD_WORNG_REPORT, true, Notification.NOTIFTYPE_APP)
		
			flash.message = "Order blocked"
		}
		
		if (!stockInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])
			redirect(action: "list")
			return
		}
		try {
			
			if(!productionReportingInstance.stock.stockOrderItems) {
				stockInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])
				redirect(action: "list")
				
			} else {
				log.debug"Stock cannot delete"
				redirect(action: "list")
			}
								
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'stock.label', default: 'Stock'), params.id])				redirect(action: "show", id: params.id)
			redirect(action: "show", id: params.id)
		}
		
				
		
	}
	
	def edit() {
        def productionReportingInstance = ProductionReporting.get(params.id)
		log.debug'productionReportingInstance '+productionReportingInstance
		def prodReportWireWeightList = []
		prodReportWireWeightList += productionReportingInstance.productionReportingWireWeightList
		log.debug"prodReportWireWeightList "+prodReportWireWeightList
		
		prodReportWireWeightList.each { productionReportingWireWeightInstance ->
			
			log.debug'prodReportingWireWeightInstance '+productionReportingWireWeightInstance
			//def productionReportingWireWeightInstance = ProductionReportingWireWeight.get(prodReportingWireWeightInstance.id)
			
			def wireReceiptReportingInstance = WireReceiptReporting.find(productionReportingWireWeightInstance.wireReceiptReporting)
			wireReceiptReportingInstance.weightInStock += productionReportingWireWeightInstance.weight
			if(wireReceiptReportingInstance.availabilityStatus == false) {
				wireReceiptReportingInstance.availabilityStatus = true
			}
			if (!wireReceiptReportingInstance.save(flush: true)) {
				wireReceiptReportingInstance.errors.each {
					log.error it
				}
			}
						
			if (!productionReportingWireWeightInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
				redirect(action: "list")
				return
			}
	
			try {
				productionReportingInstance.removeFromProductionReportingWireWeightList(productionReportingWireWeightInstance)
				productionReportingWireWeightInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
				
				//redirect(controller:"productionReporting", action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productionReportingWireWeight.label', default: 'ProductionReportingWireWeight'), params.id])
				redirect(action: "show", id: params.id)
			}
			
						
		}		
		
		log.debug'productionReportingInstance'+productionReportingInstance
		
		[productionReportingInstance: productionReportingInstance]
		
    }
	
	def update() {
        def productionReportingInstance = ProductionReporting.get(params.id)
        if (!productionReportingInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (productionReportingInstance.version > version) {
                productionReportingInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'productionReporting.label', default: 'ProductionReporting')] as Object[],
                          "Another user has updated this ProductionReporting while you were editing")
                render(view: "edit", model: [productionReportingInstance: productionReportingInstance])
                return
            }
        }

        productionReportingInstance.properties = params
		
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
					flash.message = "Raw Material Inventory not available";
					render(view: "create", model: [productionReportingInstance: productionReportingInstance])
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
					flash.message = "Raw Material Inventory not available";
					render(view: "create", model: [productionReportingInstance: productionReportingInstance])
					return
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
					flash.message = "Raw Material Inventory not available";
					render(view: "create", model: [productionReportingInstance: productionReportingInstance])
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
						flash.message = "Error saving RawMaterial";
						render(view: "create", model: [productionReportingInstance: productionReportingInstance])
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
						flash.message = "Error saving RawMaterial";
						render(view: "create", model: [productionReportingInstance: productionReportingInstance])
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
						flash.message = "Error saving RawMaterial";
						render(view: "create", model: [productionReportingInstance: productionReportingInstance])
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
			flash.message = "Error saving ProductionReporting"
			render(view: "create", model: [productionReportingInstance: productionReportingInstance])
			return
		}
		log.debug "Saved productionReportingInstance"
		log.debug "Saving stock"
		
		def stockInstance = productionReportingInstance.stock
		
		stockInstance.machine = productionReportingInstance.machine
		stockInstance.sheetSpec = productionReportingInstance.sheetSpecifcation
		stockInstance.wireBrand = productionReportingInstance.wireBrand
		stockInstance.noOfManufactured = productionReportingInstance.totalQuantity
		
		stockInstance.noOfInStock = (productionReportingInstance.totalQuantity-productionReportingInstance.mending)
		stockInstance.availabilityStatus = true
		stockInstance.stockId = 'ST'+productionReportingInstance.stockManufacturedTime.format("ddMMyyhhmmss")
		
		stockInstance.stockManufacturedTime = productionReportingInstance.stockManufacturedTime
		
		if (!stockInstance.save(flush: true)) {
			stockInstance.errors.each {
				log.error it
			}
			render(view: "create", model: [productionReportingInstance: productionReportingInstance])
			return
		}
		
		log.debug "Saved New stock"
		
		productionReportingInstance.comments = params.comments+" "+"Edited By "+ "dummy" +new Date().format("dd/MM/yy-hh:mm")+"<br>"

        if (!productionReportingInstance.save(flush: true)) {
            render(view: "edit", model: [productionReportingInstance: productionReportingInstance])
            return
        }
		productionReportingInstance.stock = stockInstance
		flash.message = message(code: 'default.updated.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), productionReportingInstance.id])
        redirect(action: "show", id: productionReportingInstance.id)
    }

	def delete() {
        def productionReportingInstance = ProductionReporting.get(params.id)
        if (!productionReportingInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), params.id])
            redirect(action: "list")
            return
        }

        try {
            productionReportingInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def search() {

	}
	
	def searchResults() {

		def p = ProductionReporting.createCriteria()
		def productionReportingInstanceList = p {

			//if(params.sheetSpecifcation)
			//idEq(params.sheetSpecifcation)
			//idEq(sheetSpecifcation,java.lang.Long.parseLong(params.sheetSpecifcation))
			le("createdDate",params.createdDate)
			ge("editedDate",params.editedDate)

			//order("startDate", "desc")
		}

		log.debug "Final productionReportingInstanceList.size() "+productionReportingInstanceList.size()

		[productionReportingInstanceList: productionReportingInstanceList, productionReportingInstanceTotal: productionReportingInstanceList.size()]

	}
	
	def repair() {
		
		def productionReportingInstance = ProductionReporting.get(params.productionReporting)
				
		[productionReportingInstance: productionReportingInstance]		
	}
	
	def sheetRepair() {
		log.debug'params'+params
		def productionReportingInstance = ProductionReporting.get(params.productionReporting.id)
		log.debug'productionReportingInstance '+productionReportingInstance
		def noOfSheets = params.noOfSheets
		def stockInstance = productionReportingInstance.stock
				
		if(noOfSheets.toBigDecimal() <= productionReportingInstance.mending) {
		log.debug'in if'
			stockInstance.noOfInStock += noOfSheets.toBigDecimal()
			stockInstance.availabilityStatus = true
			if (!stockInstance.save(flush: true)) {
				stockInstance.errors.each {
					log.error it
				}
				
			}
			
			productionReportingInstance.mending -= noOfSheets.toBigDecimal()
			
			if (!productionReportingInstance.save(flush: true)) {
				productionReportingInstance.errors.each {
					log.error it
				}
				
			}
			flash.message = message(code: 'default.created.message', args: [message(code: 'productionReporting.label', default: 'ProductionReporting'), productionReportingInstance.id])
			redirect(action: "show", id: productionReportingInstance.id)
			
		} else {
		
		flash.message ="Number of sheets must be less than or equal to mending"
		render(view: "repair", model: [productionReportingInstance: productionReportingInstance])
		
		}
	}
	
}
