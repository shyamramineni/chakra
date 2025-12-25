package com.chakra.config

//import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.springframework.dao.DataIntegrityViolationException

import com.chakra.notifications.Notification
import com.chakra.security.User
import com.chakra.service.NotificationService

import grails.plugins.springsecurity.Secured

//@Secured(['ROLE_ADMIN','ROLE_SALES'])
class SheetSpecificationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService
	
	def exportService
	def grailsApplication
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [sheetSpecificationInstanceList: SheetSpecification.list(params), sheetSpecificationInstanceTotal: SheetSpecification.count()]
    }

    def create() {
        [sheetSpecificationInstance: new SheetSpecification(params)]
    }

    def save() {
		
        def sheetSpecificationInstance = new SheetSpecification(params)
		
		NotificationService notificationService = new NotificationService()
					
		BigDecimal noOfCrossWires = (sheetSpecificationInstance.length/sheetSpecificationInstance.pitch)+1
		BigDecimal crossWireLength = noOfCrossWires*(sheetSpecificationInstance.width+(2*sheetSpecificationInstance.projection))
		BigDecimal lineWireLength1 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires1
		BigDecimal lineWireLength2 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires2
				
		BigDecimal sheetWeight = ((crossWireLength/6588)*((sheetSpecificationInstance.crossWireDiameter)*(sheetSpecificationInstance.crossWireDiameter)))+((lineWireLength1/6588)*((sheetSpecificationInstance.lineWireDiameter1)*(sheetSpecificationInstance.lineWireDiameter1)))+((lineWireLength2/6588)*((sheetSpecificationInstance.lineWireDiameter2)*(sheetSpecificationInstance.lineWireDiameter2))) 
		
		log.debug noOfCrossWires
		log.debug sheetWeight
		
		sheetSpecificationInstance.noOfCrossWires = noOfCrossWires
		sheetSpecificationInstance.sheetWeight = sheetWeight
		
        if (!sheetSpecificationInstance.save(flush: true)) {
            render(view: "create", model: [sheetSpecificationInstance: sheetSpecificationInstance])
            return
        }
		
		notificationService.addNotification(springSecurityService.currentUser.toString(), Notification.NOTIFMSG_NEW_SHEETSPECIFICATION, true, ""+g.link(action:"list", controller:"sheetSpecification", id: sheetSpecificationInstance.id) { sheetSpecificationInstance.sheetName }, Notification.NOTIFTYPE_APP)

		flash.message = message(code: 'default.created.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), sheetSpecificationInstance.id])
        redirect(action: "show", id: sheetSpecificationInstance.id)
    }

    def show() {
        def sheetSpecificationInstance = SheetSpecification.get(params.id)
        if (!sheetSpecificationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), params.id])
            redirect(action: "list")
            return
        }
		
        [sheetSpecificationInstance: sheetSpecificationInstance]
    }

    def edit() {
        def sheetSpecificationInstance = SheetSpecification.get(params.id)
        if (!sheetSpecificationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), params.id])
            redirect(action: "list")
            return
        }

        [sheetSpecificationInstance: sheetSpecificationInstance]
    }

    def update() {
        def sheetSpecificationInstance = SheetSpecification.get(params.id)
        if (!sheetSpecificationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (sheetSpecificationInstance.version > version) {
                sheetSpecificationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'sheetSpecification.label', default: 'SheetSpecification')] as Object[],
                          "Another user has updated this SheetSpecification while you were editing")
                render(view: "edit", model: [sheetSpecificationInstance: sheetSpecificationInstance])
                return
            }
        }

        sheetSpecificationInstance.properties = params
		
		BigDecimal noOfCrossWires = (sheetSpecificationInstance.length/sheetSpecificationInstance.pitch)+1
		BigDecimal crossWireLength = noOfCrossWires*(sheetSpecificationInstance.width+(2*sheetSpecificationInstance.projection))
		BigDecimal lineWireLength1 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires1
		BigDecimal lineWireLength2 = (sheetSpecificationInstance.length+sheetSpecificationInstance.pitch)*sheetSpecificationInstance.noOfLineWires2
		
		BigDecimal sheetWeight = ((crossWireLength/6588)*((sheetSpecificationInstance.crossWireDiameter)*(sheetSpecificationInstance.crossWireDiameter)))+((lineWireLength1/6588)*((sheetSpecificationInstance.lineWireDiameter1)*(sheetSpecificationInstance.lineWireDiameter1)))+((lineWireLength2/6588)*((sheetSpecificationInstance.lineWireDiameter2)*(sheetSpecificationInstance.lineWireDiameter2)))
		
		sheetSpecificationInstance.noOfCrossWires = noOfCrossWires
		sheetSpecificationInstance.sheetWeight = sheetWeight
		
        if (!sheetSpecificationInstance.save(flush: true)) {
            render(view: "edit", model: [sheetSpecificationInstance: sheetSpecificationInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), sheetSpecificationInstance.id])
        redirect(action: "show", id: sheetSpecificationInstance.id)
    }

    def delete() {
        def sheetSpecificationInstance = SheetSpecification.get(params.id)
        if (!sheetSpecificationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), params.id])
            redirect(action: "list")
            return
        }

        try {
            sheetSpecificationInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sheetSpecification.label', default: 'SheetSpecification'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def sheetPriceReport() {
				
	}
	
	/*def meshPartsPdf() {
		
		def sheetSpecificationInstance = SheetSpecification.get(params.id)
						
		def image = new File(ApplicationHolder.application.parentContext.servletContext.getRealPath("/images/grails_logo.jpg"))
		
		renderPdf(template: "meshParts", model: [sheetSpecificationInstance: sheetSpecificationInstance, imageBytes: image.bytes], filename: "MeshParts.pdf")
	}*/
	
	def exportSheetPrice() {
		
		params.max = Math.min(params.max ? params.int('max') : 50, 100)
		
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=SheetPrice.${params.extension}")
			
			List fields = ["sheetSpecId", "sheetName", "sheetWeight","wireBrandInstance"]
			Map labels = ["sheetSpecId": "SheetSpec Id", "sheetName": "Sheet Name", "sheetWeight": "Sheet Weight", "wireBrandInstance":"Wire Brand" ]
			
			exportService.export(params.format, response.outputStream,SheetSpecification.list(params),fields, labels, [:], [:])
		}
		
		[sheetSpecificationInstanceList: SheetSpecification.list(params), sheetSpecificationInstanceTotal: SheetSpecification.count()]
	}
	
	/*def exportSheetPrice() {
		
		params.max = Math.min(params.max ? params.int('max') : 50, 100)
		def exportSheet = [:]
		def strArray
		if(params?.format && params.format != "html"){
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=SheetPrice.${params.extension}")
			
			def sheetSpecificationList = SheetSpecification.findAll()
			def wireBrandList = WireBrand.findAll()
			BigDecimal sheetWeightCost = 0
			sheetSpecificationList.each { sheetSpecification ->
				
				BigDecimal noOfCrossWires = (sheetSpecification.length/sheetSpecification.pitch)+1
				BigDecimal crossWireLength = noOfCrossWires*(sheetSpecification.width+(2*sheetSpecification.projection))
				BigDecimal lineWireLength1 = (sheetSpecification.length+sheetSpecification.pitch)*sheetSpecification.noOfLineWires1
				BigDecimal lineWireLength2 = (sheetSpecification.length+sheetSpecification.pitch)*sheetSpecification.noOfLineWires2
				
				BigDecimal crossWireWeight = ((crossWireLength/6588)*(sheetSpecification.crossWireDiameter*sheetSpecification.crossWireDiameter))
				BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(sheetSpecification.lineWireDiameter1*sheetSpecification.lineWireDiameter1))
				BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(sheetSpecification.lineWireDiameter2*sheetSpecification.lineWireDiameter2))
				strArray = new ArrayList()
				wireBrandList.each { wireBrand ->
					
					def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrand, sheetSpecification.crossWireDiameter)
					def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrand, sheetSpecification.lineWireDiameter1)
					def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrand, sheetSpecification.lineWireDiameter2)
					
					if((sheetSpecification?.crossWireDiameter == sheetSpecification?.lineWireDiameter1) && (sheetSpecification?.lineWireDiameter2 > 0)) {
						sheetWeightCost = (crossWireWeight*crossWirePrice?.price) + (lineWireWeight1*lineWirePrice1?.price) + (lineWireWeight2*lineWirePrice2?.price)
					} else if((sheetSpecification?.crossWireDiameter == sheetSpecification?.lineWireDiameter1) && (sheetSpecification?.lineWireDiameter2 == 0)) {
						sheetWeightCost = (crossWireWeight*crossWirePrice?.price) + (lineWireWeight1*lineWirePrice1?.price)
					} else(sheetSpecification?.crossWireDiameter == sheetSpecification?.lineWireDiameter2) {
						sheetWeightCost = (crossWireWeight*crossWirePrice?.price) + (lineWireWeight2*lineWirePrice2?.price)
					}					
				}
				
				strArray[0] = sheetSpecification.sheetSpecId
				strArray[1] = sheetSpecification.sheetName
				strArray[2] = sheetSpecification.sheetWeight
				strArray[3] = sheetWeightCost
				//strArray[4] = sheetSpecification
				//strArray[5] = sheetSpecification
				def key = sheetSpecification
				exportSheet.put(key, strArray)
				println'ex'+exportSheet.values()
				
				
			}			
			
			List fields = ["sheetSpecId", "sheetName", "sheetWeight","sheetWeightCost"]
			Map labels = ["sheetSpecId": "SheetSpec Id", "sheetName": "Sheet Name", "sheetWeight": "Sheet Weight", "sheetWeightCost":"SheetWeight Cost" ]

			exportService.export(params.format, response.outputStream,exportSheet.values(),fields, labels, [:], [:])
		}
		
		[sheetSpecificationInstanceList: exportSheet.values(), sheetSpecificationInstanceTotal: exportSheet.count()]
	}*/
	
	def sheetSpecPrice() {
		println'getSheetPrice'
		println'params '+params
		def wireBrandInstance = WireBrand.get(params.wirebrand)
		println'wireBrandInstance '+wireBrandInstance
		def sheetSpecInstance = SheetSpecification.get(params.itemid)
		println'sheetSpecInstance '+sheetSpecInstance	
		
		BigDecimal noOfCrossWires = (sheetSpecInstance.length/sheetSpecInstance.pitch)+1
		BigDecimal crossWireLength = noOfCrossWires*(sheetSpecInstance.width+(2*sheetSpecInstance.projection))
		BigDecimal lineWireLength1 = (sheetSpecInstance.length+sheetSpecInstance.pitch)*sheetSpecInstance.noOfLineWires1
		BigDecimal lineWireLength2 = (sheetSpecInstance.length+sheetSpecInstance.pitch)*sheetSpecInstance.noOfLineWires2
		
		BigDecimal crossWireWeight = ((crossWireLength/6588)*(sheetSpecInstance.crossWireDiameter*sheetSpecInstance.crossWireDiameter))
		BigDecimal lineWireWeight1 = ((lineWireLength1/6588)*(sheetSpecInstance.lineWireDiameter1*sheetSpecInstance.lineWireDiameter1))
		BigDecimal lineWireWeight2 = ((lineWireLength2/6588)*(sheetSpecInstance.lineWireDiameter2*sheetSpecInstance.lineWireDiameter2))
		
		log.debug'crossWireDiameter '+sheetSpecInstance.crossWireDiameter
		log.debug'lineWireDiameter1 '+sheetSpecInstance.lineWireDiameter1
		log.debug'lineWireDiameter2 '+sheetSpecInstance.lineWireDiameter2
		
		log.debug'crossWireWeight'+crossWireWeight
		log.debug'lineWireWeight1'+lineWireWeight1
		log.debug'lineWireWeight2'+lineWireWeight2
		
		def crossWirePrice = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecInstance.crossWireDiameter)
		def lineWirePrice1 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecInstance.lineWireDiameter1)
		def lineWirePrice2 = WirePrice.findByWireBrandAndWireDiameter(wireBrandInstance, sheetSpecInstance.lineWireDiameter2)
		def price = 0.0
		if(sheetSpecInstance.lineWireDiameter1 > 0 && sheetSpecInstance.lineWireDiameter2 > 0) {
			price = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price) + (lineWireWeight2*lineWirePrice2.price)))
			
		} else if(sheetSpecInstance.lineWireDiameter1 > 0) {
			price = (((crossWireWeight*crossWirePrice.price) + (lineWireWeight1*lineWirePrice1.price)))
			
		}
		println'price '+price
		
		def responseData = [price: price]
		
		render(contentType: 'text/json') {[
			'responseData': responseData,'responseCode': price ? "OK" : "NODATA"
	
		]}		
		return		
	}
}
