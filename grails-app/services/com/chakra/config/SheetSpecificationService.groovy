package com.chakra.config

import grails.gorm.services.Service

@Service(SheetSpecification)
interface SheetSpecificationService {

    SheetSpecification get(Serializable id)

    List<SheetSpecification> list(Map args)

    Long count()

    void delete(Serializable id)

    SheetSpecification save(SheetSpecification sheetSpecification)

}