//
//  ChatViewCell.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-17.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class ChatViewCell: UITableViewCell {
  
  var profilePictureImageView = UIImageView()

  private let contentStackView = UIStackView()
  private let nameLabel = UILabel()
  private let postContentLabel = UILabel()
  private let timestampLabel = UILabel()
  private let profilePictureView = UIView()
  private let cardView = UIView()
  
  //SKU - Constants Related to chat view
  private let profilePictureViewDiameter: CGFloat = 40.0
  private let cardViewDimensionRatio: CGFloat = 0.95
  private let profilePictureMargin: CGFloat = 5.0
  private let nameAndContentContainerLeadingMargin: CGFloat = 10.0
  private let nameAndContentContainerSpacing: CGFloat = 5.0
  private let timestampLabelTrailingMargin: CGFloat = 20.0
  
  //SKU - Getters and Setters for Cell properties/Attributes
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
  var timeStamp: String? {
    get {
      return timestampLabel.text
    } set {
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
    cardView.backgroundColor = AppStyle.sharedInstance.eventFeedCardViewBackgroundColor
    
    self.contentView.addSubview(cardView)
    self.backgroundColor = .clear
    self.selectionStyle = .none
    
    postContentLabel.font = AppStyle.sharedInstance.headerFontSmall
    postContentLabel.textColor = AppStyle.sharedInstance.regularTextColor
    postContentLabel.numberOfLines = 0
    postContentLabel.lineBreakMode = .byWordWrapping
    
    contentStackView.axis = .vertical
    contentStackView.spacing = nameAndContentContainerSpacing
  
    contentStackView.addArrangedSubview(postContentLabel)
    cardView.addSubview(contentStackView)
    
    setupBaseViewConstraints()
  }
  
  private func setupBaseViewConstraints() {
    cardView.translatesAutoresizingMaskIntoConstraints = false
    cardView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    cardView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cardViewDimensionRatio).isActive = true
    cardView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: cardViewDimensionRatio).isActive = true
    
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: profilePictureMargin).isActive = true
    contentStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
    contentStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: profilePictureViewDiameter + nameAndContentContainerLeadingMargin + 5).isActive = true
    contentStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -timestampLabelTrailingMargin).isActive = true
  }
  
  func renderInitialPostComps() {
    profilePictureImageView.clipsToBounds = true
    profilePictureImageView.contentMode = .scaleAspectFill
    profilePictureImageView.layer.masksToBounds = true

    profilePictureView.layer.cornerRadius = profilePictureViewDiameter / 2.0
    profilePictureView.layer.masksToBounds = true
    profilePictureView.clipsToBounds = true
    profilePictureView.addSubview(profilePictureImageView)
    cardView.addSubview(profilePictureView)
    
    nameLabel.text = name
    nameLabel.font = AppStyle.sharedInstance.textFontBold
    nameLabel.textColor = AppStyle.sharedInstance.regularTextColor
    
    contentStackView.removeArrangedSubview(postContentLabel)
    contentStackView.addArrangedSubview(nameLabel)
    contentStackView.addArrangedSubview(postContentLabel)

    timestampLabel.font = AppStyle.sharedInstance.textFontSmall
    timestampLabel.textColor = AppStyle.sharedInstance.regularTextColor
    timestampLabel.textAlignment = .right
    cardView.addSubview(timestampLabel)
    
    setupInitialCompConstraints()
  }
  
  private func setupInitialCompConstraints() {
    profilePictureView.translatesAutoresizingMaskIntoConstraints = false
    profilePictureView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: profilePictureMargin).isActive = true
    profilePictureView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: profilePictureMargin).isActive = true
    profilePictureView.widthAnchor.constraint(equalToConstant: profilePictureViewDiameter).isActive = true
    profilePictureView.heightAnchor.constraint(equalToConstant: profilePictureViewDiameter).isActive = true
    
    profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
    profilePictureImageView.topAnchor.constraint(equalTo: profilePictureView.topAnchor).isActive = true
    profilePictureImageView.bottomAnchor.constraint(equalTo: profilePictureView.bottomAnchor).isActive = true
    profilePictureImageView.leadingAnchor.constraint(equalTo: profilePictureView.leadingAnchor).isActive = true
    profilePictureImageView.trailingAnchor.constraint(equalTo: profilePictureView.trailingAnchor).isActive = true
    
    timestampLabel.translatesAutoresizingMaskIntoConstraints = false
    timestampLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -timestampLabelTrailingMargin).isActive = true
    timestampLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: profilePictureMargin).isActive = true
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
  }
}
