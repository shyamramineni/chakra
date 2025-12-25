package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SheetSpecificationServiceSpec extends Specification {

    SheetSpecificationService sheetSpecificationService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new SheetSpecification(...).save(flush: true, failOnError: true)
        //new SheetSpecification(...).save(flush: true, failOnError: true)
        //SheetSpecification sheetSpecification = new SheetSpecification(...).save(flush: true, failOnError: true)
        //new SheetSpecification(...).save(flush: true, failOnError: true)
        //new SheetSpecification(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //sheetSpecification.id
    }

    void "test get"() {
        setupData()

        expect:
        sheetSpecificationService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<SheetSpecification> sheetSpecificationList = sheetSpecificationService.list(max: 2, offset: 2)

        then:
        sheetSpecificationList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        sheetSpecificationService.count() == 5
    }

    void "test delete"() {
        Long sheetSpecificationId = setupData()

        expect:
        sheetSpecificationService.count() == 5

        when:
        sheetSpecificationService.delete(sheetSpecificationId)
        sessionFactory.currentSession.flush()

        then:
        sheetSpecificationService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        SheetSpecification sheetSpecification = new SheetSpecification()
        sheetSpecificationService.save(sheetSpecification)

        then:
        sheetSpecification.id != null
    }
}
