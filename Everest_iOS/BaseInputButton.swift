//
//  BaseInputButton.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-09.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class BaseInputButton: UIButton {
    var buttonText: String
    
    init(_ buttonText: String, coder: NSCoder? = nil) {
        self.buttonText = buttonText
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: CGRect.zero)
        }
        
        setTitle(buttonText, for: UIControlState.normal)
        backgroundColor = UIColor.red
        layer.cornerRadius = 4
    }
    
    convenience init(_ coder: NSCoder? = nil) {
        if let coder = coder {
            self.init("", coder: coder)
        } else {
            self.init("")
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
}
