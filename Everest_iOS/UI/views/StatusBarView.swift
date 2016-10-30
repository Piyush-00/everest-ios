//
//  StatusBarView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class StatusBarView: UIView {
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = self.superviewBackgroundColor
        sideBorder(side: .bottom, width: 1, colour: UIColor.black.withAlphaComponent(0.2))
        
        heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height).isActive = true
    }
}
