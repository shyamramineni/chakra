package com.chakra.config

import grails.gorm.services.Service

@Service(CagePartPrice)
interface CagePartPriceService {

    CagePartPrice get(Serializable id)

    List<CagePartPrice> list(Map args)

    Long count()

    void delete(Serializable id)

    CagePartPrice save(CagePartPrice cagePartPrice)

}