//
//  Designables.swift
//  Created by BIS on 5/31/17.

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
    
    @IBInspectable var shadow: UIColor? = UIColor.clear {
        didSet {
        
            layer.shadowColor  = shadow?.cgColor
            layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
            layer.shadowOpacity = 1.0
            layer.shadowRadius = 3.0
            layer.masksToBounds = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
