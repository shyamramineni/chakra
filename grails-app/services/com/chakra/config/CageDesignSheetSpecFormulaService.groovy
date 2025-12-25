package com.chakra.config

import grails.gorm.services.Service

@Service(CageDesignSheetSpecFormula)
interface CageDesignSheetSpecFormulaService {

    CageDesignSheetSpecFormula get(Serializable id)

    List<CageDesignSheetSpecFormula> list(Map args)

    Long count()

    void delete(Serializable id)

    CageDesignSheetSpecFormula save(CageDesignSheetSpecFormula cageDesignSheetSpecFormula)

}