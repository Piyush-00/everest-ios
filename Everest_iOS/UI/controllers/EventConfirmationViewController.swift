//
//  EventConfirmationViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-05.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventConfirmationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, ImagePickerAlertProtocol {
  private let headerAndStackViewController = HeaderAndStackViewContainer(withNavigationBar: true)
  private let headerImageView: UIImageView = UIImageView()
  private let eventTitleTextField = BaseInputTextField(hintText: NSLocalizedString("title", comment: "title placeholder"))
  private let eventDescriptionTextView = BaseInputTextView(hintText: NSLocalizedString("about", comment: "about placeholder"))
  private let eventLocationTextField = BaseInputTextField(hintText: NSLocalizedString("location", comment: "location placeholder"))
  private let eventDateAndTimeTextField = BaseInputTextField(hintText: NSLocalizedString("date and time", comment: "date and time placeholder"))
  private var attendeeCharacteristicsTextFields: [BaseInputTextField] = []
  
  var event: Event?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround()
    
    let appStyle = AppStyle.sharedInstance
    
    let headerImage = event?.getHeaderImage() ?? appStyle.pictureImageWide
    headerImageView.image = headerImage
    
    let eventConfirmationTitleLabel = UILabel()
    
    let eventCategoryLabel = UILabel()
    
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
    
    headerImageView.clipsToBounds = true
    headerImageView.contentMode = .scaleAspectFill
    headerImageView.layer.masksToBounds = true
    
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
      if let attendeeCharacteristics = event.getAttendeeCharacteristics() {
        if attendeeCharacteristics.count > 0 {
          let attendeeCharacteristicsCategoryLabel = UILabel()
          
          attendeeCharacteristicsCategoryLabel.textAlignment = .center
          attendeeCharacteristicsCategoryLabel.numberOfLines = 0
          attendeeCharacteristicsCategoryLabel.lineBreakMode = .byWordWrapping
          attendeeCharacteristicsCategoryLabel.font = appStyle.headerFontMedium
          attendeeCharacteristicsCategoryLabel.text = NSLocalizedString("guest questionnaire", comment: "guest questionnaire placeholder")
          
          headerAndStackViewController.addArrangedSubviewToStackView(view: attendeeCharacteristicsCategoryLabel)
          
          for characteristic in attendeeCharacteristics {
            let attendeeCharacteristicTextField = BaseInputTextField(hintText: "e.g. placeholder")
            let attendeeCharacteristicContainer = TitleAndContentContainer(withTitle: "characteristic \(attendeeCharacteristics.index(of: characteristic)! + 1)", andContent: attendeeCharacteristicTextField)
            
            attendeeCharacteristicTextField.text = characteristic
            //SKO - incorporate array index when have eventObject
            attendeeCharacteristicTextField.tag = attendeeCharacteristics.index(of: characteristic)! + 5
            attendeeCharacteristicTextField.delegate = self
            
            headerAndStackViewController.addArrangedSubviewToStackView(view: attendeeCharacteristicContainer)
            
            attendeeCharacteristicsTextFields.append(attendeeCharacteristicTextField)
          }
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
    
      adminDescriptionTextView.tag = 5
      adminDescriptionTextView.delegate = self
    
      headerAndStackViewController.addArrangedSubviewToStackView(view: adminDescriptionCategoryLabel)
      headerAndStackViewController.addArrangedSubviewToStackView(view: adminDescriptionContainer)
    //}
    
    let createEventButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("create event", comment: "create event button"))
    
    createEventButtonContainer.button.addTarget(self, action: #selector(didTapCreateEventButton), for: .touchUpInside)
    
    headerAndStackViewController.addArrangedSubviewToStackView(view: createEventButtonContainer)
    headerAndStackViewController.setHeaderView(view: headerImageView)
    
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

    let userID = (event?.isUserSignedIn())!
    if (userID == "") {
      //SKU - If there is no userID, Tell user to sign up.
      
      if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
        let signupViewController = SignUpViewController()
        signupViewController.initialFlowViewController = self
        navigationController.pushViewController(signupViewController, withAnimation: .fromBottom)
      }
    } else {
      //SKU - If there is a userID, Send the post request to create event.
      event?.createEvent() {
        response in
        switch response {
        case true:
          if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let eventNavigationController = EventNavigationViewController(nibName: nil, bundle: nil)
            let eventContainerViewController = EventContainerViewController()
            
            Keychain.set(key: Keys.sharedInstance.EventID, token: self.event!.getId()! as NSString)
            
            eventNavigationController.viewControllers = [eventContainerViewController]
            appDelegate.navigationController = nil
            appDelegate.window?.rootViewController = eventNavigationController
          }
          break
        case false:
          print("error has occurred")
        }
        
      }
    }
  
  }
  
  func didTapHeader(sender: UITapGestureRecognizer) {
    let imagePicker = ImagePickerAlertController(frame: view.bounds, controller: self)
    imagePicker.delegate = self
    imagePicker.displayAlert()
  }
  
  //MARK: UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let nextResponder = self.view.viewWithTag(textField.tag + 1) {
      nextResponder.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return false
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if let text = textField.text, let event = event {
      switch textField {
      case eventTitleTextField:
        event.setName(name: text)
        break
      case eventLocationTextField:
        event.setLocation(location: text)
        break
      case eventDateAndTimeTextField:
        event.setDate(date: text)
        break
      default:
        if var attendeeCharacteristics = event.getAttendeeCharacteristics() {
          for attendeeCharacteristicTextField in attendeeCharacteristicsTextFields {
            let index = attendeeCharacteristicsTextFields.index(of: attendeeCharacteristicTextField)
            if let text = attendeeCharacteristicTextField.text {
              if text != attendeeCharacteristics[index!] {
                attendeeCharacteristics[index!] = text
              }
            }
          }
          if attendeeCharacteristics != event.getAttendeeCharacteristics()! {
            event.setAttendeeCharacteristics(attendeeCharacteristics: attendeeCharacteristics)
          }
        }
        break
      }
    }
    return true
  }
  
  //MARK: UITextViewDelegate
  
  func textViewDidChange(_ textView: UITextView) {
    if let textView = textView as? BaseInputTextView {
      if textView.text == "" {
        textView.placeholderLabel.isHidden = false
      } else {
        textView.placeholderLabel.isHidden = true
      }
    }
  }
  
  func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    switch textView {
    case eventDescriptionTextView:
      event?.setDescription(description: textView.text)
      break
    default:
      break
    }
    return true
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
  
  //MARK: ImagePickerAlertProtocol
  
  func didPickImage(image: UIImage) {
    headerImageView.image = image
    event?.setHeaderImage(image: image)
  }
}
