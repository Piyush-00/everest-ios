//
//  AttendeeJoinEventViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2017-01-05.
//  Copyright © 2017 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

class AttendeeJoinEventViewController: UIViewController, ChatMessageInputContainerProtocol, TagInputControllerProtocol, UITextFieldDelegate {
  
  private let headerAndStackView = HeaderAndStackViewContainer(withNavigationBar: true)
  private let headerImageView: UIImageView = UIImageView()
  private let attendeeDescriptionHeaderLabel = UILabel()
  private let tagInputView = ChatMessageInputContainer()
  private let continueButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("continue", comment: "continue"))
  private var tap = UITapGestureRecognizer()
  private var attendeeDescriptionField = BaseInputTextField(hintText: NSLocalizedString("about", comment: "Description"))
  
  private var tagFlowControllerReference = TagFlowController()
  private var bottomConstraint: NSLayoutConstraint?
  
  //SKU - Properties
  private var isAddingProperty: Bool = false
  private var headerViewHeight: CGFloat = 100
  private var addButtonIconSize: CGFloat = 25
  let tags: [String] = ["Interests","Work Experiences"]

  override func viewDidLoad() {
    super.viewDidLoad()

    headerImageView.downloadedFrom(link: t("/public/uploads/file-1484330162931.png"))
    headerImageView.clipsToBounds = true
    headerImageView.contentMode = .scaleAspectFill
    headerImageView.layer.masksToBounds = true
    
    headerAndStackView.setHeaderViewHeight(headerViewHeight)
    headerAndStackView.setHeaderView(view: headerImageView)
    
    headerAndStackView.addArrangedSubviewToStackView(view: attendeeDescriptionHeaderLabel)
    
    self.view.addSubview(headerAndStackView)
    self.view.addSubview(tagInputView)
    
    tagInputView.delegate = self
    attendeeDescriptionField.delegate = self

    NotificationCenter.default.addObserver(self, selector: #selector(KeyboardDidActivate), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(KeyboardDidActivate), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    
    setupComponents()
    setupConstraints()
    
    continueButtonContainer.button.addTarget(self, action: #selector(onTapContinueButton(sender:)), for: .touchUpInside)
    continueButtonContainer.button.isEnabled = false
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    for i in 0...((tags.count)-1) {
      setupCharacteristics(title: tags[i])
    }
    headerAndStackView.addArrangedSubviewToStackView(view: continueButtonContainer)
  }

  
  private func setupConstraints() {
    headerAndStackView.translatesAutoresizingMaskIntoConstraints = false
    headerAndStackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    headerAndStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    headerAndStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    headerAndStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
    tagInputView.translatesAutoresizingMaskIntoConstraints = false
    tagInputView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    tagInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tagInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    bottomConstraint = NSLayoutConstraint(item: tagInputView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 60)
    view.addConstraint(bottomConstraint!)
  }
  
  private func setupComponents() {
    attendeeDescriptionHeaderLabel.text = NSLocalizedString("attendee join event characteristic", comment: "attendee join event characteristic message")
    attendeeDescriptionHeaderLabel.numberOfLines = 0
    attendeeDescriptionHeaderLabel.lineBreakMode = .byWordWrapping
    attendeeDescriptionHeaderLabel.textAlignment = .center
    attendeeDescriptionHeaderLabel.font = AppStyle.sharedInstance.headerFontMedium
    
    tagInputView.setButtonTitle(tittle: NSLocalizedString("add", comment: "add"))

    var headerTextLabel = UILabel()
    headerTextLabel.text = NSLocalizedString("attendee description", comment: "attendee description message")
    headerTextLabel.font = AppStyle.sharedInstance.textFontMedium
    headerTextLabel.translatesAutoresizingMaskIntoConstraints = false
    headerTextLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    headerAndStackView.addArrangedSubviewToStackView(view: headerTextLabel)
    headerAndStackView.addArrangedSubviewToStackView(view: attendeeDescriptionField)
  }
  
  private func setupCharacteristics(title: String) {
    var tagInputViewController = TagInputController()
    tagInputViewController.delegate = self
    tagInputViewController.setTitle(title: title)
    addChildViewController(tagInputViewController)
    headerAndStackView.addArrangedSubviewToStackView(view: tagInputViewController.view)
  }
  
  func KeyboardDidActivate(notification: NSNotification) {
    if (notification.name == NSNotification.Name.UIKeyboardWillShow) {
      if (isAddingProperty) {
        if let userAgent = notification.userInfo {
          let keyboardFrame = (userAgent[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
          bottomConstraint?.constant = -(keyboardFrame?.height)!
          isAddingProperty = false
        }
      }
      addKeyboardDismissListener()
    } else if (notification.name == NSNotification.Name.UIKeyboardWillHide) {
      bottomConstraint?.constant = 60
      removeKeyboardDismissListener()
    }
    
    UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
      self.view.superview?.layoutIfNeeded()
      }, completion: {
        response in
    })
  }
  
  func didTapSendButton(inputText: String) {
    tagFlowControllerReference.addNewTag(inputText: inputText)
  }
  
  func addKeyboardDismissListener() {
    view.addGestureRecognizer(tap)
  }
  
  func removeKeyboardDismissListener() {
    view.removeGestureRecognizer(tap)
  }
  
  func onTapContinueButton(sender: UIButton){
    print("hi")
  }
  
  //MARK: TagInputControllerProtocol
  func didTapAddButton(tagController: TagFlowController) {
    isAddingProperty = true
    tagFlowControllerReference = tagController
    tagInputView.textInputView.becomeFirstResponder()
  }
  
  //MARK: UITextFieldDelegate
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == attendeeDescriptionField {
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
  
  //MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if(textField.nextField == nil){
      textField.resignFirstResponder()
    }
    else {
      textField.nextField?.becomeFirstResponder()
    }
    return true
  }
}
