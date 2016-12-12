//
//  ProfileViewContainer.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-11.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class ProfileStatsContainer: UIView {
  
  private let eventsAdminView = UIView()
  private let eventsAttendeeView = UIView()
  private let eventsAdminLabel = UILabel()
  private let eventsAttendeeLabel = UILabel()
  private var eventsAdminStatLabel = UILabel()
  private var eventsAttendeeStatLabel = UILabel()
  
  init(_ coder: NSCoder? = nil) {
    
    if let coder = coder {
      super.init(coder: coder)!
    } else {
      super.init(frame: CGRect.zero)
    }
    
    //SKU - Set default numbers to 0.
    eventsAdminStatLabel.text = "0"
    eventsAttendeeStatLabel.text = "0"
    
    
    eventsAdminView.addSubview(eventsAdminStatLabel)
    eventsAdminView.addSubview(eventsAdminLabel)
    eventsAttendeeView.addSubview(eventsAttendeeStatLabel)
    eventsAttendeeView.addSubview(eventsAttendeeLabel)
    addSubview(eventsAttendeeView)
    addSubview(eventsAdminView)
  }
  
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    setupConstraints()
  }
  
  func setupConstraints() {
    
    translatesAutoresizingMaskIntoConstraints = false
  
    eventsAttendeeView.translatesAutoresizingMaskIntoConstraints = false
    eventsAttendeeView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    eventsAttendeeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    eventsAttendeeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    eventsAttendeeView.trailingAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    eventsAdminView.sideBorder(side: .right, width: 1, colour: UIColor.black)
    eventsAdminView.translatesAutoresizingMaskIntoConstraints = false
    eventsAdminView.leadingAnchor.constraint(equalTo: centerXAnchor).isActive = true
    eventsAdminView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    eventsAdminView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    eventsAdminView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    eventsAdminLabel.text = "Events Hosted"
    eventsAdminLabel.font = AppStyle.sharedInstance.headerFontSmall
    eventsAdminLabel.translatesAutoresizingMaskIntoConstraints = false
    eventsAdminLabel.centerXAnchor.constraint(equalTo: eventsAdminView.centerXAnchor).isActive = true
    eventsAdminLabel.bottomAnchor.constraint(equalTo: eventsAdminView.bottomAnchor).isActive = true
    
    eventsAttendeeLabel.text = "Events Joined"
    eventsAttendeeLabel.font = AppStyle.sharedInstance.headerFontSmall
    eventsAttendeeLabel.translatesAutoresizingMaskIntoConstraints = false
    eventsAttendeeLabel.leadingAnchor.constraint(equalTo: eventsAttendeeView.leadingAnchor).isActive = true
    eventsAttendeeLabel.bottomAnchor.constraint(equalTo: eventsAttendeeView.bottomAnchor).isActive = true
    
    eventsAdminStatLabel.font = AppStyle.sharedInstance.headerFontLarge30Light
    eventsAdminStatLabel.translatesAutoresizingMaskIntoConstraints = false
    eventsAdminStatLabel.leadingAnchor.constraint(equalTo: eventsAdminLabel.leadingAnchor).isActive = true
    eventsAdminStatLabel.topAnchor.constraint(equalTo: eventsAdminView.topAnchor).isActive = true
    
    eventsAttendeeStatLabel.font = AppStyle.sharedInstance.headerFontLarge30Light
    eventsAttendeeStatLabel.translatesAutoresizingMaskIntoConstraints = false
    eventsAttendeeStatLabel.leadingAnchor.constraint(equalTo: eventsAttendeeLabel.leadingAnchor).isActive = true
    eventsAttendeeStatLabel.topAnchor.constraint(equalTo: eventsAttendeeView.topAnchor).isActive = true
  }

  func setAdminStats(value: String) {
    eventsAdminStatLabel.text = value
  }
  
  func setAttendeeStats(value: String) {
    eventsAttendeeStatLabel.text = value
  }
}
