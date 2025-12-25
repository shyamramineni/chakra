package com.chakra.config

import grails.gorm.services.Service

@Service(CagePart)
interface CagePartService {

    CagePart get(Serializable id)

    List<CagePart> list(Map args)

    Long count()

    void delete(Serializable id)

    CagePart save(CagePart cagePart)

}