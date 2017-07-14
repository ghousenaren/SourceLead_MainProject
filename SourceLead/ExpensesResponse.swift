//
//  ExpensesResponse.swift
//  SourceLead
//
//  Created by BIS on 7/13/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import Gloss
struct ExpensesResponse : Decodable {
    let expenseId : String?
    let currencyCode : String?
    let projectMembersList : [projectMembersList]?
    let expenseCategoryList : [expenseCategoryList]?
    let paymentModes : [String?]
    let currencyCodeList : [String?]
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.expenseId              = "expenseId" <~~ json
        self.currencyCode           = "currencyCode" <~~ json
        self.projectMembersList     = "projectMembersList" <~~ json
        self.expenseCategoryList    = "expenseCategoryList" <~~ json
        self.paymentModes           = ("paymentModes" <~~ json)!
        self.currencyCodeList       = ("currencyCodeList" <~~ json)!
    }
}

struct projectMembersList : Decodable {
    let projectMembersListid : Int?
    let projectName : String?
    let projectStartDate : String?
    let projectEndDate : String?
    let clientName : String?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.projectMembersListid                   = "id" <~~ json
        self.projectName          = "projectName" <~~ json
        self.projectStartDate     = "projectStartDate" <~~ json
        self.projectEndDate       = "projectEndDate" <~~ json
        self.clientName           = "clientName" <~~ json
    }
}
struct expenseCategoryList : Decodable {
    let expenseCategoryListid : Int?
    let expensesName : String?
    let amountType   : String?
    let allowedAmount: Int?
    let description  : String?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.expenseCategoryListid                    = "id" <~~ json
        self.expensesName          = "expensesName" <~~ json
        self.amountType            = "amountType" <~~ json
        self.allowedAmount         = "allowedAmount" <~~ json
        self.description           = "description" <~~ json
    }
}
