//
//  AddCategoryViewController.swift
//  SourceLead
//
//  Created by Bis on 11/07/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit
import SwiftyPickerPopover


class AddCategoryViewController: UIViewController {
    @IBOutlet weak var catagoryButton: UIButton!

    @IBOutlet weak var paymentmodeButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func catagoryPickerButtonAction(_ sender: UIButton) {
        StringPickerPopover(title: "Select Catagory", choices: ["Catagory 1","Catagory 2","Catagory 3"])
            .setSelectedRow(0)
            .setDoneButton(color: UIColor.white, action: { (popover, selectedRow, selectedString) in
                print("done row \(selectedRow) \(selectedString)")
                self.catagoryButton.setTitle(selectedString, for: .normal)
            })
            .setCancelButton(color: UIColor.white, action: { v in print("cancel")}
            )
            .appear(originView: catagoryButton, baseViewController: self)
    }
    @IBAction func paymentPickerButtonAction(_ sender: UIButton) {
        StringPickerPopover(title: "Select PaymentMode", choices: ["PaymentMode 1","PaymentMode 2","PaymentMode 3"])
            .setSelectedRow(0)
            .setDoneButton(color: UIColor.white, action: { (popover, selectedRow, selectedString) in
                print("done row \(selectedRow) \(selectedString)")
                self.paymentmodeButton.setTitle(selectedString, for: .normal)
            })
            .setCancelButton(color: UIColor.white, action: { v in print("cancel")}
            )
            .appear(originView: paymentmodeButton, baseViewController: self)
    }


 
    @IBAction func datePickerButtonAction(_ sender: Any) {
        let startDateFromJson = "01/03/2017"
        let endDateFromJson   = "01/08/2017"
        
        
            let minDate = Global.dateFromString(dateString: startDateFromJson)
            let maxDate = Global.dateFromString(dateString: endDateFromJson)
            
            DatePickerPopover(title: "Select Start Date")
                .setDateMode(.date)
                .setSelectedDate(Date())
                .setMaximumDate(maxDate)
                .setMinimumDate(minDate)
                .setDoneButton(color: UIColor.white, action: { popover, selectedDate in print("selectedDate \(selectedDate)")
                    self.dateButton.setTitle("\(Global.stringFromDate(dateValue: selectedDate))", for: .normal)})
                .setCancelButton(color: UIColor.white, action: { v in print("cancel")})
               .appear(originView: dateButton, baseViewController: self)

        
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
