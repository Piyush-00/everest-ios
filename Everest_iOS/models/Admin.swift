//
//  Admin.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-05.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class Admin: Person {
  private var _description: String?
  
  var description: String? {
    return _description
  }
  
  func setDescription(to description: String?) {
    _description = description
  }
}
