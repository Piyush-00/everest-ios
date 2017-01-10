//
//  AttendeeJoinEventViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2017-01-05.
//  Copyright © 2017 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

class AttendeeJoinEventViewController: UIViewController, ChatMessageInputContainerProtocol {
  
  private let headerAndStackView = HeaderAndStackViewContainer(withNavigationBar: true)
  private let headerImageView: UIImageView = UIImageView()
  private let attendeeDescriptionHeaderLabel = UILabel()
  private let tagInputView = ChatMessageInputContainer()
  private var tap = UITapGestureRecognizer()
  
  var test = TagFlowController()
  
  private var bottomConstraint: NSLayoutConstraint?
  
  //SKU - Properties
  var headerViewHeight: CGFloat = 100
  var addButtonIconSize: CGFloat = 25
  let tags = ["Tech", "Designrdafd", "Humor", "Travel", "Music", "Writing"]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerAndStackView.setHeaderViewHeight(headerViewHeight)
    headerAndStackView.setHeaderView(view: headerImageView)
    
    headerAndStackView.addArrangedSubviewToStackView(view: attendeeDescriptionHeaderLabel)
    
    self.view.addSubview(headerAndStackView)
    self.view.addSubview(tagInputView)
    
    tagInputView.delegate = self
    

    
    NotificationCenter.default.addObserver(self, selector: #selector(KeyboardDidActivate), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(KeyboardDidActivate), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    setupComponents()
    setupConstraints()
    tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    
    
    setupCharacteristics()
    setupCharacteristics()

    
    
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
    attendeeDescriptionHeaderLabel.text = "Answer these few questions about your self before you join"
    attendeeDescriptionHeaderLabel.numberOfLines = 0
    attendeeDescriptionHeaderLabel.lineBreakMode = .byWordWrapping
    attendeeDescriptionHeaderLabel.textAlignment = .center
    attendeeDescriptionHeaderLabel.font = AppStyle.sharedInstance.headerFontMedium
    
    tagInputView.setButtonTitle(tittle: "Add")
  }
  
  private func setupCharacteristics() {
   
    let wrapperView = UIView()
    let characteristicHeaderLabel = UILabel()
    let addTagButton = UIButton()
    
    wrapperView.addSubview(characteristicHeaderLabel)
    wrapperView.addSubview(addTagButton)
    headerAndStackView.addArrangedSubviewToStackView(view: wrapperView)
    
    wrapperView.translatesAutoresizingMaskIntoConstraints = false
    wrapperView.bottomAnchor.constraint(equalTo: characteristicHeaderLabel.bottomAnchor).isActive = true
    
    
    characteristicHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
    characteristicHeaderLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
    characteristicHeaderLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
    characteristicHeaderLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -30).isActive = true
    characteristicHeaderLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
    
    characteristicHeaderLabel.text = "Interests"
    characteristicHeaderLabel.numberOfLines = 0
    characteristicHeaderLabel.lineBreakMode = .byWordWrapping
    
    addTagButton.titleLabel?.font = UIFont.fontAwesome(ofSize: addButtonIconSize)
    addTagButton.setTitle(String.fontAwesomeIcon(name: .plus), for: .normal)
    addTagButton.setTitleColor(UIColor.black, for: .normal)
    addTagButton.titleLabel?.numberOfLines = 1
    addTagButton.titleLabel?.adjustsFontSizeToFitWidth = true
    addTagButton.titleLabel?.lineBreakMode = .byClipping
    
    addTagButton.translatesAutoresizingMaskIntoConstraints = false
    addTagButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true
    addTagButton.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
    addTagButton.widthAnchor.constraint(equalToConstant: addButtonIconSize).isActive = true
    addTagButton.heightAnchor.constraint(equalToConstant: addButtonIconSize).isActive = true
    
    addTagButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    
    test = TagFlowController()
    test.canRemoveCell = true
    test.setBackgroundColor(AppStyle.sharedInstance.backgroundColor)
    test.loadData(inputValues: (tags))
    
    addChildViewController(test)
    
    
    headerAndStackView.addArrangedSubviewToStackView(view: test.view)
    
    test.view.heightAnchor.constraint(equalToConstant: 80).isActive = true
    
  }
  
  func didTapAddButton() {
    tagInputView.textInputView.becomeFirstResponder()
    
  }
  
  func KeyboardDidActivate(notification: NSNotification) {
    
    if (notification.name == NSNotification.Name.UIKeyboardWillShow) {
      if let userAgent = notification.userInfo {
        let keyboardFrame = (userAgent[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        bottomConstraint?.constant = -(keyboardFrame?.height)!
        addKeyboardDismissListener()
      }
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
    test.addNewTag(inputText: inputText)
  }
  
  func addKeyboardDismissListener() {
    view.addGestureRecognizer(tap)
  }
  
  func removeKeyboardDismissListener() {
    view.removeGestureRecognizer(tap)
  }
  
}
