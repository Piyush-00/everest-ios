//
//  UIColorExtension.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-11.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

extension UIColor {
    //SKO - add UIColor initialization with rgb and hex values
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
  
    convenience init(hex:String) {
      //SKU - If the hex is in the wrong format, return white
      if (!hex.hasPrefix("#") || ((hex.count) != 7)) {
        self.init(red: 0, green: 0, blue: 0, alpha: 255)
      } else {
        
        let hexValue = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hexValue).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hexValue.count {
        case 3: // RGB (12-bit)
          (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
          (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
          (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
          (a, r, g, b) = (255, 0, 0, 0)
        }
      
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
      }
    }
  
    static func randomColor() -> UIColor {
      
      let red:CGFloat = .random()
      let green:CGFloat = .random()
      let blue:CGFloat = .random()
      return UIColor(red:red, green: green, blue: blue, alpha: 0.7)
    }
}
