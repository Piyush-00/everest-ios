//
//  AppUtil.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-23.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation
import UIKit

//SKO - implement any general utility methods here
class AppUtil {
  class func resizableImageWithColor(color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 1.0, height: 1.0), false, UIScreen.main.scale)
    var resizableImage = UIImage()
    if let context = UIGraphicsGetCurrentContext() {
      color.set()
      context.fill(CGRect(x: 0, y: 0, width: 1.0, height: 1.0))
      resizableImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: .zero, resizingMode: .tile) ?? resizableImage
      UIGraphicsEndImageContext()
    }
    return resizableImage
  }
  
  class func convertStringArrayToString(_ stringArray: [String], usingSeparator separator: String) -> String {
    return stringArray.joined(separator: separator)
  }
  
  class func convertStringToStringArray(_ string: String, usingSeparator separator: String) -> [String] {
    return string.components(separatedBy: separator)
  }
}
