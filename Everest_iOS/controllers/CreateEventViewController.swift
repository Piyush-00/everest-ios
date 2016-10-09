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
        viewContainer = HeaderAndStackViewContainer()
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init()
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let promptLabel = UILabel()
        let nameTextField = BaseInputTextField("Name")
        let aboutTextView = BaseInputTextView("About")
        let locationTextField = BaseInputTextField("Location")
        let dateTimeTextField = BaseInputTextField("Date and Time")
        let continueButton = BaseInputButton("Continue")
        
        continueButton.addTarget(self, action: #selector(onTapContinueButton(sender:)), for: UIControlEvents.touchUpInside)
        
        promptLabel.text = "Create a New Event"
        promptLabel.textAlignment = NSTextAlignment.center
        
        viewContainer.addArrangedSubview(view: promptLabel)
        viewContainer.addArrangedSubview(view: nameTextField)
        viewContainer.addArrangedSubview(view: aboutTextView)
        viewContainer.addArrangedSubview(view: locationTextField)
        viewContainer.addArrangedSubview(view: dateTimeTextField)
        viewContainer.addArrangedSubview(view: continueButton)

        view.addSubview(viewContainer)
    }
    
    override func viewDidLayoutSubviews() {
        setupContstraints()
    }
    
    private func setupContstraints() {
        viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func onTapContinueButton(sender: UIButton) {
        print("button clicked")
    }
}
