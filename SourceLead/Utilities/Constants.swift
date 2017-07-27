//
//  Constants.swift
//  SourceLead
//
//  Created by Bis on 21/06/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import Foundation

//============ CONSTANT DECLARATION
let BASE_URL = "http://qa2.sourcelead.net/sourcelead/rest/" //"http://qa2.sourcelead.net/sourcelead/"
let StorageData = UserDefaults.standard

struct AddExpenseRecord {
    var cateogyType     :   String?
    var date            :   String?
    var paymentMode     :   String?
    var amount          :   String?
    var currency        :   String?
    var receiptBy       :   String?
    var description     :   String?
    var attachments     :   [Data]?
    var filenames       :   [String]?
}
