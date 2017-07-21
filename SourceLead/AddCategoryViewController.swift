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
import Photos

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
    var imageFilenameArray = [String]()
    @IBOutlet weak var categoryTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var paymentModeLabel: UILabel!
    @IBOutlet weak var currencySelectedLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var receiptIssuedByTextField: UITextField!
    @IBOutlet weak var imageHolderView: UIView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var tableViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var imageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      /* currencySymbolsArray = mainExpensesResponse.currencyCodeList as! [String]
       paymentModeArray     = mainExpensesResponse.paymentModes as! [String]
       for categoryName in mainExpensesResponse.expenseCategoryList! {
            categoryArray.append(categoryName.expensesName!)
          
        }*/
//       for paymentmode in mainExpensesResponse.expenseCategoryList!.{
//           paymentModeArray.append(categoryName.expensesName!)
//        }
        
        
    }
    @IBAction func backCancelButtonAction(_ sender: UIButton) {
    
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        if validate() {
            
            //Need to added Expenses Id and a auto Id for this
            let addExpensesJson = ["cateogyType" :  self.categoryTypeLabel.text ?? "",
                                   "date"        :  self.dateLabel.text ?? "",
                                   "paymentMode" :  self.paymentModeLabel.text ?? "",
                                   "amount"      :  self.amountTextField.text ?? "",
                                   "currency"    :  self.currencySelectedLabel.text ?? "",
                                   "receiptBy"   :  self.receiptIssuedByTextField.text ?? "",
                                   "description" :  self.descriptionTextView.text ?? "",
                                   "attachments" :  imageCollectionArray,
                                   "filenames"   :  imageFilenameArray
            ] as? [String:AnyObject]
        
            guard var allExpensesRecordsArray  = StorageData.value(forKey: "EPENSES_JSON") as? [[String : AnyObject]]  else {
                let newExpensesArray = [addExpensesJson]
                StorageData.set(newExpensesArray, forKey : "EXPENSES_JSON")
                return
            }
            allExpensesRecordsArray.append(addExpensesJson!)
            StorageData.set(allExpensesRecordsArray, forKey : "EXPENSES_JSON")
            
            self.performSegue(withIdentifier: "unwindToNewExpensesController", sender: self)
        }
    }

    /*
     "amount":"123",
     "attachments":[  ],
     "categoryType":"Snacks",
     "currency":"INR",
     "date":"18/7/2017 ",
     "description":"test",
     "paymentMode":"Credit Card",
     "receiptBy":"test"
 
     */
    func validate() -> Bool {
        guard (self.categoryTypeLabel.text?.characters.count)! > 2 else {
            showAlert(withMessage : "category type should be selected")
            return false
        }
        guard (self.dateLabel.text?.characters.count)! > 2   else {
            showAlert(withMessage : "Date should be selected")
            return false
        }
        guard (self.paymentModeLabel.text?.characters.count)! > 2  else {
            showAlert(withMessage : "Payment mode should be selected")
            return false
        }
        guard (self.amountTextField.text?.characters.count)! > 2 else {
            showAlert(withMessage : "Kindly enter the amount")
            return false
        }
        guard (self.receiptIssuedByTextField.text?.characters.count)! > 2  else {
            showAlert(withMessage : "Kindly mention receipt issued by")
            return false
        }
        
    return true
    }
    
    func showAlert(withMessage : String) {
        DispatchQueue.main.async{ [weak self] in
            let alert = Global.showAlertWithTitle(title: "", okTitle: "OK", cancelTitle: nil, message: withMessage, isCancel: false, okHandler:{action in
            })

            self?.present(alert, animated: true, completion: nil)
        }
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
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image chosen")
            return
        }
        
        let url = info[UIImagePickerControllerReferenceURL] as! URL
        let assets = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil)
        let fileName = PHAssetResource.assetResources(for: assets.firstObject!).first!.originalFilename
        
        imageFilenameArray.append(fileName)
        print("File name = \(fileName)")

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        if imageCollectionArray.count > 2 {
            showAlert(withMessage :"Max 3 screenshots")
            return
        }
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
        DispatchQueue.main.async {[weak self] in
            self?.tableViewHeightConstraints.constant = CGFloat(44 * (self?.imageCollectionArray.count)!)
            self?.imageTableView.reloadData()
        }

    }
}


extension AddCategoryViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}

extension AddCategoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imageCollectionArray.count
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            imageCollectionArray.remove(at: indexPath.row)
            imageFilenameArray.remove(at: indexPath.row)
            self.tableViewHeightConstraints.constant = CGFloat(44 * (self.imageCollectionArray.count))
            imageTableView.beginUpdates()
            imageTableView.deleteRows(at: [indexPath], with: .automatic)
            imageTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        imageCell.textLabel?.text = imageFilenameArray[indexPath.row]
        imageCell.imageView?.image = imageCollectionArray[indexPath.row]
       /* let categoryDict = categoryTableArray[indexPath.row]
        imageCell.titleBarLabel.text = categoryDict["categoryType"] as? String
        categoryCell.amountLabel.text   = "\(String(describing: categoryDict["currency"])) \(String(describing: categoryDict["amount"]))"
        categoryCell.dateLabel.text = categoryDict["date"] as? String*/
        return imageCell
    }
}
