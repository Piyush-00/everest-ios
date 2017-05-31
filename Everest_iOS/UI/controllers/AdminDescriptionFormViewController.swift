//
//  AdminDescriptionFormViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class AdminDescriptionFormViewController: UIViewController, UITextViewDelegate, ImagePickerAlertProtocol {
  private let headerAndStackViewContainer = HeaderAndStackViewContainer(withNavigationBar: true)
  private let adminDescriptionTextView = BaseInputTextView(hintText: NSLocalizedString("admin description input placeholder", comment: "admin description input placeholder"))
  private let headerImageView: UIImageView = UIImageView()
  
  let createEventButtonContainer = BaseInputButtonContainer(buttonTitle: NSLocalizedString("confirm event", comment: "confirm event button"))
  
  var isJoiningEvent = false
  
  var event: Event?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    
    let appStyle = AppStyle.sharedInstance
    
    let adminDescriptionHeaderLabel = UILabel()
    let adminDescriptionInfoLabel = UILabel()
    
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
    
    headerImageView.clipsToBounds = true
    headerImageView.contentMode = .scaleAspectFill
    headerImageView.layer.masksToBounds = true
    
    let headerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
    
    headerAndStackViewContainer.headerView.addGestureRecognizer(headerTapGestureRecognizer)
    headerAndStackViewContainer.setHeaderView(view: headerImageView)
    
    self.view.addSubview(headerAndStackViewContainer)
    
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if isJoiningEvent {
      createEventButtonContainer.button.setTitle(NSLocalizedString("join", comment: "join as admin"), for: .normal)
    }
    
    if let headerImage = event?.getHeaderImage() {
      if headerImageView.image != headerImage {
        headerImageView.image = headerImage
      }
    } else {
      if(isJoiningEvent) {
        if let headerImageURL = event?.getHeaderImageUrl() {
        headerImageView.downloadedFrom(link: headerImageURL)
        } else {
          headerImageView.image = AppStyle.sharedInstance.pictureImageWide
        }
      } else {
        headerImageView.image = AppStyle.sharedInstance.pictureImageWide
      }
    }
    
    headerImageView.clipsToBounds = true
    headerImageView.contentMode = .scaleAspectFill
    headerImageView.layer.masksToBounds = true
  }
  
  private func setupConstraints() {
    headerAndStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
    
    headerAndStackViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    headerAndStackViewContainer.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
    headerAndStackViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    headerAndStackViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }
  
  func didTapCreateEventButton(sender: UIButton) {
    self.view.endEditing(true)
    
    if isJoiningEvent {
      event?.joinEvent(longDesc: adminDescriptionTextView.text) { response in
        switch response {
        case true:
          if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let eventNavigationController = UINavigationController(nibName: nil, bundle: nil)
            let eventContainerViewController = EventContainerViewController()
            
            Keychain.set(key: Keys.sharedInstance.EventID, token: (self.event!.getId()!) as NSString)
            
            eventNavigationController.viewControllers = [eventContainerViewController]
            appDelegate.navigationController = nil
            appDelegate.window?.rootViewController = eventNavigationController
          }
          break
        case false:
          print("error has occurred")
        }
      }
    } else {
      if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
        let eventConfirmationViewController = EventConfirmationViewController()
        eventConfirmationViewController.event = event
        navigationController.pushViewController(eventConfirmationViewController, animated: true)
      }
    }
  }
  
  func didTapHeader(sender: UITapGestureRecognizer) {
    if (!isJoiningEvent) {
      let imagePicker = ImagePickerAlertController(frame: view.bounds, controller: self)
      imagePicker.delegate = self
      imagePicker.displayAlert()
    }
  }
  
  //MARK: UITextViewDelegate
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
  
  //MARK: ImagePickerAlertProtocol
  func didPickImage(image: UIImage) {
    headerImageView.image = image
    event?.setHeaderImage(image: image)
  }
}
