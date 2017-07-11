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

    var selectedDateButton = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                .setDoneButton(action: { popover, selectedDate in print("selectedDate \(selectedDate)")
                    self.startButton.setTitle("\(Global.stringFromDate(dateValue: selectedDate))", for: .normal)})
                .setCancelButton(action: { v in print("cancel")})
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
                .setDoneButton(action: { popover, selectedDate in print("selectedDate \(selectedDate)")
                self.endButton.setTitle("\(Global.stringFromDate(dateValue: selectedDate))", for: .normal)})
                .setCancelButton(action: { v in print("cancel")
                })
                .appear(originView: endButton, baseViewController: self)
        }
    }

    @IBAction func projectPickerButtonAction(_ sender: UIButton) {
        StringPickerPopover(title: "Select Project", choices: ["Project 1","Project 2","Project 3"])
            .setSelectedRow(0)
            .setDoneButton(action: { (popover, selectedRow, selectedString) in
                print("done row \(selectedRow) \(selectedString)")
                self.projectButton.setTitle(selectedString, for: .normal)
            })
            .setCancelButton(action: { v in print("cancel")}
            )
            .appear(originView: projectButton, baseViewController: self)
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
