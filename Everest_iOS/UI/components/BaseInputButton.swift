//
//  BaseInputButton.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-09.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKO - UIButton with custom UI
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
        backgroundColor = UIColor(netHex: 0xBD3333)
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
    
    //SKO - Set touch UI behaviour
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
    }
    
    //SKO - Set touch UI behaviour
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
    }
  
    //SKU - Function to remove any borders
    func removeBorder() {
      layer.borderWidth = 0
      layer.borderColor = nil
    }
}
