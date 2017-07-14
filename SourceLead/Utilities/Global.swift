////
////  UIViewController+Extension.swift
////  Expense Tracker
////
////
////
//
import Foundation
import UIKit

class Global: NSObject {
    class  func showAlertWithTitle(title: String?,okTitle: String?, cancelTitle: String?, message: String,isCancel:Bool, okHandler:((UIAlertAction) -> Void)?)  -> UIAlertController  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: okTitle, style: .default) { (action) in
            okHandler!(action)
        }
        if isCancel {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
                return
            }
            alertController.addAction(cancelAction)
        }
        alertController.addAction(OKAction)
        return alertController
    }
    
    class func dateFromString(dateString : String) -> Date {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        var   separater = ""
        if dateString.contains("/") {
            separater = "/"
        }else {
            separater = "-"
        }
        let DateArray = dateString.components(separatedBy: separater)
        let components = NSDateComponents()
        components.year = Int(DateArray[2])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[0])! + 1
        let date = calendar?.date(from: components as DateComponents)
        
        return date!
    }
    
    class func stringFromDate(dateValue : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: dateValue as Date)
        let yourDate: Date? = formatter.date(from: myString)
        //formatter.dateFormat = "dd MMM, yyyy"
        formatter.dateFormat = "dd-mm-yyyy"
        //print(yourDate!)
        return  formatter.string(from: yourDate!)
    }
}

