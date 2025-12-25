package com.chakra.config

import grails.gorm.services.Service

@Service(CagePartSpecification)
interface CagePartSpecificationService {

    CagePartSpecification get(Serializable id)

    List<CagePartSpecification> list(Map args)

    Long count()

    void delete(Serializable id)

    CagePartSpecification save(CagePartSpecification cagePartSpecification)

}