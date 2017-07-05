//
//  Designables.swift
//  KYGInsurance
//
//  Created by Ghouse Basha Shaik on 23/06/17.
//  Copyright © 2017 Ghouse Basha Shaik. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BorderButton: UIButton {
    
    @IBInspectable override var cornerRadius: CGFloat {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? = UIColor.clear {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
