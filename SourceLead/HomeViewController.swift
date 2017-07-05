//
//  HomeViewController.swift
//  SourceLead
//
//  Created by BIS on 7/3/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit
import InteractiveSideMenu


class HomeViewController: UIViewController, SideMenuItemContent, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loginProife()
        
        // Do any additional setup after loading the view.
    }
    
    func showAlertMessage(title : String, message : String) -> Void {
        DispatchQueue.main.async{ [weak self] in
            let alert = Global.showAlertWithTitle(title: title, okTitle: "Ok", cancelTitle: "", message: message, isCancel: false, okHandler: {action in
                
                return
            })
            self?.present(alert, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openMenu(_ sender: UIButton) {
        
        if let menuItemViewController = self.tabBarController as? SideMenuItemContent {
            menuItemViewController.showSideMenu()
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
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
            return cell
        }
        
        // second row should display categories
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellExpanse", for: indexPath) as UITableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        return cell
        
        
    }
    
}
extension HomeViewController {
    func loginProife() {
        let defaults = UserDefaults.standard
        let tokenvalue = defaults.object(forKey: "TOKEN")
        /*print(tokenvalue)
         let parameter : [String : String] = [
         "token" :tokenvalue as! String
         ]*/
        //let url = BASE_URL +  "restAuthenticate"
        let url = "http://192.168.1.10:8080/sourcelead/rest/loginUserProfile"
        /*var data : Data
         do {
         data = try JSONSerialization.data(withJSONObject:parameter, options:[])
         
         }catch {
         print("JSON serialization failed:  \(error)")
         showAlertMessage(title: "Error", message: "Error in sending data")
         return
         }*/
        let headers : [String : AnyObject] = ["Content-Type" : "application/json" as AnyObject, "X-CustomToken" : tokenvalue as AnyObject]
        WebServices.sharedInstance.performApiCallWithURLString(urlString: url, methodName: "GET", headers: headers, parameters: nil, httpBody: nil, withMessage: "Loading...", alertMessage: "Please check your device settings to ensure you have a working internet connection.", fromView: self.view, successHandler:  {[weak self] json, response in
            if let result = json as? Dictionary<String , AnyObject> {
                print(result)
                
                guard let mainResponse = MainResponse(json: result) else {
                    return
                }
                StorageData.set(mainResponse, forKey: "MAIN_RESPONSE")
                
                print(" \(mainResponse.firstName!) and \(mainResponse.lastName!)" )
                print(mainResponse)
                //print(mainResponse.menuList!)
                
                
                
            }else {
                self?.showAlertMessage(title : "Problem" , message: "Issue in API Response.")
            }
            }, failureHandler: { response, error in
                //print("ERROR IS : \(error)")
        })
    }}
