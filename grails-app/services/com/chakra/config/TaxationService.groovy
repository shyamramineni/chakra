package com.chakra.config

import grails.gorm.services.Service

@Service(Taxation)
interface TaxationService {

    Taxation get(Serializable id)

    List<Taxation> list(Map args)

    Long count()

    void delete(Serializable id)

    Taxation save(Taxation taxation)

}