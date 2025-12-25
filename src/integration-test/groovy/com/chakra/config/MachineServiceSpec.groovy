package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class MachineServiceSpec extends Specification {

    MachineService machineService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Machine(...).save(flush: true, failOnError: true)
        //new Machine(...).save(flush: true, failOnError: true)
        //Machine machine = new Machine(...).save(flush: true, failOnError: true)
        //new Machine(...).save(flush: true, failOnError: true)
        //new Machine(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //machine.id
    }

    void "test get"() {
        setupData()

        expect:
        machineService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Machine> machineList = machineService.list(max: 2, offset: 2)

        then:
        machineList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        machineService.count() == 5
    }

    void "test delete"() {
        Long machineId = setupData()

        expect:
        machineService.count() == 5

        when:
        machineService.delete(machineId)
        sessionFactory.currentSession.flush()

        then:
        machineService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Machine machine = new Machine()
        machineService.save(machine)

        then:
        machine.id != null
    }
}
