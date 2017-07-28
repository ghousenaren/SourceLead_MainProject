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

class AddExpenseRecord : NSObject, NSCoding {
    
    var cateogyType     :   String?
    var date            :   String?
    var paymentMode     :   String?
    var amount          :   String?
    var currency        :   String?
    var receiptBy       :   String?
    var descriptions     :   String?
    var attachments     :   [Data]?
    var filenames       :   [String]?
    
    init(cateogyType: String, date: String, paymentMode: String, amount: String, currency: String, receiptBy: String, description: String, attachments: [Data], filenames : [String]) {
       
        self.cateogyType    = cateogyType
        self.date           = date
        self.paymentMode    = paymentMode
        self.amount         = amount
        self.currency       = currency
        self.receiptBy      = receiptBy
        self.descriptions   = description
        self.attachments    = attachments
        self.filenames      = filenames
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        // super.init(coder:) is optional, see notes below
        self.cateogyType = aDecoder.decodeObject(forKey: "cateogyType") as? String
        self.date = aDecoder.decodeObject(forKey: "date") as? String
        self.paymentMode = aDecoder.decodeObject(forKey: "paymentMode") as? String
        self.amount = aDecoder.decodeObject(forKey: "amount") as? String
        self.currency = aDecoder.decodeObject(forKey:"currency") as? String
        self.receiptBy = aDecoder.decodeObject(forKey:"receiptBy") as? String
        self.descriptions = aDecoder.decodeObject(forKey:"descriptions") as? String
        self.attachments = aDecoder.decodeObject(forKey:"attachments") as? [Data]
        self.filenames = aDecoder.decodeObject(forKey:"filenames") as? [String]
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        // super.encodeWithCoder(aCoder) is optional, see notes below
        aCoder.encode(self.cateogyType, forKey: "cateogyType")
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.paymentMode, forKey: "paymentMode")
        aCoder.encode(self.amount, forKey: "amount")
        aCoder.encode(self.currency, forKey: "currency")
        aCoder.encode(self.receiptBy, forKey: "receiptBy")
        aCoder.encode(self.descriptions, forKey: "descriptions")
        aCoder.encode(self.attachments, forKey: "attachments")
        aCoder.encode(self.filenames, forKey: "filenames")
    }
}
