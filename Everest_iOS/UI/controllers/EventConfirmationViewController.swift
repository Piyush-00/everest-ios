//
//  EventConfirmationViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-05.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventConfirmationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
  private let headerAndStackViewController = HeaderAndStackViewContainer(withNavigationBar: true)
  private let picturePromptImageView = UIImageView(image: AppStyle.sharedInstance.pictureImageWide)
  
  var event: Event?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround()
    
    let appStyle = AppStyle.sharedInstance
    
    let eventConfirmationTitleLabel = UILabel()
    
    let eventCategoryLabel = UILabel()
    
    let eventTitleTextField = BaseInputTextField(hintText: NSLocalizedString("title", comment: "title placeholder"))
    let eventDescriptionTextView = BaseInputTextView(hintText: NSLocalizedString("about", comment: "about placeholder"))
    let eventLocationTextField = BaseInputTextField(hintText: NSLocalizedString("location", comment: "location placeholder"))
    let eventDateAndTimeTextField = BaseInputTextField(hintText: NSLocalizedString("date and time", comment: "date and time placeholder"))
    
    let eventTitleContainer = TitleAndContentContainer(withTitle: NSLocalizedString("title", comment: "title placeholder"), andContent: eventTitleTextField)
    let eventDescriptionContainer = TitleAndContentContainer(withTitle: NSLocalizedString("about", comment: "about placeholder"), andContent: eventDescriptionTextView)
    let eventLocationContainer = TitleAndContentContainer(withTitle: NSLocalizedString("location", comment: "location placeholder"), andContent: eventLocationTextField)
    let eventDateAndTimeContainer = TitleAndContentContainer(withTitle: NSLocalizedString("date and time", comment: "date and time placeholder"), andContent: eventDateAndTimeTextField)
    
    eventConfirmationTitleLabel.textAlignment = .center
    eventConfirmationTitleLabel.numberOfLines = 0
    eventConfirmationTitleLabel.lineBreakMode = .byWordWrapping
    eventConfirmationTitleLabel.font = appStyle.headerFontMedium
    eventConfirmationTitleLabel.text = NSLocalizedString("event confirmation", comment: "event confirmation header")
    
    eventCategoryLabel.textAlignment = .center
    eventCategoryLabel.numberOfLines = 0
    eventCategoryLabel.lineBreakMode = .byWordWrapping
    eventCategoryLabel.font = appStyle.headerFontMedium
    eventCategoryLabel.text = NSLocalizedString("event", comment: "event label")
    
    eventTitleTextField.text = event?.getName()
    eventTitleTextField.delegate = self
    
    eventDescriptionTextView.text = event?.getDescription()
    eventDescriptionTextView.tag = 1
    eventDescriptionTextView.delegate = self
    
    eventLocationTextField.text = event?.getLocation()
    eventLocationTextField.tag = 2
    eventLocationTextField.delegate = self
    
    eventDateAndTimeTextField.text = event?.getDate()
    eventDateAndTimeTextField.tag = 3
    eventDateAndTimeTextField.delegate = self
    
    headerAndStackViewController.addArrangedSubviewToStackView(view: eventConfirmationTitleLabel)
    headerAndStackViewController.addArrangedSubviewToStackView(view: eventCategoryLabel)
    headerAndStackViewController.addArrangedSubviewToStackView(view: eventTitleContainer)
    headerAndStackViewController.addArrangedSubviewToStackView(view: eventDescriptionContainer)
    headerAndStackViewController.addArrangedSubviewToStackView(view: eventLocationContainer)
    headerAndStackViewController.addArrangedSubviewToStackView(view: eventDateAndTimeContainer)
    
    if let event = event {
      if event.getAttendeeCharacteristics().count > 0 {
        let attendeeCharacteristicsCategoryLabel = UILabel()
      
        attendeeCharacteristicsCategoryLabel.textAlignment = .center
        attendeeCharacteristicsCategoryLabel.numberOfLines = 0
        attendeeCharacteristicsCategoryLabel.lineBreakMode = .byWordWrapping
        attendeeCharacteristicsCategoryLabel.font = appStyle.headerFontMedium
        attendeeCharacteristicsCategoryLabel.text = NSLocalizedString("guest questionnaire", comment: "guest questionnaire placeholder")
      
        headerAndStackViewController.addArrangedSubviewToStackView(view: attendeeCharacteristicsCategoryLabel)
        let attendeeCharacteristics = event.getAttendeeCharacteristics()
        for characteristic in attendeeCharacteristics {
          let attendeeCharacteristicTextField = BaseInputTextField(hintText: "e.g. placeholder")
          let attendeeCharacteristicContainer = TitleAndContentContainer(withTitle: "characteristic \(attendeeCharacteristics.index(of: characteristic)! + 1)", andContent: attendeeCharacteristicTextField)
      
          attendeeCharacteristicTextField.text = characteristic
          //SKO - incorporate array index when have eventObject
          attendeeCharacteristicTextField.tag = attendeeCharacteristics.index(of: characteristic)! + 5
          attendeeCharacteristicTextField.delegate = self
      
          headerAndStackViewController.addArrangedSubviewToStackView(view: attendeeCharacteristicContainer)
        }
      }
    }
    
    //if eventObject.adminDescription != nil {
      let adminDescriptionCategoryLabel = UILabel()
      let adminDescriptionTextView = BaseInputTextView(hintText: NSLocalizedString("admin description input placeholder", comment: "admin description input placeholder"))
      let adminDescriptionContainer = TitleAndContentContainer(withTitle: NSLocalizedString("admin description header placeholder", comment: "admin description header placeholder"), andContent: adminDescriptionTextView)
    
      adminDescriptionCategoryLabel.textAlignment = .center
      adminDescriptionCategoryLabel.numberOfLines = 0
      adminDescriptionCategoryLabel.lineBreakMode = .byWordWrapping
      adminDescriptionCategoryLabel.font = appStyle.headerFontMedium
      adminDescriptionCategoryLabel.text = NSLocalizedString("admin description header placeholder", comment: "admin description header placeholder")
    
      adminDescriptionTextView.text = "eventObject.adminDescriptionText"
      adminDescriptionTextView.tag = 5
      adminDescriptionTextView.delegate = self
    
      headerAndStackViewController.addArrangedSubviewToStackView(view: adminDescriptionCategoryLabel)
      headerAndStackViewController.addArrangedSubviewToStackView(view: adminDescriptionContainer)
    //}
    
    let createEventButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("create event", comment: "create event button"))
    
    createEventButtonContainer.button.addTarget(self, action: #selector(didTapCreateEventButton), for: .touchUpInside)
    
    headerAndStackViewController.addArrangedSubviewToStackView(view: createEventButtonContainer)
    headerAndStackViewController.setHeaderView(view: picturePromptImageView)
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
    headerAndStackViewController.headerView.addGestureRecognizer(tapGestureRecognizer)
    
    self.view.addSubview(headerAndStackViewController)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    headerAndStackViewController.translatesAutoresizingMaskIntoConstraints = false
    
    headerAndStackViewController.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    headerAndStackViewController.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    headerAndStackViewController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    headerAndStackViewController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    
    //SKO - set this constraint for any headerAndStackViewContainer vc that is scrollable by default
    headerAndStackViewController.contentViewHeightConstraint = headerAndStackViewController.contentView.heightAnchor.constraint(equalTo: headerAndStackViewController.baseInputView.stackView.heightAnchor, constant: 80)
    headerAndStackViewController.contentViewHeightConstraint?.isActive = true
  }
  
  func didTapCreateEventButton(sender: UIButton) {
    print("tapped button")
  }
  
  func didTapHeader(sender: UITapGestureRecognizer) {
    let imagePicker = ImagePickerAlertController(frame: view.bounds, controller: self)
    imagePicker.displayAlert(imageReference: picturePromptImageView)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let nextResponder = self.view.viewWithTag(textField.tag + 1) {
      nextResponder.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return false
  }
  
  func textViewDidChange(_ textView: UITextView) {
    if let textView = textView as? BaseInputTextView {
      if textView.text == "" {
        textView.placeholderLabel.isHidden = false
      } else {
        textView.placeholderLabel.isHidden = true
      }
    }
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      if let nextResponder = self.view.viewWithTag(textView.tag + 1) {
        nextResponder.becomeFirstResponder()
      } else {
        textView.resignFirstResponder()
      }
      return false
    }
    return true
  }
}
