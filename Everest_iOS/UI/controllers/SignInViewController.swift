//
//  SignInViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-05.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
  private let viewContainer = SignUpViewContainer()
  private let headerLabel = UILabel()
  private let forgotPasswordButton = UIButton()
  private let extraInfoView = UIView()
  private var emailTextField, passwordTextField : BaseInputTextField?
  var user = User()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround()
    
    let appStyle = AppStyle.sharedInstance
    
    emailTextField = BaseInputTextField(hintText: NSLocalizedString("email address", comment: "email address placeholder"))
    passwordTextField = BaseInputTextField(hintText: NSLocalizedString("password", comment: "password placeholder"))
    let signInButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("sign in", comment: "sign in button"))
    
    headerLabel.text = NSLocalizedString("sign in/up welcome header", comment: "sign in/up welcome header")
    headerLabel.textColor = appStyle.textColor
    headerLabel.font = appStyle.headerFontLargeBold
    headerLabel.numberOfLines = 0
    headerLabel.lineBreakMode = .byWordWrapping
    
    emailTextField?.delegate = self
    emailTextField?.nextField = passwordTextField
    
    passwordTextField?.delegate = self
    passwordTextField?.isSecureTextEntry = true
    
    signInButtonContainer.button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
    
    forgotPasswordButton.setTitle(NSLocalizedString("forgot password", comment: "forgot password button"), for: .normal)
    forgotPasswordButton.setTitleColor(appStyle.textColor, for: .normal)
    forgotPasswordButton.titleLabel?.font = appStyle.textFontBold
    forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
    
    extraInfoView.addSubview(forgotPasswordButton)
    
    viewContainer.addArrangedHeaderSubview(view: headerLabel)
    viewContainer.addArrangedContentSubview(view: emailTextField!)
    viewContainer.addArrangedContentSubview(view: passwordTextField!)
    viewContainer.addArrangedContentSubview(view: signInButtonContainer)
    viewContainer.addArrangedContentSubview(view: extraInfoView)
    viewContainer.backgroundColor = appStyle.backgroundColor
    viewContainer.contentView.spacing(value: 10)
    
    self.view.addSubview(viewContainer)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    viewContainer.translatesAutoresizingMaskIntoConstraints = false
    forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
    headerLabel.translatesAutoresizingMaskIntoConstraints = false
    
    viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    viewContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    
    forgotPasswordButton.topAnchor.constraint(equalTo: extraInfoView.topAnchor).isActive = true
    forgotPasswordButton.bottomAnchor.constraint(equalTo: extraInfoView.bottomAnchor).isActive = true
    forgotPasswordButton.leadingAnchor.constraint(equalTo: viewContainer.contentView.stackView.leadingAnchor).isActive = true
    
    headerLabel.topAnchor.constraint(equalTo: viewContainer.headerView.topAnchor).isActive = true
    headerLabel.bottomAnchor.constraint(equalTo: viewContainer.headerView.bottomAnchor).isActive = true
    headerLabel.leadingAnchor.constraint(equalTo: viewContainer.headerView.leadingAnchor, constant: 26).isActive = true
    headerLabel.trailingAnchor.constraint(equalTo: viewContainer.headerView.trailingAnchor).isActive = true
  }
  
  func didTapSignInButton(sender: UIButton) {
    user.signIn(email: (emailTextField?.text!)!, password: (passwordTextField?.text!)!) { response in
      switch response{
      case true:
        if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
          let landingViewController = LandingViewController()
          navigationController.pushViewController(landingViewController, animated: true)
        }
        
      case false:
        print("error has occurred")
      }
    }
  }
  
  func didTapForgotPasswordButton(sender: UIButton) {
    print("forgot password button pressed")
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if(textField.nextField == nil) {
      textField.resignFirstResponder()
    } else {
      textField.nextField?.becomeFirstResponder()
    }
    return true
  }
}
