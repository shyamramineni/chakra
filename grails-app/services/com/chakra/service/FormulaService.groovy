package com.chakra.service

class FormulaService {
			
	
	def evalFormula(inputMap,formula) {
		
		log.debug "FormulaService inputMap "+inputMap
		log.debug "FormulaService formula "+formula
		
		inputMap.each { entry ->
			
				def pattern = ~entry.key
				assert pattern instanceof java.util.regex.Pattern
				def matcher = (formula =~ /$pattern/)
				formula = matcher.replaceAll((inputMap.get(entry.key)).toString())
				assert matcher instanceof java.util.regex.Matcher
				
				}
			log.debug "FormulaService formula "+formula
			//log.debug Eval.me(formula)
			Eval.me(formula)
		
	}
	

}
