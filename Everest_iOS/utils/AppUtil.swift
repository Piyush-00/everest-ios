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
  
  //SKO - following two methods used by RealmEvent model to convert attendeeCharacteristic array to a single string and vise-versa
  
  class func convertStringArrayToString(_ stringArray: [String], usingSeparator separator: String) -> String {
    return stringArray.joined(separator: separator)
  }
  
  class func convertStringToStringArray(_ string: String, usingSeparator separator: String) -> [String] {
    return string.components(separatedBy: separator)
  }
  
  //SKU - Format Date Appropriatley into string
  
  class func formatDateString(_ dateString: String) -> String{
    
    let dateFormatter = DateFormatter()
    let dateStringFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .iso8601)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    let dateISO = dateFormatter.date(from: dateString)
    

    dateStringFormatter.dateStyle = DateFormatter.Style.long
    dateStringFormatter.timeStyle = DateFormatter.Style.short
    if (dateISO != nil){
      let formattedString = dateStringFormatter.string(from: dateISO!)
      return formattedString
    } else {
      return ""
    }
  }
  
  class func formatISODate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .iso8601)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    return dateFormatter.string(from: Date())
  }
}
