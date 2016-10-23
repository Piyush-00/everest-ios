//
//  CreateEventViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate {
    var viewContainer: HeaderAndStackViewContainer
    
    //SKO
    /*
    Designated initializer.
        
        If the view is instantiated from a storyboard, init parameter
        will be of type NSCoder, else nil.
    */
    init(_ coder: NSCoder? = nil) {
        viewContainer = HeaderAndStackViewContainer()
        
        //SKO - If init with coder, call super init with it
        if let coder = coder {
            super.init(coder: coder)!
        //SKO - Else, call super init with no parameters
        } else {
            super.init()
        }
    }
    
    //SKO
    /*
    Convenience initializer.
        
        If the view is instantiated from a storyboard, this init
        is called which in turn calls the designated initializer
        with the coder.
     */
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SKO - Init UI subclasses with hint text as param
        let promptLabel = UILabel()
        let nameTextField = BaseInputTextField("Name")
        let aboutTextView = BaseInputTextView("About")
        let locationTextField = BaseInputTextField("Location")
        let dateTimeTextField = BaseInputTextField("Date and Time")
        let continueButton = BaseInputButton("Continue")
        
        promptLabel.text = "Create a New Event"
        promptLabel.textAlignment = NSTextAlignment.center
        
        //SKO - Register on-click listener
        continueButton.addTarget(self, action: #selector(onTapContinueButton(sender:)), for: UIControlEvents.touchUpInside)
        
        viewContainer.addArrangedSubviewToStackView(view: promptLabel)
        viewContainer.addArrangedSubviewToStackView(view: nameTextField)
        viewContainer.addArrangedSubviewToStackView(view: aboutTextView)
        viewContainer.addArrangedSubviewToStackView(view: locationTextField)
        viewContainer.addArrangedSubviewToStackView(view: dateTimeTextField)
        viewContainer.addArrangedSubviewToStackView(view: continueButton)

        view.addSubview(viewContainer)
    }
    
    override func viewDidLayoutSubviews() {
        setupContstraints()
    }
    
    //SKO - Use layout anchors to set auto layout constraints
    private func setupContstraints() {
        viewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //SKO - on-click listener
    func onTapContinueButton(sender: UIButton) {
        print("button clicked")
    }
}
