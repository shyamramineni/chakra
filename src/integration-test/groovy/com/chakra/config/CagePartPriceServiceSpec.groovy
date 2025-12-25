package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CagePartPriceServiceSpec extends Specification {

    CagePartPriceService cagePartPriceService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CagePartPrice(...).save(flush: true, failOnError: true)
        //new CagePartPrice(...).save(flush: true, failOnError: true)
        //CagePartPrice cagePartPrice = new CagePartPrice(...).save(flush: true, failOnError: true)
        //new CagePartPrice(...).save(flush: true, failOnError: true)
        //new CagePartPrice(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //cagePartPrice.id
    }

    void "test get"() {
        setupData()

        expect:
        cagePartPriceService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CagePartPrice> cagePartPriceList = cagePartPriceService.list(max: 2, offset: 2)

        then:
        cagePartPriceList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        cagePartPriceService.count() == 5
    }

    void "test delete"() {
        Long cagePartPriceId = setupData()

        expect:
        cagePartPriceService.count() == 5

        when:
        cagePartPriceService.delete(cagePartPriceId)
        sessionFactory.currentSession.flush()

        then:
        cagePartPriceService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CagePartPrice cagePartPrice = new CagePartPrice()
        cagePartPriceService.save(cagePartPrice)

        then:
        cagePartPrice.id != null
    }
}
