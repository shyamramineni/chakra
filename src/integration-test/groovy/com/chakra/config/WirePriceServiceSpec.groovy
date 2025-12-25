package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class WirePriceServiceSpec extends Specification {

    WirePriceService wirePriceService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new WirePrice(...).save(flush: true, failOnError: true)
        //new WirePrice(...).save(flush: true, failOnError: true)
        //WirePrice wirePrice = new WirePrice(...).save(flush: true, failOnError: true)
        //new WirePrice(...).save(flush: true, failOnError: true)
        //new WirePrice(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //wirePrice.id
    }

    void "test get"() {
        setupData()

        expect:
        wirePriceService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<WirePrice> wirePriceList = wirePriceService.list(max: 2, offset: 2)

        then:
        wirePriceList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        wirePriceService.count() == 5
    }

    void "test delete"() {
        Long wirePriceId = setupData()

        expect:
        wirePriceService.count() == 5

        when:
        wirePriceService.delete(wirePriceId)
        sessionFactory.currentSession.flush()

        then:
        wirePriceService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        WirePrice wirePrice = new WirePrice()
        wirePriceService.save(wirePrice)

        then:
        wirePrice.id != null
    }
}
