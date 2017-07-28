//
//  DatabaseManager.swift
//  SourceLead
//
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit
import FMDB
let sharedInstance = DatabaseManager()
class DatabaseManager: NSObject {
    
    var database: FMDatabase? = nil
    var dbPath:String? = nil
    class func getInstance() -> DatabaseManager
    {
        if(sharedInstance.database == nil)
        {
            let documentsPath1 = NSURL(fileURLWithPath:    NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
            let logsPath = documentsPath1.appendingPathComponent("datadb")
            
            let dbpath = logsPath?.appendingPathComponent("sourcehead.db")
            sharedInstance.database = FMDatabase(path:dbpath?.path)
        }
        return sharedInstance
    }
    
    /*func getUserProfile() -> Dictionary<String, String> {
        
        sharedInstance.database!.open()
        let strQuery = "select * from tbl_UserProfile  limit 1"
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(strQuery, withArgumentsIn: nil)
        var dict:Dictionary<String, String> = [:]
        if (resultSet != nil) {
            while resultSet.next() {
                dict = resultSet.resultDictionary as! [String : String]
            }
        }
        return dict as Dictionary<String, String>
    }*/
}
