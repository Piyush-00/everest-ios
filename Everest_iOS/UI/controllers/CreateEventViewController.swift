//
//  CreateEventViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, ImagePickerAlertProtocol {
    var viewContainer = HeaderAndStackViewContainer(withNavigationBar: true)
    var promptLabel = UILabel()
    var nameTextField = BaseInputTextField(hintText: NSLocalizedString("title", comment: "title placeholder"))
    var aboutTextView = BaseInputTextView(hintText: NSLocalizedString("about", comment: "about placeholder"))
    var locationTextField = BaseInputTextField(hintText: NSLocalizedString("location", comment: "location placeholder"))
    var dateTimeTextField = BaseInputTextField(hintText: NSLocalizedString("date and time", comment: "date and time placeholder"))
    var continueButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("continue", comment: "continue button"))
    var headerImageView = UIImageView()
  
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
        continueButtonContainer.button.isEnabled = false
        
        viewContainer.addArrangedSubviewToStackView(view: promptLabel)
        viewContainer.addArrangedSubviewToStackView(view: nameTextField)
        viewContainer.addArrangedSubviewToStackView(view: aboutTextView)
        viewContainer.addArrangedSubviewToStackView(view: locationTextField)
        viewContainer.addArrangedSubviewToStackView(view: dateTimeTextField)
        viewContainer.addArrangedSubviewToStackView(view: continueButtonContainer)
    
        view.addSubview(viewContainer)
        
        headerImageView.clipsToBounds = true
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.layer.masksToBounds = true
        
        viewContainer.setHeaderView(view: headerImageView)
        
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
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if let headerImage = event.getHeaderImage() {
        if headerImageView.image != headerImage {
          headerImageView.image = headerImage
        }
      } else {
        headerImageView.image = AppStyle.sharedInstance.pictureImageWide
      }
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
        event.setName(name: nameTextField.text ?? "")
        event.setDescription(description: aboutTextView.text)
        event.setLocation(location: locationTextField.text ?? "")
        event.setDate(date: dateTimeTextField.text ?? "")
        event.setStartTime(startTime: "7:00PM")
        event.setEndTime(endTime: "10:00PM")
        event.setHeaderImage(image: headerImageView.image)
        let attendeeFormSetViewController = AttendeeFormSetViewController()
        attendeeFormSetViewController.event = event
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
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == nameTextField {
      if string != "" {
        if !continueButtonContainer.button.isEnabled {
          continueButtonContainer.button.isEnabled = true
        }
      } else {
        if let text = textField.text {
          if text.characters.count < 2 {
            if continueButtonContainer.button.isEnabled {
              continueButtonContainer.button.isEnabled = false
            }
          }
        }
      }
    }
    return true
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
        imagePicker.delegate = self
        imagePicker.displayAlert()
    }
  
  //MARK: ImagePickerAlertProtocol
  
  func didPickImage(image: UIImage) {
    headerImageView.image = image
    event.setHeaderImage(image: image)
  }
}
