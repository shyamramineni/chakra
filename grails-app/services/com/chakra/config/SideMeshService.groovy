package com.chakra.config

import grails.gorm.services.Service

@Service(SideMesh)
interface SideMeshService {

    SideMesh get(Serializable id)

    List<SideMesh> list(Map args)

    Long count()

    void delete(Serializable id)

    SideMesh save(SideMesh sideMesh)

}