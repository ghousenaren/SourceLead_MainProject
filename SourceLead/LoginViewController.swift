//
//  LoginViewController.swift
//  SourceLead
//
//  Created by BIS on 6/1/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
//import WebServices

class LoginViewController: UIViewController,GIDSignInUIDelegate, GIDSignInDelegate{
    
    
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var txtImgView: UIImageView!
    @IBOutlet weak var passImgView: UIImageView!
    
    @IBAction func loginAction(_ sender: Any) {
//        loginAPI()
        guard (userIdTextField.text?.characters.count)!>2 else {
         showAlertMessage(title: "", message: "Username can't be empty")
         return
         }
         guard (passwordTextField.text?.characters.count)!>2 else {
         showAlertMessage(title: "", message: "Password can't be empty")
         return
         }
        loginAPI()
    }
    
    
    @IBAction func forgotPasswordClick(_ sender: Any) {
        
        
    }
    @IBAction func signUpClick(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userIdTextField.textFieldLeftImage(imageNamed:"user.png")
        passwordTextField.textFieldLeftImage(imageNamed:"pass.png")
        
        var error : NSError?
        
        //setting the error
        GGLContext.sharedInstance().configureWithError(&error)
        
        //if any error stop execution and print error
        if error != nil{
            print(error ?? "google error")
            return
        }
    }
    
    //when the signin complets
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //if any error stop and print the error
        if error != nil{
            print(error ?? "google error")
            return
        }
        
        //if success display the email on label
        print(user.profile.email);
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
    
    @IBAction func backToLoginScreen(segue : UIStoryboardSegue) {
        
        
    }
    
    @IBAction func btnGoogleLoginPressed(sender: AnyObject) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
}

extension LoginViewController {
    func loginAPI() {
//        let parameter : [String : String] = [
//            "username" : userIdTextField.text!,
//            "password":passwordTextField.text!
//        ]
        let url = BASE_URL
        //let url = "http://192.168.1.12:8080/sourcelead/rest/"
//        var data : Data
//        do {
//            data = try JSONSerialization.data(withJSONObject:parameter, options:[])
//            
//        }catch {
//            print("JSON serialization failed:  \(error)")
//            showAlertMessage(title: "Error", message: "Error in sending data")
//            return
//        }
//        let headers : [String : AnyObject] = ["Content-Type" : "application/json" as AnyObject, "X-  Username" : userIdTextField.text as AnyObject, "X-Password" : passwordTextField.text as AnyObject]
        let headers : [String : AnyObject] = ["Content-Type" : "application/json" as AnyObject,"X-Username":userIdTextField.text! as AnyObject,"X-Password":passwordTextField.text! as AnyObject]

        WebServices.sharedInstance.performApiCallWithURLString(urlString: url, methodName: "POST", headers: headers, parameters: nil, httpBody: nil, withMessage: "Login...", alertMessage: "Please check your device settings to ensure you have a working internet connection.", fromView: self.view, successHandler:  {[weak self] json, response in
            if let httpResponse = response {
                /*guard let mainResponseArc = MainResponse(json: result) else {
                 print("--------------Error-------------")
                 return
                 }*/
                print("^^^^^^^^^^",httpResponse)
                let statuscode = httpResponse.statusCode
                print(statuscode)
                if statuscode == 302 {
                    self?.showAlertMessage(title : "Problem" , message: "InActiveUser")

                }
                else if statuscode == 404 {
                    self?.showAlertMessage(title : "Problem" , message: "UnRegisterd User")

                }
                else if statuscode == 401 {
                    self?.showAlertMessage(title : "Problem" , message: "Invalid User")

                }
                
                else {
                    self?.showAlertMessage(title : "Problem" , message: "Invalid Password")

                }
                
                if let headers = httpResponse.allHeaderFields as? [String: String]{
                    
                    if let token = headers["X-CustomToken"] {
                        print("token--------------",token)
                        UserDefaults.standard.setValue(token, forKey: "TOKEN")
                        let appdelegate = UIApplication.shared.delegate as! AppDelegate
                        appdelegate.createMenuView()
                    }else {
                        self?.showAlertMessage(title : "Problem" , message: "Login failed, try again.")
                    }
                }
            }else {
                self?.showAlertMessage(title : "Problem" , message: "Issue in API Response.")
            }
            }, failureHandler: { response, error in
                //print("ERROR IS : \(error)")
        })
    }
}
