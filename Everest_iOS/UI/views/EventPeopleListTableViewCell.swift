//
//  EventPeopleListTableViewCell.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-23.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventPeopleListTableViewCell: UITableViewCell {
  private let nameAndContentContainer = UIStackView()
  private let profilePictureImageView = UIImageView()
  private let nameLabel = UILabel()
  private let contentLabel = UILabel()
  
  private var cellContentLeadingConstraint: NSLayoutConstraint!
  
  var person: Person?
  
  private let cellContentTopMargin: CGFloat = 10.0
  private let cellContentBottomMargin: CGFloat = 10.0
  private let nameAndContentContainerLeadingMargin: CGFloat = 10.0
  private let nameAndContentContainerSpacing: CGFloat = 5.0
  private let profilePictureViewDiameter: CGFloat = 40.0
  
  var picture: UIImage? {
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
    }
    set {
      nameLabel.text = newValue
    }
  }
  
  var content: String? {
    get {
      return contentLabel.text
    }
    set {
      contentLabel.text = newValue
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
    profilePictureView.layer.borderColor = UIColor.black.cgColor
    profilePictureView.layer.borderWidth = 1.0
    
    nameLabel.font = appStyle.textFontMedium
    nameLabel.textColor = appStyle.regularTextColor
    
    contentLabel.font = appStyle.textFontSmall
    contentLabel.textColor = appStyle.regularTextColor
    
    nameAndContentContainer.axis = .vertical
    nameAndContentContainer.spacing = nameAndContentContainerSpacing
    nameAndContentContainer.translatesAutoresizingMaskIntoConstraints = false
    nameAndContentContainer.addArrangedSubview(nameLabel)
    nameAndContentContainer.addArrangedSubview(contentLabel)
    
    self.contentView.addSubview(profilePictureView)
    self.contentView.addSubview(nameAndContentContainer)
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
    
    nameAndContentContainer.topAnchor.constraint(equalTo: profilePictureView.topAnchor).isActive = true
    nameAndContentContainer.leadingAnchor.constraint(equalTo: profilePictureView.trailingAnchor, constant: nameAndContentContainerLeadingMargin).isActive = true
  }
  
  func setContentLeadingMargin(to leadingMargin: CGFloat) {
    cellContentLeadingConstraint.constant = leadingMargin
  }
}
