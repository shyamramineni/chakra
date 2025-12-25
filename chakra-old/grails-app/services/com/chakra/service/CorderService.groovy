package com.chakra.service

import org.springframework.web.context.request.RequestContextHolder

import com.chakra.order.Corder

class CorderService {
	
	static transactional = true
	
	def meshPartBlockStockService
	def cagePartBlockStockService
	def chainLinkBlockStockService
	def weldSideBlockStockService
	
	//String errorMessage
	boolean isMeshAvailable
	boolean isCageAvailable
	boolean isChainLinkAvailable
	boolean isWeldSideMeshAvailable
	//def stockAvail = session["stockAvail"]
		
	def corderStockAvailable(corder,stockAvailableMsg){
		
		def session = RequestContextHolder.currentRequestAttributes().getSession()
		def corderInstance = Corder.get(corder.id)		
		
		if(corderInstance.isMeshOrder) {
			isMeshAvailable = meshPartBlockStockService.meshStockAvailable(corderInstance,stockAvailableMsg)
			println'ismeshAvailable '+isMeshAvailable
			//session.stockAvailableMsg += session.stockAvailableMsg 
			println'meshStockAvail'+stockAvailableMsg
			//println'session '+session
			
		} else {
			isMeshAvailable = true
		}
		
		if(corderInstance.isCageOrder) {
			isCageAvailable = cagePartBlockStockService.cageStockAvailable(corderInstance,stockAvailableMsg)
			println'isCageAvailable '+isCageAvailable
			println'cageStockAvail'+stockAvailableMsg
			//println'session '+session
		}
		else {
			isCageAvailable = true
		}
		
		if(corderInstance.isChainLinkOrder) {
			isChainLinkAvailable = chainLinkBlockStockService.chainLinkStockAvailable(corderInstance,stockAvailableMsg)
			println'isChainLinkAvailable '+isChainLinkAvailable
		}
		else {
			isChainLinkAvailable = true
		}
		
		if(corderInstance.isWeldSideMeshOrder) {
			isWeldSideMeshAvailable = weldSideBlockStockService.weldSideStockAvailable(corderInstance,stockAvailableMsg)
			println'isWeldSideMeshAvailable '+isWeldSideMeshAvailable
		}
		else {
			isWeldSideMeshAvailable = true
		}
		
		if(isMeshAvailable && isCageAvailable && isChainLinkAvailable && isWeldSideMeshAvailable) {
			return true
		} else {		
			return false
		}		
		
	}
	
	def corderBlockStock(corder) {
		
		// all four boolean then block each stock
		def corderInstance = Corder.get(corder.id)
		
		if(isMeshAvailable && isCageAvailable && isChainLinkAvailable && isWeldSideMeshAvailable) {
			
			if(corderInstance.isMeshOrder) {
				meshPartBlockStockService.meshBlockStock(corderInstance)
			}
			if(corderInstance.isCageOrder) {
				cagePartBlockStockService.cageBlockStock(corderInstance)
			}
			if(corderInstance.isChainLinkOrder) {
				chainLinkBlockStockService.chainLinkBlockStock(corderInstance)
			}
			if(corderInstance.isWeldSideMeshOrder) {
				weldSideBlockStockService.weldSideBlockStock(corderInstance)
			}			
			
		}
		
	}

    
}
