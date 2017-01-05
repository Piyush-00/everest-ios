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
  private var cellContentTrailingConstraint: NSLayoutConstraint!
  
  private let cellContentTopMargin: CGFloat = 10.0
  private let cellContentBottomMargin: CGFloat = 10.0
  private let nameAndContentContainerLeadingMargin: CGFloat = 10.0
  private let nameAndContentContainerSpacing: CGFloat = 5.0
  private let profilePictureViewDiameter: CGFloat = 40.0
  
  var person: ListPerson? {
    didSet {
      if let person = person {
        nameLabel.text = "\(person.firstName) \(person.lastName)"
        profilePictureImageView.image = person.picture
        contentLabel.text = person.content
      } else {
        nameLabel.text = nil
        profilePictureImageView.image = nil //TODO: set to default image
        contentLabel.text = nil
      }
    }
  }
  
  var picture: UIImage? {
    return profilePictureImageView.image
  }
  
  var name: String? {
    return nameLabel.text
  }
  
  var content: String? {
    return contentLabel.text
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
    profilePictureImageView.contentMode = .scaleAspectFill
    profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
    
    profilePictureView.layer.cornerRadius = profilePictureViewDiameter / 2.0
    profilePictureView.layer.masksToBounds = true
    profilePictureView.translatesAutoresizingMaskIntoConstraints = false
    profilePictureView.addSubview(profilePictureImageView)
    
    nameLabel.font = appStyle.textFontMedium
    nameLabel.textColor = appStyle.regularTextColor
    nameLabel.text = "testing"
    
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
    
    cellContentTrailingConstraint = nameAndContentContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
    cellContentTrailingConstraint.isActive = true
  }
  
  func setContentHorizontalMargin(to margin: CGFloat) {
    cellContentLeadingConstraint.constant = margin
    cellContentTrailingConstraint.constant = -margin
  }
}
