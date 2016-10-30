//
//  AppStyle.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-23.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation
import UIKit

//SKO - all of the app's UI Styles and general components should be defined here
class AppStyle {
    static let sharedInstance = AppStyle()
    
    let backgroundColor = UIColor(netHex: 0xe6e6e6)
    let textColor = UIColor(netHex: 0x1a1a1a)
    let textFieldBackgroundColor = UIColor(netHex: 0xffffff)
    let textViewBackgroundColor = UIColor(netHex: 0xffffff)
    
    let baseInputButtonColor = UIColor(netHex: 0xbd3333)
    let baseInputSecondaryButtonColor = UIColor(netHex: 0x0075c9)
  
    //SKU - Header fonts
    let headerFontLarge = UIFont(name: "HelveticaNeue-Bold", size: 50)
    let headerFontSemiLarge = UIFont(name: "HelveticaNeue", size: 22.5)
    let headerFontMedium = UIFont(name: "HelveticaNeue-Light", size: 20)
    let headerFontSmall = UIFont(name: "HelveticaNeue-Light", size: 15)
  
    //SKU - General fonts
    let textFontLarge = UIFont(name: "HelveticaNeue-Bold", size: 20)
    let textFontSemiLarge = UIFont(name: "HelveticaNeue", size: 17)
    let textFontBold = UIFont(name: "HelveticaNeue-Bold", size: 15)
    let textFontMedium = UIFont(name: "HelveticaNeue", size: 15)
    let textFontSmall = UIFont(name: "HelveticaNeue-Light", size: 12)
  
  
    let pictureImageViewBorderColor = UIColor(netHex: 0x363636)
    let pictureImage = UIImage(named: "blank-profile-picture-take")
    let pictureImageWide = UIImage(named: "blank-profile-picture-take-wide")
    
    func baseInputButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(AppUtil.resizableImageWithColor(color: baseInputButtonColor), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 4.0
        button.titleLabel?.font = textFontBold
        return button
    }
}
