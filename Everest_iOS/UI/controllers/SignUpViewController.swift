//
//  SignUpViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-16.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
  var viewContainer: SignUpViewContainer
  var headerTextView: BaseInputTextView
  var extraInfoView: UIView
  var forgotPasswordButton, loginButton: BaseInputButton
  
  init(_ headerText: String? = nil, coder: NSCoder? = nil) {
    viewContainer = SignUpViewContainer()
    extraInfoView = UIView()
    forgotPasswordButton = BaseInputButton("Forgot password?")
    loginButton = BaseInputButton("Log In")
    headerTextView = BaseInputTextView(textInput: headerText)
  
    if let coder = coder {
      super.init(coder: coder)!
    } else {
      super.init()
    }
  }

  required convenience init(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerTextView.isEditable = false
    headerTextView.backgroundColor = nil
    headerTextView.removeBorder()
    headerTextView.textColor = UIColor(netHex: 0x1a1a1a)
    headerTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
    
    let emailTextField = BaseInputTextField("Email Address")
    emailTextField.backgroundColor = UIColor(netHex: 0xffffff)
    emailTextField.removeBorder()
    
    let passwordTextField = BaseInputTextField("Password")
    passwordTextField.isSecureTextEntry = true
    passwordTextField.backgroundColor = UIColor(netHex: 0xffffff)
    passwordTextField.removeBorder()
    
    let confirmPasswordTextField = BaseInputTextField("Confirm Password")
    confirmPasswordTextField.isSecureTextEntry = true
    confirmPasswordTextField.backgroundColor = UIColor(netHex: 0xffffff)
    confirmPasswordTextField.removeBorder()

    let signupButton = BaseInputButton("Sign up")
    
    //SKU - This is a temporary fix to deal with some of the spacing issues that were brough up in the stack view. --> TODO Item
    let spacerView1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 100))
    let spacerView2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 100))
    
    forgotPasswordButton.backgroundColor = nil
    forgotPasswordButton.setTitleColor(UIColor(netHex: 0x1a1a1a),for: .normal)
    forgotPasswordButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
    
    loginButton.backgroundColor = nil
    loginButton.setTitleColor(UIColor(netHex: 0x1a1a1a),for: .normal)
    loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
    
    extraInfoView.addSubview(loginButton)
    extraInfoView.addSubview(forgotPasswordButton)
    
    viewContainer.addArrangedHeaderSubview(view: headerTextView)
    
    viewContainer.addArrangedContentSubview(view: emailTextField)
    viewContainer.addArrangedContentSubview(view: passwordTextField)
    viewContainer.addArrangedContentSubview(view: confirmPasswordTextField)
    viewContainer.addArrangedContentSubview(view: spacerView1)
    viewContainer.addArrangedContentSubview(view: spacerView2)
    viewContainer.addArrangedContentSubview(view: signupButton)
    viewContainer.addArrangedContentSubview(view: extraInfoView)
    viewContainer.contentView.spacing(value: 10)
    viewContainer.backgroundColor = UIColor(netHex: 0xe6e6e6)
    
    view.addSubview(viewContainer)
  }
  
  override func viewDidLayoutSubviews() {
    setupContstraints()
  }
  
  //SKU - Use layout anchors to set auto layout constraints
  private func setupContstraints() {
    
    viewContainer.translatesAutoresizingMaskIntoConstraints = false
    forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    headerTextView.translatesAutoresizingMaskIntoConstraints = false
    
    viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    viewContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    
    //SKU - Custom constraints that are unique to this view
    forgotPasswordButton.topAnchor.constraint(equalTo: extraInfoView.topAnchor).isActive = true
    forgotPasswordButton.leftAnchor.constraint(equalTo: viewContainer.contentView.stackView.leftAnchor).isActive = true
    forgotPasswordButton.bottomAnchor.constraint(equalTo: extraInfoView.bottomAnchor).isActive = true
    
    loginButton.topAnchor.constraint(equalTo: extraInfoView.topAnchor).isActive = true
    loginButton.rightAnchor.constraint(equalTo: viewContainer.contentView.stackView.rightAnchor).isActive = true
    loginButton.bottomAnchor.constraint(equalTo: extraInfoView.bottomAnchor).isActive = true
    
    headerTextView.widthAnchor.constraint(equalTo: viewContainer.headerView.widthAnchor).isActive = true
    headerTextView.leftAnchor.constraint(equalTo: viewContainer.contentView.stackView.leftAnchor, constant: -15).isActive = true
    headerTextView.centerYAnchor.constraint(equalTo: viewContainer.headerView.centerYAnchor).isActive = true
    headerTextView.heightAnchor.constraint(equalTo: viewContainer.headerView.heightAnchor).isActive = true

  }
}
