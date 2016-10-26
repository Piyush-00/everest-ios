//
//  AppStyle.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-23.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation
import UIKit

class AppStyle {
    static let sharedInstance = AppStyle()
    
    let backgroundColor = UIColor(netHex: 0xe6e6e6)
    let textColor = UIColor(netHex: 0x1a1a1a)
    let textFieldBackgroundColor = UIColor(netHex: 0xffffff)
    let textViewBackgroundColor = UIColor(netHex: 0xffffff)
    
    let baseInputButtonColor = UIColor(netHex: 0xbd3333)
    
    let headerFontLarge = UIFont(name: "HelveticaNeue-Bold", size: 50)
    let headerFontMedium = UIFont(name: "HelveticaNeue-Light", size: 20)
    let textFontBold = UIFont(name: "HelveticaNeue-Bold", size: 15)
    
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
