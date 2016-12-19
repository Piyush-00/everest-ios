//
//  EventTabBarButtonView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-16.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

class EventTabBarButtonView: UIView {
  private let button = UIButton()
  private let iconSize: CGSize = CGSize(width: AppStyle.sharedInstance.tabBarButtonIconSize, height: AppStyle.sharedInstance.tabBarButtonIconSize)
  
  private var _viewController: EventContainerViewProtocol?
  private var _icon: FontAwesome?
  
  private var iconColorNormal: UIColor {
    return UIColor.black.withAlphaComponent(0.5)
  }
  private var iconColorSelected: UIColor {
    return UIColor.black.withAlphaComponent(0.7)
  }
  
  var viewController: EventContainerViewProtocol? {
    return _viewController
  }
  
  var icon: FontAwesome? {
    return _icon
  }
  
  var isSelected: Bool = false {
    didSet {
      guard let icon = _icon else {
        return
      }
      let iconColorState: UIColor = isSelected ? iconColorSelected : iconColorNormal
      let iconImage = UIImage.fontAwesomeIcon(name: icon, textColor: iconColorState, size: iconSize)
      button.setImage(iconImage, for: .normal)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    self.sideBorder(side: .bottom, width: 1.0, colour: UIColor.black.withAlphaComponent(0.5))
    self.addSubview(button)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    button.translatesAutoresizingMaskIntoConstraints = false
    button.topAnchor.constraint(equalTo: self.topAnchor, constant: AppStyle.sharedInstance.tabBarButtonVerticalPadding).isActive = true
    button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -AppStyle.sharedInstance.tabBarButtonVerticalPadding).isActive = true
    button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
  }
  
  func setViewController(to viewController: EventContainerViewProtocol?) {
    _viewController = viewController
    setIcon(to: viewController?.tabIcon)
  }
  
  func setIcon(to icon: FontAwesome?) {
    if let icon = icon {
      let iconImageNormal = UIImage.fontAwesomeIcon(name: icon, textColor: iconColorNormal, size: iconSize)
      button.setImage(iconImageNormal, for: .normal)
    } else {
      button.setImage(nil, for: .normal)
    }
    
    _icon = icon
  }
  
  func addAction(_ action: Selector, to target: Any?) {
    button.addTarget(target, action: action, for: .touchUpInside)
  }
}
