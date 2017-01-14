//
//  InvalidModalView.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class InvalidModalView: ModalViewContainer {
  var headerTextView, subHeaderTextView, errorMessageTextView, tipTextView: BaseInputTextView
  var scanAgainButtonView: BaseInputButtonContainer
  var errorImageView: UIImageView
  
  override init(_ coder: NSCoder? = nil) {
    
    headerTextView = BaseInputTextView(textInput: Translation.sharedInstance.modalInvalid_HeaderText)
    subHeaderTextView = BaseInputTextView(textInput: Translation.sharedInstance.modalInvalid_SubHeaderText)
    errorMessageTextView = BaseInputTextView(textInput: Translation.sharedInstance.modalInvalid_errorMessageText)
    tipTextView = BaseInputTextView(textInput: Translation.sharedInstance.modalInvalid_tipMessageText)
    scanAgainButtonView = BaseInputButtonContainer(buttonTitle: Translation.sharedInstance.modalInvalid_ButtonText)
    errorImageView = UIImageView()
    
    if let coder = coder {
      super.init(coder)
    } else {
      super.init(coder)
    }
    
    //SKU - Change background of modal to red to signify that there was an error
    super.setBackgroundColor(color: UIColor(hex: "#ff5b5b"))
    
    headerTextView.isEditable = false
    subHeaderTextView.isEditable = false
    errorMessageTextView.isEditable = false
    tipTextView.isEditable = false
    
    errorImageView.image = AppStyle.sharedInstance.scanningErrorImageRed
    errorImageView.contentMode = .scaleAspectFit
    errorImageView.layer.masksToBounds = true
    
    contentView.addArrangedSubviewToStackView(view: headerTextView)
    contentView.addArrangedSubviewToStackView(view: subHeaderTextView)
    contentView.addArrangedSubviewToStackView(view: errorImageView)
    contentView.addArrangedSubviewToStackView(view: scanAgainButtonView)
    contentView.addArrangedSubviewToStackView(view: errorMessageTextView)
    contentView.addArrangedSubviewToStackView(view: tipTextView)
    contentView.spacing(value: 0)
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    setupConstraints()
    
    scanAgainButtonView.button.addTarget(self, action: #selector(onTapJoinButton(sender:)), for: .touchUpInside)
  }

  func setupConstraints(){
    setupHeaderTextViewConstraints()
    setupSubHeaderTextViewConstraints()
    setupErrorImageViewConstraints()
    setupErrorMessageTextView()
    setupTipTextView()
    setupScanAgainButtonView()
  }
  
  private func setupHeaderTextViewConstraints() {
    headerTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    headerTextView.textAlignment = .center
    headerTextView.font = UIFont(name: "HelveticaNeue", size: 30)
    headerTextView.textColor = AppStyle.sharedInstance.textColor
  }
  
  private func setupSubHeaderTextViewConstraints() {
    subHeaderTextView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    subHeaderTextView.textAlignment = .center
    subHeaderTextView.font = AppStyle.sharedInstance.headerFontMedium
    subHeaderTextView.textColor = UIColor(hex: "#4f4f4f")
    subHeaderTextView.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
  }
  
  private func setupErrorImageViewConstraints() {
    errorImageView.translatesAutoresizingMaskIntoConstraints = false
    errorImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
  }

  private func setupErrorMessageTextView(){
    errorMessageTextView.translatesAutoresizingMaskIntoConstraints = false
    errorMessageTextView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    errorMessageTextView.textAlignment = .center
    errorMessageTextView.font = AppStyle.sharedInstance.textFontMedium
    errorMessageTextView.textColor = AppStyle.sharedInstance.textColor
    errorMessageTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
  }
  
  private func setupTipTextView(){
    tipTextView.translatesAutoresizingMaskIntoConstraints = false
    tipTextView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    tipTextView.textAlignment = .center
    tipTextView.font = AppStyle.sharedInstance.textFontSmallRegular
    tipTextView.textColor = UIColor(hex: "#a5a5a5")
    tipTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
  }
  
  private func setupScanAgainButtonView(){
    scanAgainButtonView.translatesAutoresizingMaskIntoConstraints = false
    scanAgainButtonView.button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 100).isActive = true
    scanAgainButtonView.button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -100).isActive = true
    scanAgainButtonView.button.setBackgroundImage(AppUtil.resizableImageWithColor(color: UIColor(hex: "#ffffff")), for: .normal)
    scanAgainButtonView.button.layer.borderColor = AppStyle.sharedInstance.invalidColor.cgColor
    scanAgainButtonView.button.layer.borderWidth = 1
    scanAgainButtonView.button.setTitleColor(AppStyle.sharedInstance.invalidColor, for: UIControlState.normal)
  }
  
  @objc private func onTapJoinButton(sender: UIButton) {
    //SKU - didTapModalBackground protocol is handeled by Landing view controller for removing of view and activating camera session.
    //TODO Refactor naming of function to be more general
    delegate?.didTapModalBackground(view: self)
  }
}
