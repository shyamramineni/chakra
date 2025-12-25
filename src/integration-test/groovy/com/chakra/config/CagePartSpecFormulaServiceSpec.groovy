package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CagePartSpecFormulaServiceSpec extends Specification {

    CagePartSpecFormulaService cagePartSpecFormulaService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CagePartSpecFormula(...).save(flush: true, failOnError: true)
        //new CagePartSpecFormula(...).save(flush: true, failOnError: true)
        //CagePartSpecFormula cagePartSpecFormula = new CagePartSpecFormula(...).save(flush: true, failOnError: true)
        //new CagePartSpecFormula(...).save(flush: true, failOnError: true)
        //new CagePartSpecFormula(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //cagePartSpecFormula.id
    }

    void "test get"() {
        setupData()

        expect:
        cagePartSpecFormulaService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CagePartSpecFormula> cagePartSpecFormulaList = cagePartSpecFormulaService.list(max: 2, offset: 2)

        then:
        cagePartSpecFormulaList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        cagePartSpecFormulaService.count() == 5
    }

    void "test delete"() {
        Long cagePartSpecFormulaId = setupData()

        expect:
        cagePartSpecFormulaService.count() == 5

        when:
        cagePartSpecFormulaService.delete(cagePartSpecFormulaId)
        sessionFactory.currentSession.flush()

        then:
        cagePartSpecFormulaService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CagePartSpecFormula cagePartSpecFormula = new CagePartSpecFormula()
        cagePartSpecFormulaService.save(cagePartSpecFormula)

        then:
        cagePartSpecFormula.id != null
    }
}
