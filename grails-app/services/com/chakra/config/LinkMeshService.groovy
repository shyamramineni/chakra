package com.chakra.config

import grails.gorm.services.Service

@Service(LinkMesh)
interface LinkMeshService {

    LinkMesh get(Serializable id)

    List<LinkMesh> list(Map args)

    Long count()

    void delete(Serializable id)

    LinkMesh save(LinkMesh linkMesh)

}