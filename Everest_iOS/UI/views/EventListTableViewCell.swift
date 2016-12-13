//
//  EventListTableViewCell.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-10.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventListTableViewCell: UITableViewCell {
  
  private let contentStackView = UIStackView()
  private let cellCardView = UIView()
  let eventBackgroundImage = UIImageView()
  private let userEventStatusBar = UIView()
  
  private let eventNameLabel = UILabel()
  private let eventStartTimeLabel = UILabel()
  private let eventEndTimeLabel = UILabel()
  private let eventLocationLabel = UILabel()
  
  //SKU - Constant properties
  private let cellCardViewWidthRatio: CGFloat = 0.95
  private let cellCardViewHeightRatio: CGFloat = 0.9
  private let contentStackViewContainerTrailingMargin: CGFloat = 60.0
  private let contentStackViewVerticalMargin: CGFloat = 15.0
  private let contentStackViewSpacing: CGFloat = 2.0
  private let userEventStatusBarWidth: CGFloat = 10
  private let contentStackViewLeadingOffset: CGFloat = 10
  //SKU - contentStackViewContainerLeadingMargin = userEventStatusBarWidth + contentStackViewLeadingOffset
  private var contentStackViewContainerLeadingMargin: CGFloat
  
  //SKU - Cell values getter and setter
  var eventName: String? {
    get {
      return eventNameLabel.text
    } set {
      eventNameLabel.text = newValue
    }
  }
  var eventLocation: String? {
    get {
      return eventLocationLabel.text
    } set {
      eventLocationLabel.text = newValue
    }
  }
  
  var eventStartTime: String? {
    get {
      return eventStartTimeLabel.text
    } set {
      eventStartTimeLabel.text = newValue
    }
  }

  var eventEndTime: String? {
    get {
      return eventEndTimeLabel.text
    } set {
      eventEndTimeLabel.text = newValue
    }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    contentStackViewContainerLeadingMargin = userEventStatusBarWidth + contentStackViewLeadingOffset
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    contentStackViewContainerLeadingMargin = userEventStatusBarWidth + contentStackViewLeadingOffset
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    let appStyle = AppStyle.sharedInstance
    
    cellCardView.translatesAutoresizingMaskIntoConstraints = false
    cellCardView.backgroundColor = appStyle.eventFeedCardViewBackgroundColor
    cellCardView.layer.cornerRadius = 4.0
    cellCardView.backgroundColor = UIColor.black
    
    self.contentView.addSubview(cellCardView)
    self.backgroundColor = .clear
    self.selectionStyle = .none
    
    eventBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
    eventBackgroundImage.clipsToBounds = true
    eventBackgroundImage.layer.masksToBounds = true
    eventBackgroundImage.layer.cornerRadius = 4.0
    eventBackgroundImage.alpha = 0.5
    
    userEventStatusBar.translatesAutoresizingMaskIntoConstraints = false
    userEventStatusBar.backgroundColor = UIColor.red
    
    cellCardView.addSubview(eventBackgroundImage)
    cellCardView.addSubview(userEventStatusBar)
    
    eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
    eventNameLabel.font = appStyle.textFontLarge
    eventNameLabel.textColor = appStyle.regularTextWhiteColor
    
    eventLocationLabel.translatesAutoresizingMaskIntoConstraints = false
    eventLocationLabel.font = appStyle.textFontSmallLight
    eventLocationLabel.textColor = appStyle.regularTextWhiteColor
    eventLocationLabel.numberOfLines = 0
    eventLocationLabel.lineBreakMode = .byWordWrapping
    
    eventStartTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    eventStartTimeLabel.font = appStyle.textFontSmallLight
    eventStartTimeLabel.textColor = appStyle.regularTextWhiteColor
    
    eventEndTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    eventEndTimeLabel.font = appStyle.textFontSmallLight
    eventEndTimeLabel.textColor = appStyle.regularTextWhiteColor
    contentStackView.axis = .vertical
    contentStackView.spacing = contentStackViewSpacing
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    
    contentStackView.addArrangedSubview(eventNameLabel)
    contentStackView.addArrangedSubview(eventLocationLabel)
    contentStackView.addArrangedSubview(eventStartTimeLabel)
    contentStackView.addArrangedSubview(eventEndTimeLabel)
    cellCardView.addSubview(contentStackView)
    
    cellCardView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    cellCardView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    cellCardView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cellCardViewWidthRatio).isActive = true
    cellCardView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: cellCardViewHeightRatio).isActive = true
    
    eventBackgroundImage.topAnchor.constraint(equalTo: cellCardView.topAnchor).isActive = true
    eventBackgroundImage.bottomAnchor.constraint(equalTo: cellCardView.bottomAnchor).isActive = true
    eventBackgroundImage.leadingAnchor.constraint(equalTo: cellCardView.leadingAnchor).isActive = true
    eventBackgroundImage.trailingAnchor.constraint(equalTo: cellCardView.trailingAnchor).isActive = true
    
    userEventStatusBar.topAnchor.constraint(equalTo: cellCardView.topAnchor).isActive = true
    userEventStatusBar.heightAnchor.constraint(equalTo: cellCardView.heightAnchor).isActive = true
    userEventStatusBar.leadingAnchor.constraint(equalTo: cellCardView.leadingAnchor).isActive = true
    userEventStatusBar.widthAnchor.constraint(equalToConstant: userEventStatusBarWidth).isActive = true
    
    contentStackView.topAnchor.constraint(equalTo: cellCardView.topAnchor).isActive = true
    contentStackView.bottomAnchor.constraint(equalTo: cellCardView.bottomAnchor, constant: -contentStackViewVerticalMargin).isActive = true
    contentStackView.leadingAnchor.constraint(equalTo: cellCardView.leadingAnchor, constant: contentStackViewContainerLeadingMargin).isActive = true
    contentStackView.trailingAnchor.constraint(equalTo: cellCardView.trailingAnchor, constant: -contentStackViewContainerTrailingMargin).isActive = true
  }
}

  
