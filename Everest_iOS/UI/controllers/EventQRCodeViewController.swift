//
//  EventQRCodeViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-17.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventQRCodeViewController : UIViewController {

  private let contentView: QRCodeView = QRCodeView()
  private var AdminQRCodeImage: UIImage?
  private var AttendeeQRCodeImage: UIImage?
  private var initialLoad: Bool = true
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.white
  
    contentView.headerLabelView.text = NSLocalizedString("qrcode header", comment: "qrcode header text placeholder") + "Google I/O"
    contentView.disclaimerLabelView.text = NSLocalizedString("qrcode disclaimer", comment: "qrcode disclaimer text placeholder")
    contentView.proTipLabelView.text = NSLocalizedString("qrcode pro tip", comment: "qrcode pro tip text placeholder")
    
    view.addSubview(contentView)
    setupConstraints()
  
    contentView.AdminToggleButton.addTarget(self, action: #selector(didTapAdminToggleButton), for: .touchUpInside)
    contentView.AttendeeToggleButton.addTarget(self, action: #selector(didTapAttendeeToggleButton), for: .touchUpInside)
    
    //SKU - Load the attendee QR Code initially. Save the image.
    contentView.QRCodeImageView.downloadedFrom(link: "https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=/Event/5850caf5e92716051df0f193?key=9yjhel09pv079zfr") {
      response in
      if (response) {
        self.AttendeeQRCodeImage = self.contentView.QRCodeImageView.image!
        self.contentView.AttendeeToggleButton.backgroundColor = AppStyle.sharedInstance.baseInputButtonColor
      }
    }
  
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func setupConstraints() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
  func didTapAdminToggleButton(){
    //SKU - Toggle button colors to show active button.
    self.contentView.AttendeeToggleButton.backgroundColor = AppStyle.sharedInstance.baseInputInActiveButtonColor
    self.contentView.AdminToggleButton.backgroundColor = AppStyle.sharedInstance.baseInputButtonColor
    
    //SKU - If the admin toggle is tapped for the first time, download the image.
    if (initialLoad) {
      contentView.QRCodeImageView.downloadedFrom(link: "https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=/Event/5850caf5e92716051df0f193?key=40b2qqbd8slqsemi") {
        response in
        if (response) {
          self.AdminQRCodeImage = self.contentView.QRCodeImageView.image!
          self.initialLoad = false
        }
      }
    //SKU - Assuming the admin QR code has been downloaded previously, load from memory
    } else {
      if (AdminQRCodeImage != nil) {
        contentView.QRCodeImageView.image = AdminQRCodeImage!
      }
    }
  }
  
  func didTapAttendeeToggleButton() {
    //SKU - Toggle button colors to show active button.
    self.contentView.AttendeeToggleButton.backgroundColor = AppStyle.sharedInstance.baseInputButtonColor
    self.contentView.AdminToggleButton.backgroundColor = AppStyle.sharedInstance.baseInputInActiveButtonColor
    
    if(AttendeeQRCodeImage != nil) {
      contentView.QRCodeImageView.image = self.AttendeeQRCodeImage!
    }
  }

}
