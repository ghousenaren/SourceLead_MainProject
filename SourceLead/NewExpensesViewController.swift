//
//  NewExpensesViewController.swift
//  SourceLead
//
//  Created by Bis on 10/07/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class NewExpensesViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var projectButton: UIButton!
    var expanseuserID      = Int()
    var exlocationCode     = String()

    var selectedDateButton = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = StorageData.object(forKey: "MAIN_RESPONSE") else {
            return
        }
        guard let result = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Dictionary<String , AnyObject> else {
            return
        }
        
        //let result = StorageData.value(forKey: "MAIN_RESPONSE") as? Dictionary<String , AnyObject>
        
        guard let mainResponseArc = MainResponse(json: result) else {
            print("--------------Error-------------")
            return
        }
        
        self.expanseuserID       = (mainResponseArc.userId)! as Int
        
       
        //for time being added
        
        for orgList in mainResponseArc.locationList! as [LocationList] {
            if orgList.isPrimaryOrg == "Y" {
             
                self.exlocationCode           = orgList.locationCode!
            }
        }
        
        
        //
        let tokenvalue = StorageData.object(forKey: "TOKEN")

       
        print("---------------------------",expanseuserID,exlocationCode,tokenvalue!)
      expenseApi() 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func calendarDateButtonAction(_ sender: UIButton) {
        let startDateFromJson = "01/03/2017"
        let endDateFromJson   = "01/08/2017"
        
        if sender.tag == 0 {
            let minDate = Global.dateFromString(dateString: startDateFromJson)
            let maxDate = Global.dateFromString(dateString: endDateFromJson)
                        
            selectedDateButton = "start"
            DatePickerPopover(title: "Select Start Date")
                .setDateMode(.date)
                .setSelectedDate(Date())
                .setMaximumDate(maxDate)
                .setMinimumDate(minDate)
                .setDoneButton(color: UIColor.white, action: { popover, selectedDate in print("selectedDate \(selectedDate)")
                    self.startButton.setTitle("\(Global.stringFromDate(dateValue: selectedDate))", for: .normal)})
                .setCancelButton(color: UIColor.white, action: { v in print("cancel")})
                .appear(originView: startButton, baseViewController: self)
            
        }else {
            selectedDateButton = "end"
            let minDate = Global.dateFromString(dateString: startDateFromJson)
            let maxDate = Global.dateFromString(dateString: endDateFromJson)
            
            DatePickerPopover(title: "Select End Date")
                .setDateMode(.date)
                .setSelectedDate(Date())
                .setMaximumDate(maxDate)
                .setMinimumDate(minDate)
                .setDoneButton(color: UIColor.white, action: { popover, selectedDate in print("selectedDate \(selectedDate)")
                self.endButton.setTitle("\(Global.stringFromDate(dateValue: selectedDate))", for: .normal)})
                .setCancelButton(color: UIColor.white, action: { v in print("cancel")
                })
                .appear(originView: endButton, baseViewController: self)
        }
    }

    @IBAction func projectPickerButtonAction(_ sender: UIButton) {
        StringPickerPopover(title: "Select Project", choices: ["Project 1","Project 2","Project 3"])
            .setSelectedRow(0)
            .setDoneButton(color: UIColor.white, action: { (popover, selectedRow, selectedString) in
                print("done row \(selectedRow) \(selectedString)")
                self.projectButton.setTitle(selectedString, for: .normal)
            })
            .setCancelButton(color: UIColor.white, action: { v in print("cancel")}
            )
            .appear(originView: projectButton, baseViewController: self)
    }
    func showAlertMessage(title : String, message : String) -> Void {
        DispatchQueue.main.async{ [weak self] in
            let alert = Global.showAlertWithTitle(title: title, okTitle: "Ok", cancelTitle: "", message: message, isCancel: false, okHandler: {action in
                
                return
            })
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewExpensesViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell : NewExpenseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "addExpensesCell", for: indexPath) as! NewExpenseTableViewCell
        //if indexPath.row == 1 {
            let cell: NewExpenseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "expensesCell", for: indexPath) as! NewExpenseTableViewCell
        //}
        
        return cell
    }
}
extension NewExpensesViewController {
    func expenseApi() {
        let tokenvalue = StorageData.object(forKey: "TOKEN")
       
        
        
    
         let parameter : [String : AnyObject] = [
         "userId" :expanseuserID as Int as AnyObject,
         "locationCode" :exlocationCode as AnyObject 
         
         ]
        //let url = BASE_URL +  "restAuthenticate"
        let url = "http://192.168.1.14:8080/sourcelead/rest/getExpenseEntryDetails"
        var data : Data
         do {
         data = try JSONSerialization.data(withJSONObject:parameter, options:[])
         
         }catch {
         print("JSON serialization failed:  \(error)")
         showAlertMessage(title: "Error", message: "Error in sending data")
         return
         }
        let headers : [String : AnyObject] = ["Content-Type" : "application/json" as AnyObject, "X-CustomToken" : tokenvalue as AnyObject]
        WebServices.sharedInstance.performApiCallWithURLString(urlString: url, methodName: "POST", headers: headers, parameters: nil, httpBody: data, withMessage: "Loading...", alertMessage: "Please check your device settings to ensure you have a working internet connection.", fromView: self.view, successHandler:  {[weak self] json, response in
            if let result = json as? Dictionary<String , AnyObject> {
                
                /*guard let mainResponseArc = MainResponse(json: result) else {
                 print("--------------Error-------------")
                 return
                 }*/
                print(result)
                
                
            }else {
                self?.showAlertMessage(title : "Problem" , message: "Issue in API Response.")
            }
            }, failureHandler: { response, error in
                //print("ERROR IS : \(error)")
        })
    }}

