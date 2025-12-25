package com.chakra.config

import grails.gorm.services.Service

@Service(Machine)
interface MachineService {

    Machine get(Serializable id)

    List<Machine> list(Map args)

    Long count()

    void delete(Serializable id)

    Machine save(Machine machine)

}