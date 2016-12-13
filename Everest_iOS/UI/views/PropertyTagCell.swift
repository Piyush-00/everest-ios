//
//  PropertyTagCell.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-11.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class PropertyTagCell: UICollectionViewCell {
  
  private let propertyNameLabel = UILabel()
  
  var propertyName: String? {
    get {
      return propertyNameLabel.text
    } set {
      propertyNameLabel.text = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }
  
  func setupViews() {
    
    addSubview(propertyNameLabel)
    propertyNameLabel.translatesAutoresizingMaskIntoConstraints = false
    propertyNameLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width
    propertyNameLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    propertyNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    propertyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppStyle.sharedInstance.tagPropertyMargin/2).isActive = true
    
    propertyNameLabel.textColor = AppStyle.sharedInstance.regularTextColor
    propertyNameLabel.font = AppStyle.sharedInstance.headerFontSmall
    
    //SKU - Set Default tag color
    backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    self.layer.cornerRadius = 4
  }
  
  func setTagColor(_ color: UIColor) {
    backgroundColor = color
  }
}
