//
//  AddCategoryViewController.swift
//  SourceLead
//
//  Created by Bis on 11/07/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit
import SwiftyPickerPopover


class AddCategoryViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let projectmemberlistObj = [projectMembersList]()
    var mainExpensesResponse: ExpensesResponse!

    @IBOutlet weak var catagoryButton: UIButton!

    @IBOutlet weak var paymentmodeButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var CurrencyButton: UIButton!
    var currencySymbolsArray = [String]()
    var categoryArray = [String]()
    var paymentModeArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencySymbolsArray = mainExpensesResponse.currencyCodeList as! [String]
        paymentModeArray     = mainExpensesResponse.paymentModes as! [String]
        for categoryName in mainExpensesResponse.expenseCategoryList! {
            categoryArray.append(categoryName.expensesName!)
          
        }
//       for paymentmode in mainExpensesResponse.expenseCategoryList!.{
//           paymentModeArray.append(categoryName.expensesName!)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func catagoryPickerButtonAction(_ sender: UIButton) {
        StringPickerPopover(title: "Select Catagory", choices: categoryArray)
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
        StringPickerPopover(title: "Select PaymentMode", choices: paymentModeArray)
            .setSelectedRow(0)
            .setDoneButton(color: UIColor.white, action: { (popover, selectedRow, selectedString) in
                print("done row \(selectedRow) \(selectedString)")
                self.paymentmodeButton.setTitle(selectedString, for: .normal)
            })
            .setCancelButton(color: UIColor.white, action: { v in print("cancel")}
            )
            .appear(originView: paymentmodeButton, baseViewController: self)
    }
    
    

    @IBAction func currencyMode(_ sender: Any) {
        StringPickerPopover(title: "", choices: currencySymbolsArray)
            .setSelectedRow(0)
            .setSize(width: 100, height: 150)
            .setDoneButton(color: UIColor.white, action: { (popover, selectedRow, selectedString) in
                print("done row \(selectedRow) \(selectedString)")
                self.CurrencyButton.setTitle(selectedString, for: .normal)
            })
            .appear(originView: CurrencyButton, baseViewController: self)
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
    //
    @IBAction func pickPhoto(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    @IBAction func takePhoto(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
        }
        picker.dismiss(animated: true, completion: nil)
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
