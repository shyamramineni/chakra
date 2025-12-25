package com.chakra.config

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CageDesignSheetSpecFormulaServiceSpec extends Specification {

    CageDesignSheetSpecFormulaService cageDesignSheetSpecFormulaService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CageDesignSheetSpecFormula(...).save(flush: true, failOnError: true)
        //new CageDesignSheetSpecFormula(...).save(flush: true, failOnError: true)
        //CageDesignSheetSpecFormula cageDesignSheetSpecFormula = new CageDesignSheetSpecFormula(...).save(flush: true, failOnError: true)
        //new CageDesignSheetSpecFormula(...).save(flush: true, failOnError: true)
        //new CageDesignSheetSpecFormula(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //cageDesignSheetSpecFormula.id
    }

    void "test get"() {
        setupData()

        expect:
        cageDesignSheetSpecFormulaService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CageDesignSheetSpecFormula> cageDesignSheetSpecFormulaList = cageDesignSheetSpecFormulaService.list(max: 2, offset: 2)

        then:
        cageDesignSheetSpecFormulaList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        cageDesignSheetSpecFormulaService.count() == 5
    }

    void "test delete"() {
        Long cageDesignSheetSpecFormulaId = setupData()

        expect:
        cageDesignSheetSpecFormulaService.count() == 5

        when:
        cageDesignSheetSpecFormulaService.delete(cageDesignSheetSpecFormulaId)
        sessionFactory.currentSession.flush()

        then:
        cageDesignSheetSpecFormulaService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CageDesignSheetSpecFormula cageDesignSheetSpecFormula = new CageDesignSheetSpecFormula()
        cageDesignSheetSpecFormulaService.save(cageDesignSheetSpecFormula)

        then:
        cageDesignSheetSpecFormula.id != null
    }
}
