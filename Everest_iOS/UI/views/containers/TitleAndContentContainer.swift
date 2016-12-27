//
//  TitleAndContentContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-05.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class TitleAndContentContainer: UIView {
  private enum contentType {
    case small
    case large
  }
  
  var contentViewHeightConstraint: NSLayoutConstraint!
  var contentViewTopConstraint: NSLayoutConstraint!
  private var contentViewContentType = contentType.small
  private let titleLabel = UILabel()
  private let contentView = UIView()
  
  var title: String? {
    get {
      return titleLabel.text
    }
    set {
      titleLabel.text = newValue
    }
  }
  var content: UIView? {
    get {
      if let contentSubview = contentView.subviews.first {
        return contentSubview
      } else {
        return nil
      }
    }
    set {
      if let newValue = newValue {
        contentView.subviews.forEach({$0.removeFromSuperview()})
        contentView.addSubview(newValue)
        if newValue is UITextView {
          contentViewContentType = .large
        } else {
          contentViewContentType = .small
        }
        setupDynamicConstraints()
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  convenience init(withTitle title: String, andContent content: UIView) {
    self.init(frame: .zero)
    
    self.title = title
    self.content = content
  }
  
  private func setup() {
    let appStyle = AppStyle.sharedInstance
    
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .byWordWrapping
    titleLabel.font = appStyle.textFontMedium
    titleLabel.textColor = UIColor.black.withAlphaComponent(0.3)
    
    self.addSubview(titleLabel)
    self.addSubview(contentView)
    
    setupStaticConstraints()
  }
  
  private func setupStaticConstraints() {
    self.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    content?.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    titleLabel.heightAnchor.constraint(equalToConstant: AppStyle.sharedInstance.baseInputTextFieldHeight).isActive = true
    
    contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
    contentViewTopConstraint.isActive = true
    contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: AppStyle.sharedInstance.baseInputTextFieldHeight)
    contentViewHeightConstraint.isActive = true
  }
  
  private func setupDynamicConstraints() {
    switch contentViewContentType {
    case .large:
      contentViewHeightConstraint.constant = AppStyle.sharedInstance.baseInputTextViewHeight
      break
    case .small:
      contentViewHeightConstraint.constant = AppStyle.sharedInstance.baseInputTextFieldHeight
      break
    }
    
    content?.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    content?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    content?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    content?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
  }
}
