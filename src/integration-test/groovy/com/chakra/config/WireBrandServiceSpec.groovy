package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class WireBrandServiceSpec extends Specification {

    WireBrandService wireBrandService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new WireBrand(...).save(flush: true, failOnError: true)
        //new WireBrand(...).save(flush: true, failOnError: true)
        //WireBrand wireBrand = new WireBrand(...).save(flush: true, failOnError: true)
        //new WireBrand(...).save(flush: true, failOnError: true)
        //new WireBrand(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //wireBrand.id
    }

    void "test get"() {
        setupData()

        expect:
        wireBrandService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<WireBrand> wireBrandList = wireBrandService.list(max: 2, offset: 2)

        then:
        wireBrandList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        wireBrandService.count() == 5
    }

    void "test delete"() {
        Long wireBrandId = setupData()

        expect:
        wireBrandService.count() == 5

        when:
        wireBrandService.delete(wireBrandId)
        sessionFactory.currentSession.flush()

        then:
        wireBrandService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        WireBrand wireBrand = new WireBrand()
        wireBrandService.save(wireBrand)

        then:
        wireBrand.id != null
    }
}
