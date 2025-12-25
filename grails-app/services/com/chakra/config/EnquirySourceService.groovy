package com.chakra.config

import grails.gorm.services.Service

@Service(EnquirySource)
interface EnquirySourceService {

    EnquirySource get(Serializable id)

    List<EnquirySource> list(Map args)

    Long count()

    void delete(Serializable id)

    EnquirySource save(EnquirySource enquirySource)

}