package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CagePartSpecificationServiceSpec extends Specification {

    CagePartSpecificationService cagePartSpecificationService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CagePartSpecification(...).save(flush: true, failOnError: true)
        //new CagePartSpecification(...).save(flush: true, failOnError: true)
        //CagePartSpecification cagePartSpecification = new CagePartSpecification(...).save(flush: true, failOnError: true)
        //new CagePartSpecification(...).save(flush: true, failOnError: true)
        //new CagePartSpecification(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //cagePartSpecification.id
    }

    void "test get"() {
        setupData()

        expect:
        cagePartSpecificationService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CagePartSpecification> cagePartSpecificationList = cagePartSpecificationService.list(max: 2, offset: 2)

        then:
        cagePartSpecificationList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        cagePartSpecificationService.count() == 5
    }

    void "test delete"() {
        Long cagePartSpecificationId = setupData()

        expect:
        cagePartSpecificationService.count() == 5

        when:
        cagePartSpecificationService.delete(cagePartSpecificationId)
        sessionFactory.currentSession.flush()

        then:
        cagePartSpecificationService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CagePartSpecification cagePartSpecification = new CagePartSpecification()
        cagePartSpecificationService.save(cagePartSpecification)

        then:
        cagePartSpecification.id != null
    }
}
