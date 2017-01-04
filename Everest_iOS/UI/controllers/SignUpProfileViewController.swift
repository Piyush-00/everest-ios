//
//  SignUpProfileViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-22.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class SignUpProfileViewController: UIViewController, UITextFieldDelegate {
    var viewContainer = SignUpViewContainer()
    var headerTextView = BaseInputTextView(textInput: NSLocalizedString("sign up profile header", comment: "sign up profile header"))
    var firstNameTextField = BaseInputTextField(hintText: NSLocalizedString("first name", comment: "first name placeholder"))
    var lastNameTextField = BaseInputTextField(hintText: NSLocalizedString("last name", comment: "last name placeholder"))
    var continueButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("continue", comment: "continue button"))
    var profileHeaderContainer: ProfileHeaderContainer?
    var user: User?
    var initialFlowViewController:  UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        viewContainer.navigationBarView.isHidden = true
      
        viewContainer.setHeaderViewHeight(height: 100)
        profileHeaderContainer = ProfileHeaderContainer(150, controller: self)
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
      
        firstNameTextField.nextField = lastNameTextField
      
        headerTextView.isEditable = false
        headerTextView.backgroundColor = nil
        headerTextView.removeBorder()
        headerTextView.textColor = AppStyle.sharedInstance.textColor
        headerTextView.font = AppStyle.sharedInstance.headerFontMedium
        headerTextView.textAlignment = .center
        headerTextView.textContainerInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)

        firstNameTextField.removeBorder()
        lastNameTextField.removeBorder()

        continueButtonContainer.button.setTitle("Continue", for: .normal)
        continueButtonContainer.button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)

        viewContainer.addArrangedHeaderSubview(view: headerTextView)
        viewContainer.addArrangedContentSubview(view: profileHeaderContainer!)
        viewContainer.addArrangedContentSubview(view: firstNameTextField)
        viewContainer.addArrangedContentSubview(view: lastNameTextField)
        viewContainer.addArrangedContentSubview(view: continueButtonContainer)

        viewContainer.contentView.spacing(value: 10)
        viewContainer.backgroundColor = AppStyle.sharedInstance.backgroundColor

        view.addSubview(viewContainer)
        
        //SKO - disable being able to swipe back to sign up part 1 view
        if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
  
    func didTapContinueButton(sender: UIButton) {
      
      user?.signUpProfile(image: profileHeaderContainer?.pictureImageView.image, firstName: firstNameTextField.text, lastName: lastNameTextField.text) {
        response in
        switch response{
          case true:
            print(self.user?.getProfileImageURL())
            //SKU - Pop back to the original view that the user came into the sign up flow from
            if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
              if (self.initialFlowViewController != nil){
              navigationController.popToViewController(self.initialFlowViewController!, animated: true)
              } else {
              
                //SKU - If an initial flow is not specified, pop into the landing page.
                let landingViewController = LandingViewController()
                //SKU - TODO : Change landign page text based on gathered user info
                navigationController.pushViewController(landingViewController, withAnimation: .fromBottom)
              }}
  
          case false:
          print("error has occurred")
          }
      }

    }
  
    private func setupConstraints() {
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        headerTextView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderContainer?.translatesAutoresizingMaskIntoConstraints = false

        viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        headerTextView.widthAnchor.constraint(equalTo: viewContainer.contentView.stackView.widthAnchor).isActive = true
        headerTextView.leftAnchor.constraint(equalTo: viewContainer.contentView.stackView.leftAnchor).isActive = true
        headerTextView.heightAnchor.constraint(equalTo: viewContainer.headerView.heightAnchor).isActive = true
        headerTextView.topAnchor.constraint(equalTo: viewContainer.headerView.topAnchor, constant: 15).isActive = true

        profileHeaderContainer?.heightAnchor.constraint(equalToConstant: 175).isActive = true
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
