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
  
  var viewController: EventContainerViewProtocol? {
    return _viewController
  }
  
  var icon: UIImage? {
    return button.image(for: .normal)
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
    self.addSubview(button)
    setupConstraints()
  }
  
  private func setupConstraints() {
    button.translatesAutoresizingMaskIntoConstraints = false
    button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
  }
  
  func setViewController(to viewController: EventContainerViewProtocol?) {
    _viewController = viewController
    setIcon(to: viewController?.tabIcon)
  }
  
  func setIcon(to iconString: String?) {
    if let iconString = iconString {
      let iconImageNormal = UIImage.fontAwesomeIcon(code: iconString, textColor: UIColor.black.withAlphaComponent(0.5), size: iconSize)
      let iconImageFocused = UIImage.fontAwesomeIcon(code: iconString, textColor: UIColor.black.withAlphaComponent(0.7), size: iconSize)
      button.setImage(iconImageNormal, for: .normal)
      button.setImage(iconImageFocused, for: .focused)
    } else {
      button.setImage(nil, for: .normal)
      button.setImage(nil, for: .focused)
    }
  }
  
  func addAction(_ action: Selector, to target: Any?) {
    button.addTarget(target, action: action, for: .touchUpInside)
  }
}
