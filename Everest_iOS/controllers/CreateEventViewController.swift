//
//  CreateEventViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    var viewContainer: HeaderAndStackViewContainer
    
    init(_ coder: NSCoder? = nil) {
        self.viewContainer = HeaderAndStackViewContainer()
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init()
        }
        
        self.view.addSubview(viewContainer)
        setupContstraints()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let container = HeaderAndStackViewContainer()
        self.view.addSubview(container)
    }
    
    private func setupContstraints() {
        
    }
}

