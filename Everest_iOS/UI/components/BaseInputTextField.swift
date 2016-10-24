//
//  BaseInputTextField.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-08.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKO - UITextField with custom UI
class BaseInputTextField: UITextField {
    init(_ placeholder: String, coder: NSCoder? = nil) {
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: CGRect.zero)
        }
        
        self.placeholder = placeholder
        
        font = AppStyle.sharedInstance.textFontBold
        borderStyle = UITextBorderStyle.none
        backgroundColor = AppStyle.sharedInstance.textFieldBackgroundColor
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
    
    //SKO - Set left padding for non-editing state
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        
        var textRect = bounds
        textRect.origin.x = 10
        textRect.size.width -= 10
        
        return textRect
    }
    
    //SKO - Set left padding for editing state
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        
        var editingRect = bounds
        editingRect.origin.x = 10
        editingRect.size.width -= 10
        
        return editingRect
    }
  
    //SKU - Function to remove any borders
    func removeBorder() {
      layer.borderWidth = 0
      layer.borderColor = nil
    }
}
