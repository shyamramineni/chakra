package com.chakra.config

import grails.gorm.services.Service

@Service(WirePrice)
interface WirePriceService {

    WirePrice get(Serializable id)

    List<WirePrice> list(Map args)

    Long count()

    void delete(Serializable id)

    WirePrice save(WirePrice wirePrice)

}