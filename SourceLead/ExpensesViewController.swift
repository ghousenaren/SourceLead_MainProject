//
//  ExpensesViewController.swift
//  SourceLead
//
//  Created by Ghouse Basha Shaik on 05/07/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController {

    @IBOutlet weak var expensesBottomView: UIView!
    @IBOutlet weak var employeessBottomView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
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
