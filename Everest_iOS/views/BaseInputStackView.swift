//
//  BaseInputView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-06.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class BaseInputView: UIView {
    var stackView: UIStackView
    
    init(_ coder: NSCoder? = nil) {
        self.stackView = UIStackView()
        self.stackView.axis = UILayoutConstraintAxis.vertical
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: CGRect.zero)
        }
        
        self.addSubview(self.stackView)
        setupConstraints()
    }
    
    required convenience init(coder: NSCoder) {
        self.init(coder)
    }
    
    private func setupConstraints() {
        self.addConstraint(
            NSLayoutConstraint(item: self.stackView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        )
        self.addConstraint(
            NSLayoutConstraint(item: self.stackView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        )
        self.addConstraint(
            NSLayoutConstraint(item: self.stackView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        )
        self.addConstraint(
            NSLayoutConstraint(item: self.stackView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        )
    }
}
