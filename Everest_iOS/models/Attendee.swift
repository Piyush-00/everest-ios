//
//  Attendee.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-05.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class Attendee: Person {
  private var _characteristics: Dictionary<String, [String]>?
  
  var characteristics: Dictionary<String, [String]>? {
    return _characteristics
  }
  
  func setCharacteristics(to characteristics: Dictionary<String, [String]>?) {
    _characteristics = characteristics
  }
}
