package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CageDesignServiceSpec extends Specification {

    CageDesignService cageDesignService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CageDesign(...).save(flush: true, failOnError: true)
        //new CageDesign(...).save(flush: true, failOnError: true)
        //CageDesign cageDesign = new CageDesign(...).save(flush: true, failOnError: true)
        //new CageDesign(...).save(flush: true, failOnError: true)
        //new CageDesign(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //cageDesign.id
    }

    void "test get"() {
        setupData()

        expect:
        cageDesignService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CageDesign> cageDesignList = cageDesignService.list(max: 2, offset: 2)

        then:
        cageDesignList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        cageDesignService.count() == 5
    }

    void "test delete"() {
        Long cageDesignId = setupData()

        expect:
        cageDesignService.count() == 5

        when:
        cageDesignService.delete(cageDesignId)
        sessionFactory.currentSession.flush()

        then:
        cageDesignService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CageDesign cageDesign = new CageDesign()
        cageDesignService.save(cageDesign)

        then:
        cageDesign.id != null
    }
}
