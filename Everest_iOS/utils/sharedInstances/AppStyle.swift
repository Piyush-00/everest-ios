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
  let invalidColor = UIColor(hex:"#ff5b5b")
  let regularTextColor = UIColor.black
  let regularTextWhiteColor = UIColor.white
  let nativeStatusBarColor = UIColor.white
  
  let baseInputTextFieldHeight: CGFloat = 40
  let textFieldBackgroundColor = UIColor(netHex: 0xffffff)
  
  let baseInputTextViewHeight: CGFloat = 100
  let textViewBackgroundColor = UIColor(netHex: 0xffffff)
  
  let eventFeedCardViewBackgroundColor = UIColor.white
  
  let baseInputButtonColor = UIColor(netHex: 0xbd3333)
  let baseInputInActiveButtonColor = UIColor(netHex: 0x404040)
  let baseInputSecondaryButtonColor = UIColor(netHex: 0x0075c9)
  let baseInputButtonContainerHeight: CGFloat = 50
  
  let baseInputViewSideMargin: CGFloat = 32
  
  let headerContainerHeight: CGFloat = 90
  let headerViewContainerHeaderHeight: CGFloat = 131
  let QRCodeViewHeight: CGFloat = 225
  
  //SKU - Tag Property Attributes
  let tagPropertyHeight: CGFloat = 30
  let tagPropertyMargin: CGFloat = 40
  let tagPropertySpacing: CGFloat = 8
  
  //SKU - Header fonts
  let headerFontLargeBold = UIFont(name: "HelveticaNeue-Bold", size: 50)
  let headerFontLargeRegular = UIFont(name: "HelveticaNeue", size: 50)
  let headerFontLargerLight = UIFont(name: "HelveticaNeue-Light", size: 50)
  let headerFontLarge30Light = UIFont(name: "HelveticaNeue-Light", size: 30)
  let headerFontLarge25Light = UIFont(name: "HelveticaNeue-Light", size: 25)
  let headerFontSemiLarge = UIFont(name: "HelveticaNeue", size: 22.5)
  let headerFontMedium = UIFont(name: "HelveticaNeue-Light", size: 20)
  let headerFontSmall = UIFont(name: "HelveticaNeue-Light", size: 15)
  
  //SKU - General fonts
  let textFontLarge = UIFont(name: "HelveticaNeue-Bold", size: 20)
  let textFontSemiLarge = UIFont(name: "HelveticaNeue", size: 17)
  let textFontBold = UIFont(name: "HelveticaNeue-Bold", size: 15)
  let textFontMedium = UIFont(name: "HelveticaNeue", size: 15)
  let textFontSmallLight = UIFont(name: "HelveticaNeue-Light", size: 13)
  
  let textFontSmall = UIFont(name: "HelveticaNeue-Light", size: 12)
  let textFontSmallRegular = UIFont(name: "HelveticaNeue", size: 12)
  let textFontSmallBold = UIFont(name: "HelveticaNeue-Bold", size: 12)
  
  //SKU - stored images
  let pictureImageViewBorderColor = UIColor(netHex: 0x363636)
  let pictureImage = UIImage(named: "blank-profile-picture-take")
  let pictureImageWide = UIImage(named: "blank-profile-picture-take-wide")
  let scanningErrorImageRed = UIImage(named: "Invalid-QR-scan-image-red")
  
  let tabBarButtonIconSize: CGFloat = 30.0
  let tabBarButtonVerticalPadding:CGFloat = 10.0
  var tabBarHeight: CGFloat {
    return AppStyle.sharedInstance.tabBarButtonIconSize + 2*AppStyle.sharedInstance.tabBarButtonVerticalPadding
  }
  
  let eventNavigationBarBackgroundColor: UIColor = .white

  let highlightedColor = UIColor(netHex: 0x0075c9)
  let normalColor = UIColor(netHex: 0x7f7f7f)
  let selectedColor = UIColor(netHex: 0x4c4c4c)
  
  func baseInputButton() -> UIButton {
    let button = UIButton(type: .custom)
    button.setBackgroundImage(AppUtil.resizableImageWithColor(color: baseInputButtonColor), for: .normal)
    button.clipsToBounds = true
    button.layer.cornerRadius = 4.0
    button.titleLabel?.font = textFontBold
    return button
  }
  
  func eventSettingsActionSheet() -> UIAlertController {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    let cancelActionButton = UIAlertAction(title: NSLocalizedString("cancel button", comment: "event settings options"), style: .cancel)
    let logoutActionButton = UIAlertAction(title: NSLocalizedString("log out button", comment: "event settings options"), style: .default)
    { action in
      let landingViewController = LandingViewController()
      let navigationController = NavigationController()
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let window = appDelegate.window!
      
      navigationController.navigationBar.isHidden = true
      navigationController.viewControllers = [landingViewController]
      
      appDelegate.navigationController = navigationController
      
      Keychain.deleteEvent()
      
      window.rootViewController = navigationController
    }
    
    alertController.addAction(cancelActionButton)
    alertController.addAction(logoutActionButton)
    
    return alertController
  }
  
  func eventSettingsBarButtonItem(withTarget target: Any?, andAction action: Selector) -> UIBarButtonItem {
    
    let barButtonItem = UIBarButtonItem(image: UIImage.fontAwesomeIcon(name: .cog, textColor: UIColor.black, size: CGSize(width: tabBarButtonIconSize, height: tabBarButtonIconSize)), style: .plain, target: target, action: action)
    
    barButtonItem.tintColor = normalColor
    
    return barButtonItem
  }
}
