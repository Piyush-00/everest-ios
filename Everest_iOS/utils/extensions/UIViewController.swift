//
//  UIViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-25.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKU
/* You can simply activate this function on any view controllers high level if required.
 
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
  }
 
*/

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    if view != nil {
      view.endEditing(true)
    }
  }
}
