//
//  TitleAndContentContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-05.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class TitleAndContentContainer: UIView {
  enum contentType {
    case label
    case textField
    case textView
    case other
  }
  
  private var contentViewContentType: contentType
  var title: String? {
    get {
      return self.title
    }
    set {
      titleLabel.text = newValue
    }
  }
  private let titleLabel: UILabel
  private var contentView: UIView {
    get {
      return self.contentView
    }
    set {
      if newValue is UILabel {
        contentViewContentType = .label
      } else if newValue is UITextField {
        contentViewContentType = .textField
      } else if newValue is UITextView {
        contentViewContentType = .textView
      } else {
        contentViewContentType = .other
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
    self.contentView = content
  }
  
  func setup() {
    
  }
  
  func setupConstraints() {
    
  }

}
