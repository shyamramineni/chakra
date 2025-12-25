package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CagePartServiceSpec extends Specification {

    CagePartService cagePartService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CagePart(...).save(flush: true, failOnError: true)
        //new CagePart(...).save(flush: true, failOnError: true)
        //CagePart cagePart = new CagePart(...).save(flush: true, failOnError: true)
        //new CagePart(...).save(flush: true, failOnError: true)
        //new CagePart(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //cagePart.id
    }

    void "test get"() {
        setupData()

        expect:
        cagePartService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CagePart> cagePartList = cagePartService.list(max: 2, offset: 2)

        then:
        cagePartList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        cagePartService.count() == 5
    }

    void "test delete"() {
        Long cagePartId = setupData()

        expect:
        cagePartService.count() == 5

        when:
        cagePartService.delete(cagePartId)
        sessionFactory.currentSession.flush()

        then:
        cagePartService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CagePart cagePart = new CagePart()
        cagePartService.save(cagePart)

        then:
        cagePart.id != null
    }
}
