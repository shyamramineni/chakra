package com.chakra.config

import grails.gorm.services.Service

@Service(QuotationFailedReason)
interface QuotationFailedReasonService {

    QuotationFailedReason get(Serializable id)

    List<QuotationFailedReason> list(Map args)

    Long count()

    void delete(Serializable id)

    QuotationFailedReason save(QuotationFailedReason quotationFailedReason)

}