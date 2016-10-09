//
//  BaseInputTextView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-08.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class BaseInputTextView: UITextView, UITextViewDelegate {
    private var placeholderLabel: UILabel
    
    init(_ placeholder: String, coder: NSCoder? = nil) {
        placeholderLabel = UILabel()
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: CGRect.zero, textContainer: nil)
        }
        
        placeholderLabel.frame = CGRect(x: 10, y: 10, width: 100, height: 17)
        placeholderLabel.text = placeholder
        placeholderLabel.alpha = 0.2
        
        textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 0)
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        font = UIFont.systemFont(ofSize: 17)
        addSubview(placeholderLabel)
        delegate = self
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
    
    func textViewDidChange(_ textView: UITextView) {
        if text == "" {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
}
