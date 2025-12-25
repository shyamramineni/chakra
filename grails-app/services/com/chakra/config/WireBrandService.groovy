package com.chakra.config

import grails.gorm.services.Service

@Service(WireBrand)
interface WireBrandService {

    WireBrand get(Serializable id)

    List<WireBrand> list(Map args)

    Long count()

    void delete(Serializable id)

    WireBrand save(WireBrand wireBrand)

}