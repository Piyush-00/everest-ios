//
//  EventFeedTableViewCell.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventFeedTableViewCell: UITableViewCell {
  private let nameAndContentContainerStackView = UIStackView()
  private let profilePictureImageView = UIImageView()
  private let nameLabel = UILabel()
  private let postContentLabel = UILabel()
  private let timestampLabel = UILabel()
  private var nameLabelHeightConstraint: NSLayoutConstraint?
  private var postContentLabelHeightConstraint: NSLayoutConstraint?
  
  private let profilePictureViewDiameter: CGFloat = 40.0
  private let cardViewWidthRatio: CGFloat = 0.9
  private let cardViewHeightRatio: CGFloat = 0.9
  private let profilePictureTopMargin: CGFloat = 15.0
  private let profilePictureLeadingMargin: CGFloat = 10.0
  private let nameAndContentContainerLeadingMargin: CGFloat = 10.0
  private let nameAndContentContainerTrailingMargin: CGFloat = 60.0
  private let nameAndContentVerticalMargin: CGFloat = 25.0
  private let nameAndContentContainerSpacing: CGFloat = 10.0
  private let timestampLabelTrailingMargin: CGFloat = 20.0
  var profilePictureImage: UIImage? {
    get {
      return profilePictureImageView.image
    }
    set {
      profilePictureImageView.image = newValue
    }
  }
  var name: String? {
    get {
      return nameLabel.text
    } set {
      nameLabel.text = newValue
    }
  }
  var post: String? {
    get {
      return postContentLabel.text
    } set {
      postContentLabel.text = newValue
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
    
    let cardView = UIView()
    let profilePictureView = UIView()
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    cardView.backgroundColor = appStyle.eventFeedCardViewBackgroundColor
    cardView.layer.cornerRadius = 4.0

    self.contentView.addSubview(cardView)
    self.backgroundColor = .clear
    self.selectionStyle = .none
    
    profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
    profilePictureImageView.clipsToBounds = true
    profilePictureImageView.contentMode = .scaleAspectFill
    profilePictureImageView.layer.masksToBounds = true
    
    profilePictureView.translatesAutoresizingMaskIntoConstraints = false
    profilePictureView.layer.cornerRadius = profilePictureViewDiameter / 2.0
    profilePictureView.layer.masksToBounds = true
    profilePictureView.clipsToBounds = true
    profilePictureView.addSubview(profilePictureImageView)
    cardView.addSubview(profilePictureView)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.text = name
    nameLabel.font = appStyle.textFontMedium
    nameLabel.textColor = appStyle.regularTextColor
    
    postContentLabel.translatesAutoresizingMaskIntoConstraints = false
    postContentLabel.font = appStyle.textFontSmall
    postContentLabel.textColor = appStyle.regularTextColor
    postContentLabel.numberOfLines = 0
    postContentLabel.lineBreakMode = .byWordWrapping
    
    nameAndContentContainerStackView.axis = .vertical
    nameAndContentContainerStackView.spacing = nameAndContentContainerSpacing
    nameAndContentContainerStackView.translatesAutoresizingMaskIntoConstraints = false
    
    nameAndContentContainerStackView.addArrangedSubview(nameLabel)
    nameAndContentContainerStackView.addArrangedSubview(postContentLabel)
    cardView.addSubview(nameAndContentContainerStackView)
    
    timestampLabel.translatesAutoresizingMaskIntoConstraints = false
    timestampLabel.font = appStyle.textFontSmall
    timestampLabel.textColor = appStyle.regularTextColor
    timestampLabel.textAlignment = .right
    cardView.addSubview(timestampLabel)
    
    cardView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    cardView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cardViewWidthRatio).isActive = true
    cardView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: cardViewHeightRatio).isActive = true

    profilePictureView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: profilePictureTopMargin).isActive = true
    profilePictureView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: profilePictureLeadingMargin).isActive = true
    profilePictureView.widthAnchor.constraint(equalToConstant: profilePictureViewDiameter).isActive = true
    profilePictureView.heightAnchor.constraint(equalToConstant: profilePictureViewDiameter).isActive = true
  
    profilePictureImageView.topAnchor.constraint(equalTo: profilePictureView.topAnchor).isActive = true
    profilePictureImageView.bottomAnchor.constraint(equalTo: profilePictureView.bottomAnchor).isActive = true
    profilePictureImageView.leadingAnchor.constraint(equalTo: profilePictureView.leadingAnchor).isActive = true
    profilePictureImageView.trailingAnchor.constraint(equalTo: profilePictureView.trailingAnchor).isActive = true
    
    nameAndContentContainerStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: nameAndContentVerticalMargin).isActive = true
    nameAndContentContainerStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -nameAndContentVerticalMargin).isActive = true
    nameAndContentContainerStackView.leadingAnchor.constraint(equalTo: profilePictureView.trailingAnchor, constant: nameAndContentContainerLeadingMargin).isActive = true
    nameAndContentContainerStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -nameAndContentContainerTrailingMargin).isActive = true
    
    timestampLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -timestampLabelTrailingMargin).isActive = true
    timestampLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: nameAndContentVerticalMargin).isActive = true
  }
}
