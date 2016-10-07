//
//  BaseInputStackView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-06.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class BaseInputStackView: UIStackView {
    
    init(_ coder: NSCoder? = nil) {
        if let coder = coder {
            super.init(coder: coder)
        } else {
            super.init(frame: CGRect.zero)
        }
        
        self.axis = UILayoutConstraintAxis.horizontal
        self.distribution = UIStackViewDistribution.equalCentering
    }
    
    required convenience init(coder: NSCoder) {
        self.init(coder)
    }
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        
        //if user's device is a phone, set autolayout constraints
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            view.translatesAutoresizingMaskIntoConstraints = false
            var dView:[String:UIView] = [:]
            dView["view"] = view
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: [], metrics: nil, views: dView))
            view.bounds.size.height = 50
        //if user's device is an iPad, set frame so view doesn't stretch to margins
        } else {
            view.frame = CGRect(x: self.center.x, y: 0, width: 200, height: 50)
        }
    }
}
