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
        baseInputView = BaseInputView()
        
        if let coder = coder {
            super.init(coder)
        } else {
            super.init()
        }
        
        setContentView(view: baseInputView)
        setupConstraints()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        baseInputView.translatesAutoresizingMaskIntoConstraints = false
        
        baseInputView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        baseInputView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        baseInputView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    
    func addArrangedSubview(view: UIView) {
        baseInputView.addArrangedSubview(view: view)
    }
}
