package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CagePartTypeServiceSpec extends Specification {

    CagePartTypeService cagePartTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CagePartType(...).save(flush: true, failOnError: true)
        //new CagePartType(...).save(flush: true, failOnError: true)
        //CagePartType cagePartType = new CagePartType(...).save(flush: true, failOnError: true)
        //new CagePartType(...).save(flush: true, failOnError: true)
        //new CagePartType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //cagePartType.id
    }

    void "test get"() {
        setupData()

        expect:
        cagePartTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CagePartType> cagePartTypeList = cagePartTypeService.list(max: 2, offset: 2)

        then:
        cagePartTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        cagePartTypeService.count() == 5
    }

    void "test delete"() {
        Long cagePartTypeId = setupData()

        expect:
        cagePartTypeService.count() == 5

        when:
        cagePartTypeService.delete(cagePartTypeId)
        sessionFactory.currentSession.flush()

        then:
        cagePartTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CagePartType cagePartType = new CagePartType()
        cagePartTypeService.save(cagePartType)

        then:
        cagePartType.id != null
    }
}
