//
//  SignUpViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-16.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    var viewContainer = SignUpViewContainer()
    var headerTextView = BaseInputTextView(textInput: nil)
    var emailTextField = BaseInputTextField(hintText: NSLocalizedString("email address", comment: "email address placeholder"))
    var passwordTextField = BaseInputTextField(hintText: NSLocalizedString("password", comment: "password placeholder"))
    var confirmPasswordTextField = BaseInputTextField(hintText: NSLocalizedString("confirm password", comment: "confirm password placeholder"))
    var signupButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("sign up", comment: "sign up button"))
    var extraInfoView = UIView()
    var forgotPasswordButton = UIButton()
    var loginButton = UIButton()
    let user = User()
    var initialFlowViewController:  UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
      
        emailTextField.nextField = self.passwordTextField
        passwordTextField.nextField = self.confirmPasswordTextField

        headerTextView.isEditable = false
        headerTextView.backgroundColor = nil
        headerTextView.removeBorder()
        headerTextView.textColor = AppStyle.sharedInstance.textColor
        headerTextView.font = AppStyle.sharedInstance.headerFontLargeBold
        
        emailTextField.removeBorder()
        passwordTextField.removeBorder()
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.removeBorder()
        
        forgotPasswordButton.setTitle(NSLocalizedString("forgot password", comment: "forgot password button"), for: .normal)
        forgotPasswordButton.setTitleColor(AppStyle.sharedInstance.textColor, for: .normal)
        forgotPasswordButton.titleLabel?.font = AppStyle.sharedInstance.textFontBold
        
        loginButton.setTitle(NSLocalizedString("log in", comment: "login button"), for: .normal)
        loginButton.setTitleColor(AppStyle.sharedInstance.textColor, for: .normal)
        loginButton.titleLabel?.font = AppStyle.sharedInstance.textFontBold
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)


        signupButtonContainer.button.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        
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
        
        if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
  
  override func viewDidAppear(_ animated: Bool) {
    if initialFlowViewController is EventConfirmationViewController {
      headerTextView.text = NSLocalizedString("sign in/up create event", comment: "sign in/up create event")
      headerTextView.font = AppStyle.sharedInstance.headerFontLargeRegular
    } else {
      headerTextView.text = NSLocalizedString("sign in/up welcome header", comment: "sign in/up welcome header")
    }
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
    
    func didTapSignupButton(sender: UIButton) {
    
      user.signUp(email: emailTextField.text!, password: passwordTextField.text!) { response in
        switch response{
        case true:
          
          Session.manager.user? = self.user
          //SKU - Update the session information
          Session.manager.checkState()
          if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
           let signUpProfileViewController = SignUpProfileViewController()
           signUpProfileViewController.user = self.user
           signUpProfileViewController.initialFlowViewController = self.initialFlowViewController
           navigationController.pushViewController(signUpProfileViewController, animated: true)
          }
        case false:
        print("error has occurred")
        }
      }
    }
  
  func didTapLoginButton(sender: UIButton) {
    if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
      let signInViewController = SignInViewController()
      //SKU - If there is an initial view controller, let signInViewController know about it.
      signInViewController.initialFlowViewController = self.initialFlowViewController
      navigationController.pushViewController(signInViewController, withAnimation: .fromBottom)
    }
  }
  
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
