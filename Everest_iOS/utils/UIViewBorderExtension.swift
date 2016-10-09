//
//  UIViewBorderExtension.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-08.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

extension UIView {
    enum borderSide {
        case left
        case right
        case top
        case bottom
    }
    
    func sideBorder(side: borderSide, width: CGFloat, colour: UIColor) {
        let sideBorderLayer = CALayer()
        sideBorderLayer.backgroundColor = colour.cgColor
        
        switch side {
        case borderSide.left:
            sideBorderLayer.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
            break
        case borderSide.right:
            sideBorderLayer.frame = CGRect(x: self.frame.width, y: 0, width: width, height: self.frame.height)
            break
        case borderSide.top:
            sideBorderLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
            break
        case borderSide.bottom:
            sideBorderLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: width)
        }
        
        self.layer.addSublayer(sideBorderLayer)
    }
}
