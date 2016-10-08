//
//  HeaderAndStackViewContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-07.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class HeaderAndStackViewContainer: HeaderViewContainer {
    var baseInputView: BaseInputView
    
    override init(_ coder: NSCoder? = nil) {
        self.baseInputView = BaseInputView()
        
        if let coder = coder {
            super.init(coder)
        } else {
            super.init()
        }
        
        self.addSubview(self.baseInputView)
        setupConstraints()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    private func setupConstraints() {
        self.addConstraint(NSLayoutConstraint(item: self.baseInputView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        )
        self.addConstraint(NSLayoutConstraint(item: self.baseInputView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        )
        self.addConstraint(NSLayoutConstraint(item: self.baseInputView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        )
        self.addConstraint(NSLayoutConstraint(item: self.baseInputView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        )
    }
}
