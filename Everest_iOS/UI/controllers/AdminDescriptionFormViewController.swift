//
//  AdminDescriptionFormViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class AdminDescriptionFormViewController: UIViewController, UITextViewDelegate {
  private let headerAndStackViewContainer = HeaderAndStackViewContainer(withNavigationBar: true)
  private let adminDescriptionTextView = BaseInputTextView(hintText: NSLocalizedString("admin description input placeholder", comment: "admin description input placeholder"))
  private let picturePromptImageView = UIImageView(image: AppStyle.sharedInstance.pictureImageWide)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appStyle = AppStyle.sharedInstance
    
    let adminDescriptionHeaderLabel = UILabel()
    let adminDescriptionInfoLabel = UILabel()
    let createEventButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("confirm event", comment: "confirm event button"))
    
    adminDescriptionHeaderLabel.text = NSLocalizedString("admin description header placeholder", comment: "admin description header placeholder")
    adminDescriptionHeaderLabel.textAlignment = .center
    adminDescriptionHeaderLabel.numberOfLines = 0
    adminDescriptionHeaderLabel.lineBreakMode = .byWordWrapping
    adminDescriptionHeaderLabel.font = appStyle.headerFontMedium
    
    adminDescriptionInfoLabel.text = NSLocalizedString("admin description info placeholder", comment: "admin description info placeholder")
    adminDescriptionInfoLabel.textAlignment = .center
    adminDescriptionInfoLabel.numberOfLines = 0
    adminDescriptionInfoLabel.lineBreakMode = .byWordWrapping
    adminDescriptionInfoLabel.font = appStyle.headerFontMedium
    
    adminDescriptionTextView.delegate = self
    headerAndStackViewContainer.baseInputView.baseInputTextViewHeightConstraintConstant = 150
    
    createEventButtonContainer.button.addTarget(self, action: #selector(didTapCreateEventButton), for: .touchUpInside)
    
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: adminDescriptionHeaderLabel)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: adminDescriptionInfoLabel)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: adminDescriptionTextView)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: createEventButtonContainer)
    
    let headerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
    
    headerAndStackViewContainer.headerView.addGestureRecognizer(headerTapGestureRecognizer)
    headerAndStackViewContainer.setHeaderView(view: picturePromptImageView)
    headerAndStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(headerAndStackViewContainer)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    headerAndStackViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    headerAndStackViewContainer.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
    headerAndStackViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    headerAndStackViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }
  
  func didTapCreateEventButton(sender: UIButton) {
    print("button clicked")
  }
  
  func didTapHeader(sender: UITapGestureRecognizer) {
    let imagePicker = ImagePickerAlertController(frame: view.bounds, controller: self)
    imagePicker.displayAlert(imageReference: picturePromptImageView)
  }
  
  //SKO - Emulate placeholder text functionality
  func textViewDidChange(_ textView: UITextView) {
    if textView.text == "" {
      adminDescriptionTextView.placeholderLabel.isHidden = false
    } else {
      adminDescriptionTextView.placeholderLabel.isHidden = true
    }
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    //SKO - If click 'return' key on keyboard
    if text == "\n" {
      self.view.endEditing(true)
      return false
    }
    return true
  }
}
