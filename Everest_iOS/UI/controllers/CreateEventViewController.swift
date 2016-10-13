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
    
    //SKO - Use layout anchors to set auto layout constraints
    private func setupContstraints() {
        viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    //SKO - on-click listener
    func onTapContinueButton(sender: UIButton) {
        print("button clicked")
    }
}
