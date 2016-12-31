//
//  EventChatListTableViewCell.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventChatListTableViewCell: UITableViewCell {
  private let namesAndMessageContainer = UIStackView()
  private let profilePictureImageView = UIImageView()
  private let namesLabel = UILabel()
  private let messageLabel = UILabel()
  private let timestampLabel = UILabel()
  
  var chatId: String?
  
  var names: [String] = [] {
    didSet {
      var str = ""
      for name in names {
        str += (name == names.last) ? "\(name)" : "\(name), "
      }
      namesLabel.text = str
    }
  }
  
  private var cellContentLeadingConstraint: NSLayoutConstraint!
  private var cellContentTrailingConstraint: NSLayoutConstraint!
  
  private let cellContentTopMargin: CGFloat = 10.0
  private let cellContentBottomMargin: CGFloat = 10.0
  private let namesAndMessageContainerLeadingMargin: CGFloat = 10.0
  private let namesAndMessageContainerTrailingMargin: CGFloat = 10.0
  private let namesAndMessageContainerSpacing: CGFloat = 5.0
  private let profilePictureViewDiameter: CGFloat = 40.0
  
  var picture: UIImage? {
    get {
      return profilePictureImageView.image
    }
    set {
      profilePictureImageView.image = newValue
    }
  }
  
  var message: String? {
    get {
      return messageLabel.text
    }
    set {
      messageLabel.text = newValue
    }
  }
  
  var timestamp: String? {
    get {
      return timestampLabel.text
    }
    set {
      timestampLabel.text = newValue
    }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    let appStyle = AppStyle.sharedInstance
    let profilePictureView = UIView()
    
    profilePictureImageView.layer.masksToBounds = true
    profilePictureImageView.contentMode = .scaleAspectFit
    profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
    
    profilePictureView.layer.cornerRadius = profilePictureViewDiameter / 2.0
    profilePictureView.layer.masksToBounds = true
    profilePictureView.translatesAutoresizingMaskIntoConstraints = false
    profilePictureView.addSubview(profilePictureImageView)
    
    namesLabel.font = appStyle.textFontMedium
    namesLabel.textColor = appStyle.regularTextColor
    
    messageLabel.font = appStyle.textFontSmall
    messageLabel.textColor = appStyle.regularTextColor
    
    timestampLabel.font = appStyle.textFontSmall
    timestampLabel.textColor = appStyle.regularTextColor
    timestampLabel.textAlignment = .right
    timestampLabel.translatesAutoresizingMaskIntoConstraints = false
    
    namesAndMessageContainer.axis = .vertical
    namesAndMessageContainer.spacing = namesAndMessageContainerSpacing
    namesAndMessageContainer.translatesAutoresizingMaskIntoConstraints = false
    namesAndMessageContainer.addArrangedSubview(namesLabel)
    namesAndMessageContainer.addArrangedSubview(messageLabel)
    
    self.contentView.addSubview(profilePictureView)
    self.contentView.addSubview(namesAndMessageContainer)
    self.contentView.addSubview(timestampLabel)
    
    self.selectionStyle = .none
    
    profilePictureImageView.topAnchor.constraint(equalTo: profilePictureView.topAnchor).isActive = true
    profilePictureImageView.bottomAnchor.constraint(equalTo: profilePictureView.bottomAnchor).isActive = true
    profilePictureImageView.leadingAnchor.constraint(equalTo: profilePictureView.leadingAnchor).isActive = true
    profilePictureImageView.trailingAnchor.constraint(equalTo: profilePictureView.trailingAnchor).isActive = true
    
    cellContentLeadingConstraint = profilePictureView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
    cellContentLeadingConstraint.isActive = true
    
    profilePictureView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: cellContentTopMargin).isActive = true
    profilePictureView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -cellContentBottomMargin).isActive = true
    profilePictureView.widthAnchor.constraint(equalToConstant: profilePictureViewDiameter).isActive = true
    profilePictureView.heightAnchor.constraint(equalToConstant: profilePictureViewDiameter).isActive = true
    
    namesAndMessageContainer.topAnchor.constraint(equalTo: profilePictureView.topAnchor).isActive = true
    namesAndMessageContainer.leadingAnchor.constraint(equalTo: profilePictureView.trailingAnchor, constant: namesAndMessageContainerLeadingMargin).isActive = true
    namesAndMessageContainer.trailingAnchor.constraint(equalTo: timestampLabel.leadingAnchor, constant: -namesAndMessageContainerTrailingMargin).isActive = true
    
    timestampLabel.topAnchor.constraint(equalTo: profilePictureView.topAnchor).isActive = true
    
    cellContentTrailingConstraint = timestampLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
    cellContentTrailingConstraint.isActive = true
  }
  
  func setContentHorizontalMargin(to margin: CGFloat) {
    cellContentLeadingConstraint.constant = margin
    cellContentTrailingConstraint.constant = -margin
  }
  
  func updateContent(using latestMessage: ChatListMessage) {
    profilePictureImageView.downloadedFrom(link: t("/" + (latestMessage.pictureUrl ?? "[DEFAULT IMAGE]"))) { _ in
      self.timestamp = latestMessage.timestamp
      self.message = latestMessage.message
    }
  }
}
