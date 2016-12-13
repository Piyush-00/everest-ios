//
//  CGFloatExtension.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-12.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

extension CGFloat {
  static func random() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
  }
}
