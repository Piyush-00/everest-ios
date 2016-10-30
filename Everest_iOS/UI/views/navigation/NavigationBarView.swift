//
//  NavigationBarView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class NavigationBarView: UIView {
    var backButton: UIButton
    
    init(_ coder: NSCoder? = nil) {
        backButton = UIButton()
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init()
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
}
