//
//  Person.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-24.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class Person {
  private var _name: String?
  private var _picture: UIImage?
  
  var name: String? {
    return _name
  }
  
  var picture: UIImage? {
    return _picture
  }
  
  func setName(to name: String?) {
    _name = name
  }
  
  func setPicture(to picture: UIImage?) {
    _picture = picture
  }
}
