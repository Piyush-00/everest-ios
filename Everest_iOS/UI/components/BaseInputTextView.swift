//
//  BaseInputTextView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-08.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKO - UITextField with custom UI
class BaseInputTextView: UITextView, UITextViewDelegate {
    var placeholderLabel: UILabel
    
    init(hintText: String? = nil, textInput: String? = nil, coder: NSCoder? = nil) {
        //SKO - Since no placeholder text for UITextViews, set label
        placeholderLabel = UILabel()
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            //SKO - Frame irrelevant because using auto layout; set to CGRect.zero
            super.init(frame: CGRect.zero, textContainer: nil)
        }
        
        placeholderLabel.frame = CGRect(x: 10, y: 10, width: 200, height: 17)
        placeholderLabel.text = hintText
        placeholderLabel.alpha = 0.2
        placeholderLabel.font = AppStyle.sharedInstance.textFontMedium
        addSubview(placeholderLabel)
        
        textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 0)
        
        font = AppStyle.sharedInstance.textFontMedium
        backgroundColor = AppStyle.sharedInstance.textViewBackgroundColor
        delegate = self

        text = textInput
    }
    
    convenience init(_ coder: NSCoder? = nil) {
        if let coder = coder {
            self.init(hintText: "", coder: coder)
        } else {
            self.init(hintText: "")
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    //SKO - Emulate placeholder text functionality
    func textViewDidChange(_ textView: UITextView) {
        if text == "" {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
    
    //SKU - Function to remove any borders
    func removeBorder() {
      layer.borderWidth = 0
      layer.borderColor = nil
    }
}
