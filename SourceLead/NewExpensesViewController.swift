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

    @IBOutlet weak var expenseidTxt: UITextField!
    @IBOutlet weak var purpuseTxt: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var projectButton: UIButton!
    
    @IBOutlet weak var clientNameDropMenu: DropMenuButton!
    @IBOutlet weak var datePickerHolderStackView: UIStackView!
    
    @IBOutlet weak var categoryTableView: UITableView!
    var categoryTableArray = [[:]]
    var mainExpensesResponse: ExpensesResponse!
    var expanseuserID      = Int()
    var exlocationCode     = String()
    var projectNameArray       = [String]()
    var clientNameArray     =   [String]()
    var expenseCategoryArray    = [expenseCategoryList]()
    
    
    var selectedDateButton = ""
    //Display in expenses
    var expendeID = String()
   var ProjectID =  Int()
   var projectNames       = [String]()
    var startdate   =  String()
    var enddate      =  String()
   var clintnames    = [String]()
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let categoryArray  = StorageData.value(forKey: "EXPENSES_JSON")  else {
            return
        }
        categoryTableArray = categoryArray as! [Dictionary<AnyHashable, Any>]
         DispatchQueue.main.async{ [weak self] in
                self?.categoryTableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    @IBAction func unwindToNewExpensesController(segue: UIStoryboardSegue) {
        print("Unwind to New Expenses VC")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromnewtoadd" {
           var addCategoryVC = segue.destination as! AddCategoryViewController
            addCategoryVC.mainExpensesResponse = self.mainExpensesResponse
        }
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        let saveExpensesJSON = ["categoryDTOList"   :  self.categoryTableArray,
                               "clientName"         :  self.clientNameDropMenu.title,
                               "id"                 :  self.expenseidTxt.text ,
                               "projectEndDate"     :  self.endButton.title ,
                               "projectName"        :  self.projectButton.title,
                               "projectStartDate"   :  self.startButton.title,
                               "purpose" :  self.purpuseTxt.text ?? ""
                               
            ] as? [String:AnyObject]
        
        print(saveExpensesJSON)
    }
    @IBAction func SubmitButtonAction(_ sender: UIButton) {
        
    }
    
    
    @IBAction func calendarDateButtonAction(_ sender: UIButton) {
        let startDateFromJson = self.startdate
        var endDateFromJson   = self.enddate
        if endDateFromJson.characters.count < 2 {
            endDateFromJson  = "12-12-2020" //setting max date bcoz picker has to given max date
        }
        
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
                .appear(originView: startButton, baseViewWhenOriginViewHasNoSuperview: datePickerHolderStackView, baseViewController: self)
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
                .appear(originView: endButton, baseViewWhenOriginViewHasNoSuperview: datePickerHolderStackView, baseViewController: self)
        }
    }

    @IBAction func projectPickerButtonAction(_ sender: UIButton) {
        StringPickerPopover(title: "Select Project", choices:projectNameArray)
            .setSelectedRow(0)
            .setDoneButton(color: UIColor.white, action: { (popover, selectedRow, selectedString) in
                print("done row \(selectedRow) \(selectedString)")
                self.projectButton.setTitle(selectedString, for: .normal)
                self.clientNameDropMenu.setTitle(self.clientNameArray[selectedRow], for: .normal)
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
    //Add functions
   }

extension NewExpensesViewController {
    
    func expenseApi() {
        let tokenvalue = StorageData.object(forKey: "TOKEN")
       
        
        
    
         let parameter : [String : AnyObject] = [
         "userId" :expanseuserID as Int as AnyObject,
         "locationCode" :exlocationCode as AnyObject 
         
         ]
        let url = BASE_URL +  "getExpenseEntryDetails"
        //let url = "http://192.168.1.12:8080/sourcelead/rest/getExpenseEntryDetails"
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
                guard let expenseObject = ExpensesResponse(json: result) else {
                    print("--------------Error-------------")
                    return
                }
                
                self?.mainExpensesResponse = expenseObject
                self?.expenseidTxt.text = expenseObject.expenseId!
                self?.expenseCategoryArray = expenseObject.expenseCategoryList!
                for orgList in expenseObject.projectMembersList! as [projectMembersList] {
                    self?.ProjectID =  orgList.projectMembersListid!
                    self?.projectNameArray.append(orgList.projectName!)    //   = [orgList.projectName!]
                    self?.startdate   =  orgList.projectStartDate!
                    self?.enddate      =  ""
                    if let endDate = orgList.projectEndDate {
                        self?.enddate = endDate
                    }
                    if let clientName = orgList.clientName {
                        self?.clientNameArray.append(clientName)
                    }else {
                        self?.clientNameArray.append("")
                    }
                    /*if let clientName = orgList.clientName {
                        self?.clintnames  = clientName
                    }*/
                    
                    //self?.clintnames  = ["orgList.clientName!"]

//                    StorageData.set(exlocationCode, forKey: "LOCATIONCODE")
                }
                
                
                
            }else {
                self?.showAlertMessage(title : "Problem" , message: "Issue in API Response.")
            }
            }, failureHandler: { response, error in
                //print("ERROR IS : \(error)")
        })
    }
}

extension NewExpensesViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}

extension NewExpensesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categoryTableArray.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            categoryTableArray.remove(at: indexPath.row)
            categoryTableView.beginUpdates()
            categoryTableView.deleteRows(at: [indexPath], with: .automatic)
            categoryTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryCell = categoryTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        
        let categoryDict = categoryTableArray[indexPath.row]
        categoryCell.titleBarLabel.text = categoryDict["categoryType"] as? String
        categoryCell.amountLabel.text   = "\(String(describing: categoryDict["currency"])) \(String(describing: categoryDict["amount"]))"
        categoryCell.dateLabel.text = categoryDict["date"] as? String
        return categoryCell
    }
}

