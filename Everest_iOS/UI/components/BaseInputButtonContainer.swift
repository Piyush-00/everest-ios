//
//  BaseInputButtonContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-09.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKO - UIButton with custom UI
class BaseInputButtonContainer: UIView {
    var button: UIButton
    
    init(buttonTitle: String, coder: NSCoder? = nil) {
        button = AppStyle.sharedInstance.baseInputButton()
        button.setTitle(buttonTitle, for: .normal)
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: CGRect.zero)
        }
        
        addSubview(button)
    }
    
    convenience init(_ coder: NSCoder? = nil) {
        if let coder = coder {
            self.init(buttonTitle: "", coder: coder)
        } else {
            self.init(buttonTitle: "")
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }
    
    //SKU - Function to remove any borders
    func removeBorder() {
      button.layer.borderWidth = 0
      button.layer.borderColor = nil
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalToConstant: AppStyle.sharedInstance.baseInputButtonContainerHeight).isActive = true
        
        button.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
