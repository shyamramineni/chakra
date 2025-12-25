package com.chakra.config

import grails.gorm.services.Service

@Service(CageDesign)
interface CageDesignService {

    CageDesign get(Serializable id)

    List<CageDesign> list(Map args)

    Long count()

    void delete(Serializable id)

    CageDesign save(CageDesign cageDesign)

}