//
//  CategoryTableViewCell.swift
//  SourceLead
//
//  Created by Ghouse Basha Shaik on 19/07/17.
//  Copyright © 2017 BIS. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleBarLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
