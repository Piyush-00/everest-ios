//
//  UIViewExtension.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-08.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

extension UIView {
    //SKO - add side border functionality
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
            sideBorderView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            sideBorderView.widthAnchor.constraint(equalToConstant: width).isActive = true
            sideBorderView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            sideBorderView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
            break
        case borderSide.right:
            sideBorderView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            sideBorderView.widthAnchor.constraint(equalToConstant: width).isActive = true
            sideBorderView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            sideBorderView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
            break
        case borderSide.top:
            sideBorderView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            sideBorderView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            sideBorderView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            sideBorderView.heightAnchor.constraint(equalToConstant: width).isActive = true
            break
        case borderSide.bottom:
            sideBorderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            sideBorderView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            sideBorderView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            sideBorderView.heightAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    var superviewBackgroundColor: UIColor? {
        if let superView = self.superview {
            if let backgroundColor = superView.backgroundColor {
                return backgroundColor
            }
        }
        
        return nil
    }
}
