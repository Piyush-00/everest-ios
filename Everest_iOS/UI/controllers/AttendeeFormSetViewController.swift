//
//  AttendeeFormSetViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-02.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class AttendeeFormSetViewController: UIViewController, UITextFieldDelegate {
  private let headerAndStackViewContainer = HeaderAndStackViewContainer(withNavigationBar: true)
  private let addFieldButton = UIButton()
  private let removeFieldButton = UIButton()
  private let fieldButtonsContainer = UIView()
  private let continueButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("continue", comment: "continue button"))
  //SKO - treat as a stack
  private var placeholderTextArray = [NSLocalizedString("instruments placeholder", comment: "instruments placeholder"), NSLocalizedString("volunteer experience placeholder", comment: "volunteer experience placeholder"), NSLocalizedString("hobbies placeholder", comment: "hobbies placeholder"),NSLocalizedString("favourite foods placeholder", comment: "favourite foods placeholder"), NSLocalizedString("skills placeholder", comment: "skills placeholder"), NSLocalizedString("favourite foods placeholder", comment: "favourite foods placeholder")]
  private var additionalInputTextFieldsArray: [BaseInputTextField] = []
  //SKO - TODO: extract event image from Event singleton
  private let picturePromptImageView = UIImageView(image: AppStyle.sharedInstance.pictureImageWide)
  
  override func viewDidLoad() {
    let appStyle = AppStyle.sharedInstance
    
    let eventTitleLabel = UILabel()
    let formSetDescriptionLabel = UILabel()
    let defaultInputTextFieldOne = BaseInputTextField(hintText: (placeholderTextArray.popLast() ?? "e.g. placeholder"))
    let defaultInputTextFieldTwo = BaseInputTextField(hintText: (placeholderTextArray.popLast() ?? "e.g. placeholder"))
    
    eventTitleLabel.textAlignment = .center
    eventTitleLabel.numberOfLines = 0
    eventTitleLabel.lineBreakMode = .byWordWrapping
    eventTitleLabel.font = appStyle.headerFontMedium
    //SKO - TODO: extract event title from event singleton
    eventTitleLabel.text = "[EVENT TITLE]"
    
    formSetDescriptionLabel.textAlignment = .center
    formSetDescriptionLabel.numberOfLines = 0
    formSetDescriptionLabel.lineBreakMode = .byWordWrapping
    formSetDescriptionLabel.font = appStyle.headerFontMedium
    formSetDescriptionLabel.text = NSLocalizedString("attendee characteristics description", comment: "attendee characteristics description label")
    
    addFieldButton.setTitle(NSLocalizedString("add another field", comment: "add characteristic text field button"), for: .normal)
    addFieldButton.addTarget(self, action: #selector(didTapAddFieldButton), for: .touchUpInside)
    addFieldButton.translatesAutoresizingMaskIntoConstraints = false
    addFieldButton.titleLabel?.font = appStyle.textFontSmall
    addFieldButton.titleLabel?.alpha = 0.2
    addFieldButton.backgroundColor = UIColor.blue
    
    removeFieldButton.setTitle(NSLocalizedString("remove a field", comment: "remove characteristic text field button"), for: .normal)
    removeFieldButton.addTarget(self, action: #selector(didTapRemoveFieldButton), for: .touchUpInside)
    removeFieldButton.translatesAutoresizingMaskIntoConstraints = false
    removeFieldButton.titleLabel?.font = appStyle.textFontSmall
    removeFieldButton.titleLabel?.alpha = 0.2
    removeFieldButton.isHidden = true
    removeFieldButton.backgroundColor = UIColor.red
    
    fieldButtonsContainer.addSubview(addFieldButton)
    fieldButtonsContainer.addSubview(removeFieldButton)
    fieldButtonsContainer.translatesAutoresizingMaskIntoConstraints = false
    fieldButtonsContainer.backgroundColor = UIColor.purple
    
    continueButtonContainer.button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    continueButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: eventTitleLabel)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: formSetDescriptionLabel)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: defaultInputTextFieldOne)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: defaultInputTextFieldTwo)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: fieldButtonsContainer)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: continueButtonContainer)
    
    headerAndStackViewContainer.setHeaderView(view: picturePromptImageView)
    headerAndStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
    
    let headerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
    headerAndStackViewContainer.headerView.addGestureRecognizer(headerTapGestureRecognizer)
    
    self.view.addSubview(headerAndStackViewContainer)
    
    self.view.backgroundColor = appStyle.backgroundColor
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    headerAndStackViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    headerAndStackViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    headerAndStackViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    headerAndStackViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    
    fieldButtonsContainer.heightAnchor.constraint(equalToConstant: AppStyle.sharedInstance.baseInputTextFieldHeight).isActive = true
    
    addFieldButton.topAnchor.constraint(equalTo: fieldButtonsContainer.topAnchor).isActive = true
    addFieldButton.bottomAnchor.constraint(equalTo: fieldButtonsContainer.bottomAnchor).isActive = true
    addFieldButton.leadingAnchor.constraint(equalTo: fieldButtonsContainer.leadingAnchor).isActive = true
    addFieldButton.trailingAnchor.constraint(equalTo: removeFieldButton.leadingAnchor).isActive = true
    
    removeFieldButton.topAnchor.constraint(equalTo: fieldButtonsContainer.topAnchor).isActive = true
    removeFieldButton.bottomAnchor.constraint(equalTo: fieldButtonsContainer.bottomAnchor).isActive = true
    removeFieldButton.leadingAnchor.constraint(equalTo: addFieldButton.trailingAnchor).isActive = true
    removeFieldButton.trailingAnchor.constraint(equalTo: fieldButtonsContainer.trailingAnchor).isActive = true
  }
  
  func didTapAddFieldButton(sender: UIButton) {
    let nextInputTextField = BaseInputTextField(hintText: (placeholderTextArray.popLast() ?? "e.g. placeholder"))
    headerAndStackViewContainer.baseInputView.addArrangedSubviewToStackView(view: nextInputTextField, aboveView: fieldButtonsContainer)
    additionalInputTextFieldsArray.append(nextInputTextField)
    if placeholderTextArray.isEmpty {
      addFieldButton.isEnabled = false
    }
    if removeFieldButton.isHidden {
      removeFieldButton.isHidden = false
    }
    
    headerAndStackViewContainer.baseInputView.setNeedsLayout()
    headerAndStackViewContainer.baseInputView.layoutIfNeeded()
  }
  
  func didTapRemoveFieldButton(sender: UIButton) {
    headerAndStackViewContainer.baseInputView.stackView.removeArrangedSubview(additionalInputTextFieldsArray.popLast()!)
    
    if additionalInputTextFieldsArray.isEmpty {
      removeFieldButton.isHidden = true
    }
    
    if !addFieldButton.isEnabled {
      addFieldButton.isEnabled = true
    }
  }
  
  func didTapContinueButton(sender: UIButton) {
    
  }
  
  func didTapHeader(sender: UITapGestureRecognizer) {
    let imagePicker = ImagePickerAlertController(frame: view.bounds, controller: self)
    imagePicker.displayAlert(imageReference: picturePromptImageView)
  }
}
