//
//  NewExpensesViewController.swift
//  SourceLead
//
//  Created by Ghouse Basha Shaik on 10/07/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit

class NewExpensesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 1
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell : NewExpenseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "addExpensesCell", for: indexPath) as! NewExpenseTableViewCell
        //if indexPath.row == 1 {
            let cell: NewExpenseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "addExpensesCell", for: indexPath) as! NewExpenseTableViewCell
        //}
        
        return cell
    }
}
