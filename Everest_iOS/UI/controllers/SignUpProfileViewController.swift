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
    var firstNameTextField, lastNameTextField: BaseInputTextField
    var continueButtonContainer: BaseInputButtonContainer
    var profileHeaderContainer: ProfileHeaderContainer?

    init(_ coder: NSCoder? = nil) {
        viewContainer = SignUpViewContainer()
        viewContainer.setHeaderViewHeight(height: 100)
        headerTextView = BaseInputTextView(textInput: NSLocalizedString("sign up profile header", comment: "sign up profile header"))
        firstNameTextField = BaseInputTextField(hintText: NSLocalizedString("first name", comment: "first name placeholder"))
        lastNameTextField = BaseInputTextField(hintText: NSLocalizedString("last name", comment: "last name placeholder"))
        continueButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("continue", comment: "continue button"))

        if let coder = coder {
          super.init(coder: coder)!
        } else {
          super.init()
        }
        
        profileHeaderContainer = ProfileHeaderContainer(150, controller: self)
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
        headerTextView.font = AppStyle.sharedInstance.headerFontMedium
        headerTextView.textAlignment = .center
        headerTextView.textContainerInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)

        firstNameTextField.removeBorder()
        lastNameTextField.removeBorder()

        continueButtonContainer.button.setTitle("Continue", for: .normal)

        viewContainer.addArrangedHeaderSubview(view: headerTextView)
        viewContainer.addArrangedContentSubview(view: profileHeaderContainer!)
        viewContainer.addArrangedContentSubview(view: firstNameTextField)
        viewContainer.addArrangedContentSubview(view: lastNameTextField)
        viewContainer.addArrangedContentSubview(view: continueButtonContainer)

        viewContainer.contentView.spacing(value: 10)
        viewContainer.backgroundColor = AppStyle.sharedInstance.backgroundColor

        view.addSubview(viewContainer)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
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
}
