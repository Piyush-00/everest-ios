//
//  CreateEventViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let createEventViewContainer = CreateEventViewContainer()
        
        self.view.addSubview(createEventViewContainer)
    }
}

