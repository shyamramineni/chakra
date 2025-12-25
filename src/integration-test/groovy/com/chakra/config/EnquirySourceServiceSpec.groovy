package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class EnquirySourceServiceSpec extends Specification {

    EnquirySourceService enquirySourceService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new EnquirySource(...).save(flush: true, failOnError: true)
        //new EnquirySource(...).save(flush: true, failOnError: true)
        //EnquirySource enquirySource = new EnquirySource(...).save(flush: true, failOnError: true)
        //new EnquirySource(...).save(flush: true, failOnError: true)
        //new EnquirySource(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //enquirySource.id
    }

    void "test get"() {
        setupData()

        expect:
        enquirySourceService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<EnquirySource> enquirySourceList = enquirySourceService.list(max: 2, offset: 2)

        then:
        enquirySourceList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        enquirySourceService.count() == 5
    }

    void "test delete"() {
        Long enquirySourceId = setupData()

        expect:
        enquirySourceService.count() == 5

        when:
        enquirySourceService.delete(enquirySourceId)
        sessionFactory.currentSession.flush()

        then:
        enquirySourceService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        EnquirySource enquirySource = new EnquirySource()
        enquirySourceService.save(enquirySource)

        then:
        enquirySource.id != null
    }
}
