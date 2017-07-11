//
//  MyExpensesTableViewCell.swift
//  SourceLead
//
//  Created by BIS on 10/07/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit

class MyExpensesTableViewCell: UITableViewCell {

    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
