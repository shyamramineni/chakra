package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SideMeshServiceSpec extends Specification {

    SideMeshService sideMeshService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new SideMesh(...).save(flush: true, failOnError: true)
        //new SideMesh(...).save(flush: true, failOnError: true)
        //SideMesh sideMesh = new SideMesh(...).save(flush: true, failOnError: true)
        //new SideMesh(...).save(flush: true, failOnError: true)
        //new SideMesh(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //sideMesh.id
    }

    void "test get"() {
        setupData()

        expect:
        sideMeshService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<SideMesh> sideMeshList = sideMeshService.list(max: 2, offset: 2)

        then:
        sideMeshList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        sideMeshService.count() == 5
    }

    void "test delete"() {
        Long sideMeshId = setupData()

        expect:
        sideMeshService.count() == 5

        when:
        sideMeshService.delete(sideMeshId)
        sessionFactory.currentSession.flush()

        then:
        sideMeshService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        SideMesh sideMesh = new SideMesh()
        sideMeshService.save(sideMesh)

        then:
        sideMesh.id != null
    }
}
