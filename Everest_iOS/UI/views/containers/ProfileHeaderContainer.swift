//
//  ProfileHeaderContainer.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-22.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class ProfileHeaderContainer: UIView {
  
  var picture: UIImageView
  private var imageSize: CGFloat
  
  
  init(_ pictureSize: CGFloat = 100, coder: NSCoder? = nil) {
    self.picture = UIImageView()
    self.imageSize = pictureSize
    
    if let coder = coder {
      super.init(coder: coder)!
    } else {
      super.init(frame: CGRect.zero)
    }
    
    addSubview(picture)

  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(coder: aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    setupConstraints()
  }
  
  private func setupConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    self.picture.translatesAutoresizingMaskIntoConstraints = false
    
    self.picture.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    self.picture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    self.picture.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
    self.picture.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
    self.picture.layer.cornerRadius = imageSize/2
    self.picture.clipsToBounds = true
    self.picture.contentMode = .scaleAspectFill
    self.picture.layer.masksToBounds = true
    
  }
  
  func getPictureSize() -> CGFloat{
    return imageSize
  }
  
  func setPictureBorder(borderWidth: CGFloat = 1, borderColor: UIColor = UIColor(netHex: 0x000000)){
    self.picture.layer.borderWidth = borderWidth
    self.picture.layer.borderColor = borderColor.cgColor
  }
  
  
}
