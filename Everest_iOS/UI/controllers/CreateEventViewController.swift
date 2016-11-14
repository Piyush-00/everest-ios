//
//  CreateEventViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var viewContainer = HeaderAndStackViewContainer(withNavigationBar: true)
    var promptLabel = UILabel()
    var nameTextField = BaseInputTextField(hintText: NSLocalizedString("title", comment: "title placeholder"))
    var aboutTextView = BaseInputTextView(hintText: NSLocalizedString("about", comment: "about placeholder"))
    var locationTextField = BaseInputTextField(hintText: NSLocalizedString("location", comment: "location placeholder"))
    var dateTimeTextField = BaseInputTextField(hintText: NSLocalizedString("date and time", comment: "date and time placeholder"))
    var continueButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("continue", comment: "continue button"))
    var picturePromptImageView = UIImageView(image: AppStyle.sharedInstance.pictureImageWide)
    private let event = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        locationTextField.tag = 1
        dateTimeTextField.tag = 2
        
        nameTextField.delegate = self
        aboutTextView.delegate = self
        locationTextField.delegate = self
        dateTimeTextField.delegate = self
        
        promptLabel.text = NSLocalizedString("create a new event", comment: "create a new event label")
        promptLabel.font = AppStyle.sharedInstance.headerFontMedium
        promptLabel.textAlignment = .center
        
        //SKO - Register on-click listener
        continueButtonContainer.button.addTarget(self, action: #selector(onTapContinueButton(sender:)), for: .touchUpInside)
        
        viewContainer.addArrangedSubviewToStackView(view: promptLabel)
        viewContainer.addArrangedSubviewToStackView(view: nameTextField)
        viewContainer.addArrangedSubviewToStackView(view: aboutTextView)
        viewContainer.addArrangedSubviewToStackView(view: locationTextField)
        viewContainer.addArrangedSubviewToStackView(view: dateTimeTextField)
        viewContainer.addArrangedSubviewToStackView(view: continueButtonContainer)
    
        view.addSubview(viewContainer)
        
        picturePromptImageView.clipsToBounds = true
        picturePromptImageView.contentMode = .scaleAspectFill
        picturePromptImageView.layer.masksToBounds = true
        
        viewContainer.setHeaderView(view: picturePromptImageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
        viewContainer.headerView.addGestureRecognizer(tapGestureRecognizer)
        
        if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    //SKO - Use layout anchors to set auto layout constraints
    private func setupConstraints() {       
        viewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //SKO - on-click listener
    func onTapContinueButton(sender: UIButton) {
      self.view.endEditing(true)
      
      if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
        let attendeeFormSetViewController = AttendeeFormSetViewController()
        navigationController.pushViewController(attendeeFormSetViewController, animated: true)
      }
      //SKO - bring up next vc and carry data over (Event object argument)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            aboutTextView.becomeFirstResponder()
        } else {
            let nextTextFieldTag = textField.tag + 1
            if let nextTextField = view.viewWithTag(nextTextFieldTag) {
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        
        return false
    }
    
    //SKO - Emulate placeholder text functionality
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            aboutTextView.placeholderLabel.isHidden = false
        } else {
            aboutTextView.placeholderLabel.isHidden = true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //SKO - If click 'return' key on keyboard
        if text == "\n" {
            locationTextField.becomeFirstResponder()
            return false
        }
        return true
    }
    
    func didTapHeader(sender: UITapGestureRecognizer) {
        let imagePicker = ImagePickerAlertController(frame: view.bounds, controller: self)
        imagePicker.displayAlert(imageReference: picturePromptImageView)
    }
}
