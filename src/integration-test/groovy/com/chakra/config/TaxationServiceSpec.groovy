package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class TaxationServiceSpec extends Specification {

    TaxationService taxationService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Taxation(...).save(flush: true, failOnError: true)
        //new Taxation(...).save(flush: true, failOnError: true)
        //Taxation taxation = new Taxation(...).save(flush: true, failOnError: true)
        //new Taxation(...).save(flush: true, failOnError: true)
        //new Taxation(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //taxation.id
    }

    void "test get"() {
        setupData()

        expect:
        taxationService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Taxation> taxationList = taxationService.list(max: 2, offset: 2)

        then:
        taxationList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        taxationService.count() == 5
    }

    void "test delete"() {
        Long taxationId = setupData()

        expect:
        taxationService.count() == 5

        when:
        taxationService.delete(taxationId)
        sessionFactory.currentSession.flush()

        then:
        taxationService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Taxation taxation = new Taxation()
        taxationService.save(taxation)

        then:
        taxation.id != null
    }
}
