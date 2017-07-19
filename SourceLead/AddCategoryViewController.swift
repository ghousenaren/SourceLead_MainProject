//
//  AddCategoryViewController.swift
//  SourceLead
//
//  Created by Bis on 11/07/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import AVFoundation
import AVKit


class AddCategoryViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate  {
    let projectmemberlistObj = [projectMembersList]()
    var mainExpensesResponse: ExpensesResponse!

    @IBOutlet weak var catagoryButton: UIButton!

    @IBOutlet weak var paymentmodeButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var CurrencyButton: UIButton!
    var currencySymbolsArray = [String]()
    var categoryArray = [String]()
    var paymentModeArray = [String]()
    var imageCollectionArray = [UIImage]()

    @IBOutlet weak var categoryTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var paymentModeLabel: UILabel!
    @IBOutlet weak var currencySelectedLabel: UILabel!
    @IBOutlet weak var receiptIssuedByTextField: UITextField!
    @IBOutlet weak var imageHolderView: UIView!
    @IBOutlet weak var imageStackView: UIStackView!
    
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
    @IBAction func backCancelButtonAction(_ sender: UIButton) {
    
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
                self.categoryTypeLabel.text = selectedString
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
                self.paymentModeLabel.text = selectedString
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
                self.currencySelectedLabel.text = selectedString
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
                    self.dateLabel.text = "\(Global.stringFromDate(dateValue: selectedDate))"
                })
                .setCancelButton(color: UIColor.white, action: { v in print("cancel")})
               .appear(originView: dateButton, baseViewController: self)

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        // All It is a we retriew Pictuer that we are selecting from iOS device
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageCollectionArray.append(image)
            refreshImageHolderView(image : image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        handlingAlertActions()
    }
    
    func handlingAlertActions()  {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController.init(title: "Add a Picture", message: "choose from", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction.init(title: "Camera", style: .default ) {
            (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let photoLibAction = UIAlertAction.init(title: "Photos Library", style: .default ) {
            (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        let savedPhotosAction = UIAlertAction.init(title: "Saved Photos", style: .default ) {
            (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    func refreshImageHolderView(image : UIImage)  {
        //for image in imageCollectionArray {
            let addImageView = UIImageView.init(image: image)
            addImageView.contentMode = .scaleAspectFit
            addImageView.translatesAutoresizingMaskIntoConstraints = false
            // Add size constraints to the image view
            let widthCst = NSLayoutConstraint(item: addImageView, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
            addImageView.addConstraint(widthCst)
            imageStackView.addArrangedSubview(addImageView)
       // }
    }
}
