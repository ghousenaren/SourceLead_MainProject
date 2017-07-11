//
//  ExpensesViewController.swift
//  SourceLead
//
//  Created by Bis on 05/07/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController {

    @IBOutlet weak var expensesBottomView: UIView!
    @IBOutlet weak var employeessBottomView: UIView!
    @IBOutlet weak var expensesTableView: UITableView!

    var expensesArray = [["purpose" : "Travalling with client",
        "amount" :"1200", "startDate" : "09/07/2017", "endDate" : "19/07/2017", "status" : "rejected"],
                         ["purpose" : "Food with client",
                          "amount" :"4200", "startDate" : "09/07/2017", "endDate" : "19/07/2017", "status" : "submitted"], ["purpose" : "Drinks with client",
                                                                                                                            "amount" :"5600", "startDate" : "09/07/2017", "endDate" : "19/07/2017", "status" : "approved"]]
    
    
    @IBAction func backtodashboard(_ sender: Any) {
            navigationController?.popToRootViewController(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func unwindToExpenseListViewController(segue: UIStoryboardSegue) {
        print("Unwind to Root View Controller")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchButtonAction(_ sender: UIButton) {
        expensesBottomView.backgroundColor      = UIColor.white
        employeessBottomView.backgroundColor    = UIColor.white
        switch sender.tag {
        case 0:
            expensesBottomView.backgroundColor      = UIColor.orange
        case 1:
            employeessBottomView.backgroundColor    = UIColor.orange
        default:
            print("no code here")
        }
    }
}
extension ExpensesViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return expensesArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:MyExpensesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myExpensesCell", for: indexPath) as! MyExpensesTableViewCell
        cell.purposeLabel.text      = expensesArray[indexPath.row]["purpose"]
        cell.amountLabel.text       = expensesArray[indexPath.row]["amount"]
        cell.startDateLabel.text    = expensesArray[indexPath.row]["startDate"]
        cell.endDateLabel.text      = expensesArray[indexPath.row]["endDate"]
        let status = expensesArray[indexPath.row]["status"]
        cell.statusButton .setTitle(status, for: .normal)
        if status == "rejected" {
            cell.statusButton.backgroundColor = UIColor.red
        }else if status == "submitted" {
            cell.statusButton.backgroundColor = UIColor.orange
        }else if status == "approved" {
            cell.statusButton.backgroundColor = UIColor.green
        }
        return cell
    }
}

extension ExpensesViewController : UITableViewDelegate {
    
}
