//
//  SignUpProfileViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-22.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class SignUpProfileViewController: UIViewController, UITextFieldDelegate {
  var viewContainer: SignUpViewContainer
  var headerTextView: BaseInputTextView
  var profileHeaderContainer: ProfileHeaderContainer
  var firstNameTextField, lastNameTextField: BaseInputTextField
  var continueButton: BaseInputButton
  
  init(_ coder: NSCoder? = nil) {

    viewContainer = SignUpViewContainer()
    viewContainer.setHeaderViewHeight(height: 100)
    headerTextView = BaseInputTextView(textInput: "Thanks for signing up!\nCompleting your profile will help people find you.")
    profileHeaderContainer = ProfileHeaderContainer(150)
    firstNameTextField = BaseInputTextField("First Name")
    lastNameTextField = BaseInputTextField("Last Name")
    continueButton = BaseInputButton("Continue")
    
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
    
    firstNameTextField.delegate = self
    lastNameTextField.delegate = self
    
    firstNameTextField.nextField = lastNameTextField
    
    headerTextView.isEditable = false
    headerTextView.backgroundColor = nil
    headerTextView.removeBorder()
    headerTextView.textColor = UIColor(netHex: 0x1a1a1a)
    headerTextView.font = UIFont(name: "HelveticaNeue-Light", size: 20)
    headerTextView.textAlignment = .center
    headerTextView.textContainerInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    
    let singleTap = UITapGestureRecognizer(target: self, action:#selector(tapDetected))
    singleTap.numberOfTapsRequired = 1
    profileHeaderContainer.pictureImageView.isUserInteractionEnabled = true
    profileHeaderContainer.pictureImageView.addGestureRecognizer(singleTap)
    profileHeaderContainer.pictureImageView.image = UIImage(named: "blank-profile-picture-take")
    profileHeaderContainer.setPictureBorder(borderColor: UIColor(netHex: 0x363636))
  
    firstNameTextField.backgroundColor = UIColor(netHex: 0xffffff)
    firstNameTextField.removeBorder()
  
    lastNameTextField.backgroundColor = UIColor(netHex: 0xffffff)
    lastNameTextField.removeBorder()
    
    let spacerView1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 100))
    let spacerView2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 100))
    
    viewContainer.addArrangedHeaderSubview(view: headerTextView)
    viewContainer.addArrangedContentSubview(view: profileHeaderContainer)
    viewContainer.addArrangedContentSubview(view: firstNameTextField)
    viewContainer.addArrangedContentSubview(view: lastNameTextField)
    viewContainer.addArrangedContentSubview(view: spacerView1)
    viewContainer.addArrangedContentSubview(view: spacerView2)
    viewContainer.addArrangedContentSubview(view: continueButton)
    
    viewContainer.contentView.spacing(value: 10)
    viewContainer.backgroundColor = UIColor(netHex: 0xe6e6e6)
    
    view.addSubview(viewContainer)
    
    hideKeyboardWhenTappedAround()
  }

  override func viewDidLayoutSubviews() {
    setupConstraints()
  }

  private func setupConstraints() {
    viewContainer.translatesAutoresizingMaskIntoConstraints = false
    headerTextView.translatesAutoresizingMaskIntoConstraints = false
    profileHeaderContainer.translatesAutoresizingMaskIntoConstraints = false
    
    viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    viewContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    
    headerTextView.widthAnchor.constraint(equalTo: viewContainer.contentView.stackView.widthAnchor).isActive = true
    headerTextView.leftAnchor.constraint(equalTo: viewContainer.contentView.stackView.leftAnchor).isActive = true
    headerTextView.heightAnchor.constraint(equalTo: viewContainer.headerView.heightAnchor).isActive = true
    headerTextView.topAnchor.constraint(equalTo: viewContainer.headerView.topAnchor, constant: 15).isActive = true

    profileHeaderContainer.heightAnchor.constraint(equalToConstant: 175).isActive = true
    
  }
  
  func tapDetected() {
    let imageLoader = ImagePickerAlertController(frame: self.view.frame, controller: self)
    imageLoader.displayAlert(imageReference: profileHeaderContainer.pictureImageView)
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if(textField.nextField == nil)
    {
      textField.resignFirstResponder()
    }
    else {
      textField.nextField?.becomeFirstResponder()
    }
    return true
  }
}
