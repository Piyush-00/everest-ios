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
        let sideBorderView = UIView()
        
        sideBorderView.backgroundColor = colour
        addSubview(sideBorderView)
        
        sideBorderView.translatesAutoresizingMaskIntoConstraints  = false
        
        switch side {
        case borderSide.left:
            
            break
        case borderSide.right:
           
            break
        case borderSide.top:
            
            break
        case borderSide.bottom:
            sideBorderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            sideBorderView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            sideBorderView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            sideBorderView.heightAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
