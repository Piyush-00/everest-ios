//
//  LandingViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
  var overlayView = UIView()
  var scanButtonContainer = BaseInputButtonContainer(buttonTitle: "Scan")
  var createEvenButtonContainer = BaseInputButtonContainer(buttonTitle: "Create Event")
  var loginButtonContainer = BaseInputButtonContainer(buttonTitle: "Login")
  var signupButtonContainer = BaseInputButtonContainer(buttonTitle: "Sign up")
  var headerTextView = BaseInputTextView(textInput: "Hi! Sign up to get started.")
  var subHeaderTextView = BaseInputTextView(textInput: "Or scan now and join later!")
  var baseCameraView = BaseCameraSesssion()
  var scanButtoncontainerBottomConstraint = NSLayoutConstraint()
  var tappedScanButton = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    overlayView.addSubview(headerTextView)
    overlayView.addSubview(subHeaderTextView)
    overlayView.addSubview(scanButtonContainer)
    overlayView.addSubview(createEvenButtonContainer)
    overlayView.addSubview(loginButtonContainer)
    overlayView.addSubview(signupButtonContainer)
    view.addSubview(baseCameraView)
    view.addSubview(overlayView)
    baseCameraView.startCameraSession(controller: self)
    
    scanButtonContainer.button.addTarget(self, action: #selector(didTapScanButton), for: .touchUpInside)
    
    setupConstraints()
  }
  
  func didTapScanButton(sender: UIButton) {
    toggleLandingOverlay()
  }
  
  //SKO - toggles between initial landing page view and scanning view
  private func toggleLandingOverlay() {
    tappedScanButton = !tappedScanButton
    
    if (!tappedScanButton) {
      overlayView.addSubview(headerTextView)
      overlayView.addSubview(subHeaderTextView)
      overlayView.addSubview(createEvenButtonContainer)
      overlayView.addSubview(loginButtonContainer)
      overlayView.addSubview(signupButtonContainer)
      
      scanButtoncontainerBottomConstraint.constant = -140
      
      setupHeaderTextViewConstraints()
      setupSubHeaderTextViewConstraints()
      setupCreateEventButtonContainerConstraints()
      setupFooterConstraints()
      
      scanButtonContainer.button.setTitle("Scan", for: .normal)
    } else {
      scanButtoncontainerBottomConstraint.constant = -80
      scanButtonContainer.button.setTitle("Back", for: .normal)
    }
    
    UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
        if (self.tappedScanButton) {
          self.headerTextView.alpha = 0
          self.subHeaderTextView.alpha = 0
          self.createEvenButtonContainer.alpha = 0
          self.loginButtonContainer.alpha = 0
          self.signupButtonContainer.alpha = 0
        } else {
          self.headerTextView.alpha = 1
          self.subHeaderTextView.alpha = 1
          self.createEvenButtonContainer.alpha = 1
          self.loginButtonContainer.alpha = 1
          self.signupButtonContainer.alpha = 1
        }
      
        self.overlayView.layoutIfNeeded()
      }, completion: {
        (value: Bool) in
        if (self.tappedScanButton) {
          self.headerTextView.removeFromSuperview()
          self.subHeaderTextView.removeFromSuperview()
          self.createEvenButtonContainer.removeFromSuperview()
          self.loginButtonContainer.removeFromSuperview()
          self.signupButtonContainer.removeFromSuperview()
          
          self.baseCameraView.addOutput()
        } else {
          self.baseCameraView.removeOutput()
        }
    })
  }
  
  //SKU - Setup constraints for all containers and views
  func setupConstraints(){
    setupBaseCameraViewConstraints()
    setupOverlayViewConstraints()
    setupScanButtonContainerConstraints()
    setupCreateEventButtonContainerConstraints()
    setupHeaderTextViewConstraints()
    setupSubHeaderTextViewConstraints()
    setupFooterConstraints()
  }
  
  func setupBaseCameraViewConstraints(){
    baseCameraView.translatesAutoresizingMaskIntoConstraints = false
    
    baseCameraView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    baseCameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    baseCameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    baseCameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  func setupOverlayViewConstraints(){
    overlayView.isUserInteractionEnabled = true
    
    overlayView.translatesAutoresizingMaskIntoConstraints = false
    overlayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  func setupScanButtonContainerConstraints(){
    scanButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    
    scanButtonContainer.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 40).isActive = true
    scanButtonContainer.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -40).isActive = true
    
    scanButtoncontainerBottomConstraint = scanButtonContainer.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -140)
    scanButtoncontainerBottomConstraint.isActive = true
  }
  
  func setupCreateEventButtonContainerConstraints(){
    createEvenButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    
    createEvenButtonContainer.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 40).isActive = true
    createEvenButtonContainer.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -40).isActive = true
    createEvenButtonContainer.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -80).isActive = true
    createEvenButtonContainer.button.setBackgroundImage(AppUtil.resizableImageWithColor(color: AppStyle.sharedInstance.baseInputSecondaryButtonColor), for: .normal)
  }

  func setupHeaderTextViewConstraints(){
    headerTextView.translatesAutoresizingMaskIntoConstraints = false
    
    headerTextView.isEditable = false
    headerTextView.isUserInteractionEnabled = false
    headerTextView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 50).isActive = true
    headerTextView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 10).isActive = true
    headerTextView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -10).isActive = true
    headerTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    headerTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
    headerTextView.textColor = AppStyle.sharedInstance.textFieldBackgroundColor
    headerTextView.backgroundColor = nil
    headerTextView.textAlignment = .center
  }
  
  func setupSubHeaderTextViewConstraints(){
    subHeaderTextView.translatesAutoresizingMaskIntoConstraints = false
    
    subHeaderTextView.isEditable = false
    subHeaderTextView.isUserInteractionEnabled = false
    subHeaderTextView.topAnchor.constraint(equalTo: headerTextView.bottomAnchor).isActive = true
    subHeaderTextView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 10).isActive = true
    subHeaderTextView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -10).isActive = true
    subHeaderTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    subHeaderTextView.font = UIFont(name: "HelveticaNeue", size: 20)
    subHeaderTextView.textColor = AppStyle.sharedInstance.textFieldBackgroundColor
    subHeaderTextView.backgroundColor = nil
    subHeaderTextView.textAlignment = .center
    subHeaderTextView.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
  }
  
  func setupFooterConstraints(){
    loginButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    signupButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    
    loginButtonContainer.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor,constant: 10).isActive = true
    loginButtonContainer.widthAnchor.constraint(equalTo: loginButtonContainer.button.widthAnchor).isActive = true
    loginButtonContainer.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -5).isActive = true
    loginButtonContainer.button.setBackgroundImage(nil, for: .normal)
    
    signupButtonContainer.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -10).isActive = true
    signupButtonContainer.widthAnchor.constraint(equalTo: signupButtonContainer.button.widthAnchor).isActive = true
    signupButtonContainer.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -5).isActive = true
    signupButtonContainer.button.setBackgroundImage(nil, for: .normal)
  }
}
