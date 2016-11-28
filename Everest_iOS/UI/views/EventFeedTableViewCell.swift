//
//  EventFeedTableViewCell.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventFeedTableViewCell: UITableViewCell {
  private let nameLabel = UILabel()
  private let postContentLabel: UILabel = UILabel()
  private let timestampLabel = UILabel()
  
  private let profilePictureViewDiameter: CGFloat = 40.0
  private let cardViewVerticalMargin: CGFloat = 10.0
  private let cardViewWidthRatio: CGFloat = 0.9
  private let profilePictureTopMargin: CGFloat = 15.0
  private let profilePictureLeadingMargin: CGFloat = 10.0
  private let nameAndContentContainerLeadingMargin: CGFloat = 5.0
  private let nameAndContentVerticalMargin: CGFloat = 25.0
  private let nameAndContentContainerSpacing: CGFloat = 10.0
  private let nameAndContentContainerWidthRatio: CGFloat = 0.8
  private let timestampLabelTrailingMargin: CGFloat = 10.0
  var profilePictureImage = UIImage()
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
    self.backgroundColor = .red
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    let appStyle = AppStyle.sharedInstance
    
    name = "Laymes Lees"
    post = "Test post."
    timestamp = "16:55"
    
    let cardView = UIView()
    let profilePictureView = UIView()
    let profilePictureImageView = UIImageView(image: profilePictureImage)
    let nameAndContentContainerStackView = UIStackView()
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    cardView.backgroundColor = appStyle.eventFeedCardViewBackgroundColor
    cardView.layer.cornerRadius = 4.0
    cardView.layer.shadowPath = UIBezierPath(roundedRect: cardView.bounds, cornerRadius: 4.0).cgPath
    cardView.layer.shadowColor = UIColor.black.cgColor
    cardView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
    cardView.layer.shadowRadius = 2.0
    cardView.layer.shadowOpacity = 0.3
    self.contentView.addSubview(cardView)
    
    profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
    profilePictureImageView.clipsToBounds = true
    profilePictureImageView.contentMode = .scaleAspectFill
    profilePictureImageView.layer.masksToBounds = true
    
    profilePictureView.translatesAutoresizingMaskIntoConstraints = false
    profilePictureView.layer.cornerRadius = profilePictureViewDiameter / 2.0
    profilePictureView.layer.masksToBounds = true
    profilePictureView.backgroundColor = UIColor.blue
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
    
    cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: cardViewVerticalMargin).isActive = true
    cardView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -cardViewVerticalMargin).isActive = true
    cardView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    cardView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cardViewWidthRatio).isActive = true

    profilePictureView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: profilePictureTopMargin).isActive = true
    profilePictureView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: profilePictureLeadingMargin).isActive = true
    profilePictureView.widthAnchor.constraint(equalToConstant: profilePictureViewDiameter).isActive = true
    profilePictureView.heightAnchor.constraint(equalToConstant: profilePictureViewDiameter).isActive = true
    
    nameLabel.heightAnchor.constraint(equalToConstant: nameLabel.intrinsicContentSize.height).isActive = true
    postContentLabel.heightAnchor.constraint(equalToConstant: postContentLabel.intrinsicContentSize.height).isActive = true
    
    postContentLabel.backgroundColor = .purple
    profilePictureImageView.topAnchor.constraint(equalTo: profilePictureView.topAnchor).isActive = true
    profilePictureImageView.bottomAnchor.constraint(equalTo: profilePictureView.bottomAnchor).isActive = true
    profilePictureView.leadingAnchor.constraint(equalTo: profilePictureView.leadingAnchor).isActive = true
    profilePictureView.trailingAnchor.constraint(equalTo: profilePictureView.trailingAnchor).isActive = true
    
    nameAndContentContainerStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: nameAndContentVerticalMargin).isActive = true
    nameAndContentContainerStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -nameAndContentVerticalMargin).isActive = true
    nameAndContentContainerStackView.leadingAnchor.constraint(equalTo: profilePictureView.trailingAnchor, constant: nameAndContentContainerLeadingMargin).isActive = true
    nameAndContentContainerStackView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: nameAndContentContainerWidthRatio).isActive = true
    
    timestampLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -timestampLabelTrailingMargin).isActive = true
    timestampLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: nameAndContentVerticalMargin).isActive = true
  }
}
