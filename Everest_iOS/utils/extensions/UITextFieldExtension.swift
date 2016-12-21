//
//  UITextFieldExtension.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-23.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

private var kAssociationKeyNextField: UInt8 = 0

extension UITextField {
  var nextField: UITextField? {
    get {
      return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
    }
    set(newField) {
      objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
    }
  }
  
  func clearText() {
    self.text = ""
  }
}
