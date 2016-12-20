//
//  QRCodeView.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-17.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class QRCodeView: UIView {
  let headerLabelView = UILabel()
  let QRCodeImageView = UIImageView()
  let AdminToggleButton = UIButton()
  let AttendeeToggleButton = UIButton()
  private let toggleViewWrapper = UIView()
  let disclaimerLabelView = UILabel()
  let proTipLabelView = UILabel()
  
  //SKU - Constant property decleration
  private let headerViewHeight = AppStyle.sharedInstance.headerViewContainerHeaderHeight
  private let QRCodeHeight = AppStyle.sharedInstance.QRCodeViewHeight
  private let topMargin:CGFloat = 15
  
  init(_ coder: NSCoder? = nil) {
    
    if let coder = coder {
      super.init(coder:coder)!
    } else {
      super.init(frame: CGRect.zero)
    }
    
    toggleViewWrapper.addSubview(AdminToggleButton)
    toggleViewWrapper.addSubview(AttendeeToggleButton)
    setupToggleViewWrapperConstraints()
    
    addSubview(headerLabelView)
    addSubview(toggleViewWrapper)
    addSubview(QRCodeImageView)
    addSubview(disclaimerLabelView)
    addSubview(proTipLabelView)
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    setupConstraints()
    setupComponents()
  }
  
  private func setupComponents() {
    headerLabelView.numberOfLines = 0
    headerLabelView.textAlignment = .center
    headerLabelView.lineBreakMode = .byWordWrapping
    headerLabelView.font = AppStyle.sharedInstance.headerFontLarge25Light
    
    QRCodeImageView.clipsToBounds = true
    QRCodeImageView.contentMode = .scaleAspectFit
    QRCodeImageView.layer.masksToBounds = true
    
    disclaimerLabelView.numberOfLines = 0
    disclaimerLabelView.textAlignment = .center
    disclaimerLabelView.lineBreakMode = .byWordWrapping
    disclaimerLabelView.sizeToFit()
    disclaimerLabelView.font = AppStyle.sharedInstance.textFontSmallRegular
    disclaimerLabelView.textColor = UIColor(hex: "#4f4f4f")
    
    proTipLabelView.numberOfLines = 0
    proTipLabelView.textAlignment = .center
    proTipLabelView.lineBreakMode = .byWordWrapping
    proTipLabelView.sizeToFit()
    proTipLabelView.font = AppStyle.sharedInstance.textFontSmallRegular
    proTipLabelView.textColor = AppStyle.sharedInstance.regularTextColor
    
  }
  
  private func setupConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    
    headerLabelView.translatesAutoresizingMaskIntoConstraints = false
    headerLabelView.topAnchor.constraint(equalTo: topAnchor, constant: topMargin).isActive = true
    headerLabelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
    headerLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
    headerLabelView.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
    
    toggleViewWrapper.translatesAutoresizingMaskIntoConstraints = false
    toggleViewWrapper.topAnchor.constraint(equalTo: headerLabelView.bottomAnchor, constant: topMargin).isActive = true
    toggleViewWrapper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
    toggleViewWrapper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
    toggleViewWrapper.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    QRCodeImageView.translatesAutoresizingMaskIntoConstraints = false
    QRCodeImageView.topAnchor.constraint(equalTo: toggleViewWrapper.bottomAnchor, constant: topMargin).isActive = true
    QRCodeImageView.heightAnchor.constraint(equalToConstant: QRCodeHeight).isActive = true
    QRCodeImageView.widthAnchor.constraint(equalToConstant: QRCodeHeight).isActive = true
    QRCodeImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    disclaimerLabelView.translatesAutoresizingMaskIntoConstraints = false
    disclaimerLabelView.topAnchor.constraint(equalTo: QRCodeImageView.bottomAnchor, constant: topMargin).isActive = true
    disclaimerLabelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
    disclaimerLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true

    proTipLabelView.translatesAutoresizingMaskIntoConstraints = false
    proTipLabelView.topAnchor.constraint(equalTo: disclaimerLabelView.bottomAnchor, constant: topMargin).isActive = true
    proTipLabelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
    proTipLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
  }
  
  private func setupToggleViewWrapperConstraints() {
    
    setupAdminToggleButton()
    setupAttendeeToggleButton()
    
    AdminToggleButton.translatesAutoresizingMaskIntoConstraints = false
    AttendeeToggleButton.translatesAutoresizingMaskIntoConstraints = false
    
    AttendeeToggleButton.topAnchor.constraint(equalTo: toggleViewWrapper.topAnchor).isActive = true
    AttendeeToggleButton.leadingAnchor.constraint(equalTo: toggleViewWrapper.leadingAnchor).isActive = true
    AttendeeToggleButton.trailingAnchor.constraint(equalTo: toggleViewWrapper.centerXAnchor).isActive = true
    AttendeeToggleButton.bottomAnchor.constraint(equalTo: toggleViewWrapper.bottomAnchor).isActive = true
    
    AdminToggleButton.topAnchor.constraint(equalTo: toggleViewWrapper.topAnchor).isActive = true
    AdminToggleButton.leadingAnchor.constraint(equalTo: toggleViewWrapper.centerXAnchor).isActive = true
    AdminToggleButton.trailingAnchor.constraint(equalTo: toggleViewWrapper.trailingAnchor).isActive = true
    AdminToggleButton.bottomAnchor.constraint(equalTo: toggleViewWrapper.bottomAnchor).isActive = true
  }
  
  private func setupAdminToggleButton() {
    AdminToggleButton.backgroundColor = AppStyle.sharedInstance.baseInputInActiveButtonColor
    AdminToggleButton.setTitle("Admin", for: .normal)
    AdminToggleButton.layer.cornerRadius = 4.0
  }
  
  private func setupAttendeeToggleButton() {
    AttendeeToggleButton.backgroundColor = AppStyle.sharedInstance.baseInputInActiveButtonColor
    AttendeeToggleButton.setTitle("Attendee", for: .normal)
    AttendeeToggleButton.layer.cornerRadius = 4.0
  }
  
  
}
