//
//  BaseInputTextField.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-08.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class BaseInputTextField: UITextField {
    init(_ placeholder: String, coder: NSCoder? = nil) {
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: CGRect.zero)
        }
    
        self.placeholder = placeholder
        borderStyle = UITextBorderStyle.none
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
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
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        
        var textRect = bounds
        textRect.origin.x = 10
        textRect.size.width -= 10
        
        return textRect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        
        var editingRect = bounds
        editingRect.origin.x = 10
        editingRect.size.width -= 10
        
        return editingRect
    }
}
