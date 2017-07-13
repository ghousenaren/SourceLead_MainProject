//
// NavigationMenuViewController.swift
//
// Copyright 2017 Handsome LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit
import InteractiveSideMenu
import moa

/*
 Menu controller is responsible for creating its content and showing/hiding menu using 'menuContainerViewController' property.
 */
class NavigationMenuViewController: MenuViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userEmailIdLabel: UILabel!
    
    let kCellReuseIdentifier = "MenuCell"
    var menuItems      = [String]()
    var menuItemIcons  = [String]()

    @IBOutlet weak var tableView: UITableView!

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
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
        
        profileImageView.moa.url = (mainResponseArc.profileImageUrl)! as String
        let UserID       = (mainResponseArc.userId)! as Int
        StorageData.set(UserID, forKey: "USERID")
         print(",........,.,,,..,/.......",StorageData.string(forKey: "USERID"))
        print("???????????????????????????--------------------???????????????",UserID)
        let fullName    = mainResponseArc.firstName! + " " + mainResponseArc.lastName!
        userFullNameLabel.text = fullName
        //for time being added
        
        for orgList in mainResponseArc.locationList! as [LocationList] {
            if orgList.isPrimaryOrg == "Y" {
                menuItems       = orgList.menuList!
                menuItemIcons   =  orgList.menuIconsList!
                userEmailIdLabel.text  = orgList.orgName!
                let exlocationCode           = orgList.locationCode
                StorageData.set(exlocationCode, forKey: "LOCATIONCODE")
            }
        }

        
        // Select the initial row
        self.tableView.backgroundColor = UIColor .white
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        //LoginViewControllerID
        StorageData.removeObject(forKey: "TOKEN")
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewControllerID") as? LoginViewController
        {
            
            present(vc, animated: true, completion: nil)
        }
        //UIApplication.shared.keyWindow?.rootViewController = loginViewController
    }
    
}

/*
 Extention of `NavigationMenuViewController` class, implements table view delegates methods.
 */
extension NavigationMenuViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell : MenuItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath) as! MenuItemTableViewCell
        
        //menuCell.menuItemImageView.moa.url = menuItemIcons[indexPath.row] as String
        menuCell.menuLabel.text            = menuItems[indexPath.row] as String
        
//        //cell.imageView?.image = UIImage(named:"twitter.png")
      menuCell.menuItemImageView?.image = UIImage(named: menuItemIcons[indexPath.row])
//       // cell.textLabel?.textColor = UIColor.black

        return menuCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }
        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
        menuContainerViewController.hideSideMenu()
    }
}
