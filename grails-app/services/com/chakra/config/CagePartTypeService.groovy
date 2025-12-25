package com.chakra.config

import grails.gorm.services.Service

@Service(CagePartType)
interface CagePartTypeService {

    CagePartType get(Serializable id)

    List<CagePartType> list(Map args)

    Long count()

    void delete(Serializable id)

    CagePartType save(CagePartType cagePartType)

}