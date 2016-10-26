//
//  SignUpViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-16.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
<<<<<<< HEAD
  var viewContainer: SignUpViewContainer
  var headerTextView: BaseInputTextView
  var extraInfoView: UIView
  var signupButton, forgotPasswordButton, loginButton: BaseInputButton
  var emailTextField, passwordTextField, confirmPasswordTextField : BaseInputTextField
  
  init(_ coder: NSCoder? = nil) {
    viewContainer = SignUpViewContainer()
    headerTextView = BaseInputTextView(textInput: "Welcome to Everest")
    extraInfoView = UIView()
    forgotPasswordButton = BaseInputButton("Forgot password?")
    loginButton = BaseInputButton("Log In")
    emailTextField = BaseInputTextField("Email Address")
    passwordTextField = BaseInputTextField("Password")
    confirmPasswordTextField = BaseInputTextField("Confirm Password")
    signupButton = BaseInputButton("Sign up")
    
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

    emailTextField.delegate = self
    passwordTextField.delegate = self
    confirmPasswordTextField.delegate = self
    
    self.emailTextField.nextField = self.passwordTextField
    self.passwordTextField.nextField = self.confirmPasswordTextField
    
    headerTextView.isEditable = false
    headerTextView.backgroundColor = nil
    headerTextView.removeBorder()
    headerTextView.textColor = UIColor(netHex: 0x1a1a1a)
    headerTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
    
    emailTextField.backgroundColor = UIColor(netHex: 0xffffff)
    emailTextField.removeBorder()
    
    passwordTextField.isSecureTextEntry = true
    passwordTextField.backgroundColor = UIColor(netHex: 0xffffff)
    passwordTextField.removeBorder()
    
    confirmPasswordTextField.isSecureTextEntry = true
    confirmPasswordTextField.backgroundColor = UIColor(netHex: 0xffffff)
    confirmPasswordTextField.removeBorder()

    
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
    
    hideKeyboardWhenTappedAround()
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
=======
    var viewContainer: SignUpViewContainer
    var headerTextView: BaseInputTextView
    var emailTextField, passwordTextField, confirmPasswordTextField: BaseInputTextField
    var signupButtonContainer: BaseInputButtonContainer
    var extraInfoView: UIView
    var forgotPasswordButton, loginButton: UIButton

    //  init(_ headerText: String? = nil, coder: NSCoder? = nil) {
    init(_ coder: NSCoder? = nil) {
        viewContainer = SignUpViewContainer()
        extraInfoView = UIView()
        signupButtonContainer = BaseInputButtonContainer("Sign up")
        forgotPasswordButton = UIButton()
        loginButton = UIButton()
        headerTextView = BaseInputTextView(textInput: "Welcome to Everest")
        emailTextField = BaseInputTextField("Email Address")
        passwordTextField = BaseInputTextField("Password")
        confirmPasswordTextField = BaseInputTextField("Confirm Password")

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

        headerTextView.isEditable = false
        headerTextView.backgroundColor = nil
        headerTextView.removeBorder()
        headerTextView.textColor = AppStyle.sharedInstance.textColor
        headerTextView.font = AppStyle.sharedInstance.headerFontLarge
        
        emailTextField.removeBorder()
        passwordTextField.removeBorder()
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.removeBorder()

        forgotPasswordButton.setTitleColor(AppStyle.sharedInstance.textColor, for: .normal)
        forgotPasswordButton.titleLabel?.font = AppStyle.sharedInstance.textFontBold

        loginButton.setTitleColor(AppStyle.sharedInstance.textColor, for: .normal)
        loginButton.titleLabel?.font = AppStyle.sharedInstance.textFontBold

        extraInfoView.addSubview(loginButton)
        extraInfoView.addSubview(forgotPasswordButton)

        viewContainer.addArrangedHeaderSubview(view: headerTextView)
        viewContainer.addArrangedContentSubview(view: emailTextField)
        viewContainer.addArrangedContentSubview(view: passwordTextField)
        viewContainer.addArrangedContentSubview(view: confirmPasswordTextField)
        viewContainer.addArrangedContentSubview(view: signupButtonContainer)
        viewContainer.addArrangedContentSubview(view: extraInfoView)
        
        viewContainer.contentView.spacing(value: 10)
        viewContainer.backgroundColor = AppStyle.sharedInstance.backgroundColor

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
>>>>>>> make refactoring changes plus implement imagePicker in create event view
}
