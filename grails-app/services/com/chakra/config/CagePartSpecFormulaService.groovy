package com.chakra.config

import grails.gorm.services.Service

@Service(CagePartSpecFormula)
interface CagePartSpecFormulaService {

    CagePartSpecFormula get(Serializable id)

    List<CagePartSpecFormula> list(Map args)

    Long count()

    void delete(Serializable id)

    CagePartSpecFormula save(CagePartSpecFormula cagePartSpecFormula)

}