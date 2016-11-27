//
//  EventFeedTableViewCell.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventFeedTableViewCell: UITableViewCell {
  private let profilePictureViewDiameter: CGFloat = 20.0
  let profilePictureImage: UIImage?
  let name: String?
  let post: String?
  let timestamp: String?
  
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
    let profilePictureImageView = UIImageView(image: profilePictureImage)
    let nameLabel = UILabel()
    let postContentLabel = UILabel()
    let timeLabel = UILabel()
    
    cardView.backgroundColor = appStyle.eventFeedCardViewBackgroundColor
    cardView.layer.cornerRadius = 4.0
    
    profilePictureView.layer.cornerRadius = profilePictureViewDiameter / 2.0
    profilePictureView.layer.masksToBounds = true
    profilePictureView.addSubview(profilePictureImageView)
    
    nameLabel.text = name
    nameLabel.font = appStyle.textFontMedium
    nameLabel.textColor = appStyle.regularTextColor
    
    postContentLabel.text = post
    postContentLabel.font = appStyle.textFontSmall
    postContentLabel.numberOfLines = 0
    postContentLabel.lineBreakMode = .byWordWrapping

    
    
  }
  
  private func setupConstraints() {
    
  }
}
