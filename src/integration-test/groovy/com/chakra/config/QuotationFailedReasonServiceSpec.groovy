package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class QuotationFailedReasonServiceSpec extends Specification {

    QuotationFailedReasonService quotationFailedReasonService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new QuotationFailedReason(...).save(flush: true, failOnError: true)
        //new QuotationFailedReason(...).save(flush: true, failOnError: true)
        //QuotationFailedReason quotationFailedReason = new QuotationFailedReason(...).save(flush: true, failOnError: true)
        //new QuotationFailedReason(...).save(flush: true, failOnError: true)
        //new QuotationFailedReason(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //quotationFailedReason.id
    }

    void "test get"() {
        setupData()

        expect:
        quotationFailedReasonService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<QuotationFailedReason> quotationFailedReasonList = quotationFailedReasonService.list(max: 2, offset: 2)

        then:
        quotationFailedReasonList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        quotationFailedReasonService.count() == 5
    }

    void "test delete"() {
        Long quotationFailedReasonId = setupData()

        expect:
        quotationFailedReasonService.count() == 5

        when:
        quotationFailedReasonService.delete(quotationFailedReasonId)
        sessionFactory.currentSession.flush()

        then:
        quotationFailedReasonService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        QuotationFailedReason quotationFailedReason = new QuotationFailedReason()
        quotationFailedReasonService.save(quotationFailedReason)

        then:
        quotationFailedReason.id != null
    }
}
