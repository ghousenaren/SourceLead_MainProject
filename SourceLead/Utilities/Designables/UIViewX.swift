

//  Created by BIS on 5/31/17.
//  Created by BIS on 5/31/17.

import UIKit

@IBDesignable
class UIViewX: UIView {

    @IBInspectable var FirstColor : UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var SecondColor : UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    override class var layerClass: Swift.AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    @IBInspectable var CornerRadius : CGFloat = 0 {
        didSet {
            let layer = self.layer
            layer.cornerRadius = CornerRadius
        }
    }
    @IBInspectable var BorderWidth : CGFloat = 0 {
        didSet {
            let layer = self.layer
            layer.borderWidth = BorderWidth
        }
    }
    
    @IBInspectable var BorderColor : UIColor = UIColor.clear {
        didSet {
            //let layer = self.layer as! CALayer
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor]
    }
}
