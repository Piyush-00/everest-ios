//
//  EventModalView.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventModalView: ModalViewContainer {
  
  var headerContentView: UIImageView
  var eventNameTextView, eventDescriptionTextView, eventDateTextView, eventLocationTextView: BaseInputTextView
  var joinEventButtonView: BaseInputButtonContainer

  
   init(_ event: Event, coder: NSCoder? = nil) {
    headerContentView = UIImageView()
    headerContentView.downloadedFrom(link: event.getHeaderImageUrl())
    //SKU - 50 character limit on event title
    eventNameTextView = BaseInputTextView(textInput: event.getName())
    eventDescriptionTextView = BaseInputTextView(textInput: event.getDescription())
    eventDateTextView = BaseInputTextView(textInput: event.getStartTime() + "\n" + event.getEndTime())
    eventLocationTextView = BaseInputTextView(textInput: event.getLocation())
    joinEventButtonView = BaseInputButtonContainer(buttonTitle: "Join Event")

    if let coder = coder {
      super.init(coder)
    } else {
      super.init(coder)
    }
    
    super.setBackgroundColor(color: UIColor(netHex: 0x363636))
    
    eventNameTextView.isEditable = false
    eventDescriptionTextView.isEditable = false
    eventDateTextView.isEditable = false
    eventLocationTextView.isEditable = false
    
    headerContentView.contentMode = .scaleAspectFill
    headerContentView.layer.masksToBounds = true
    
    contentView.addArrangedSubviewToStackView(view: headerContentView)
    contentView.addArrangedSubviewToStackView(view: eventNameTextView)
    contentView.addArrangedSubviewToStackView(view: eventDescriptionTextView)
    contentView.addArrangedSubviewToStackView(view: eventDateTextView)
    contentView.addArrangedSubviewToStackView(view: eventLocationTextView)
    contentView.addArrangedSubviewToStackView(view: joinEventButtonView)
    contentView.spacing(value: 0)
    
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    setupConstraints()
  }
  
  func setupConstraints(){
    headerContentView.translatesAutoresizingMaskIntoConstraints = false
    headerContentView.heightAnchor.constraint(equalToConstant: 115).isActive = true
    
    setupEventNameTextViewConstraints()
    setupEventDescriptionTextViewConstraints()
    setupEventDateTextViewConstraints()
    setupEventLocationTextViewConstraints()
    setupJoinEventButtonViewConstraints()
  }
  
  //SKU - Setting up constraints for the Event Name
  private func setupEventNameTextViewConstraints() {
    eventNameTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    eventNameTextView.textAlignment = .center
    eventNameTextView.font = AppStyle.sharedInstance.headerFontSemiLarge
    eventNameTextView.textColor = UIColor(hex: "#686868")
    eventNameTextView.layoutIfNeeded()
    eventNameTextView.updateConstraints()
  }

  //SKU - Setting up constraints for the Event Description
  private func setupEventDescriptionTextViewConstraints() {
    eventDescriptionTextView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    eventDescriptionTextView.textAlignment = .center
    eventDescriptionTextView.font = AppStyle.sharedInstance.headerFontSmall
    eventDescriptionTextView.textColor = UIColor(hex: "#000000")
  }
  
  //SKU - Setting up constraints for the Date/Time
  private func setupEventDateTextViewConstraints() {
    eventDateTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    eventDateTextView.textAlignment = .center
    eventDateTextView.font = AppStyle.sharedInstance.textFontBold
    eventDateTextView.textColor = UIColor(hex: "#bababa")
    eventDateTextView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
  }
  
  //SKU - Setting up constraints for the location
  private func setupEventLocationTextViewConstraints() {
    eventLocationTextView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    eventLocationTextView.textAlignment = .center
    eventLocationTextView.font = AppStyle.sharedInstance.textFontMedium
    eventLocationTextView.textColor = UIColor(hex: "#bababa")
    eventLocationTextView.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
  }
  
  //SKU - Setting up constraints for the button
  private func setupJoinEventButtonViewConstraints() {
    joinEventButtonView.translatesAutoresizingMaskIntoConstraints = false
    joinEventButtonView.button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100).isActive = true
    joinEventButtonView.button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100).isActive = true

  }

}
