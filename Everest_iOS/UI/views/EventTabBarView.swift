//
//  EventTabBarView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-16.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

protocol EventTabBarViewDelegate: class {
  func eventTabBar(_ eventTabBar: EventTabBarView, didTapTabButton tabButton: EventTabBarButtonView)
}

class EventTabBarView: UIView {
  private let tabStackView = UIStackView()
  private let popupStackView = UIStackView()
  
  var tabButtons: [EventTabBarButtonView] {
    var tabBarButtonArray: [EventTabBarButtonView] = []
  
    for tabBarButton in tabStackView.arrangedSubviews {
      guard let tabBarButton = tabBarButton as? EventTabBarButtonView else {
        return []
      }
      tabBarButtonArray.append(tabBarButton)
    }
    
    for tabBarButton in popupStackView.arrangedSubviews {
      guard let tabBarButton = tabBarButton as? EventTabBarButtonView else {
        return tabBarButtonArray
      }
      tabBarButtonArray.append(tabBarButton)
    }
    
    return tabBarButtonArray
  }
  
  private var currentTabBarButton: EventTabBarButtonView? {
    willSet {
      currentTabBarButton?.isSelected = false
    }
    didSet {
      currentTabBarButton?.isSelected = true
    }
  }
  
  weak var delegate: EventTabBarViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    tabStackView.axis = .horizontal
    tabStackView.spacing = 0
    tabStackView.distribution = .fillEqually
    
    popupStackView.axis = .vertical
    popupStackView.spacing = 0
    popupStackView.distribution = .fillEqually
    
    self.addSubview(tabStackView)
    self.addSubview(popupStackView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    tabStackView.translatesAutoresizingMaskIntoConstraints = false
    popupStackView.translatesAutoresizingMaskIntoConstraints = false
    
    tabStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    tabStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    tabStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    tabStackView.heightAnchor.constraint(equalToConstant: AppStyle.sharedInstance.tabBarButtonIconSize).isActive = true
    
    popupStackView.topAnchor.constraint(equalTo: tabStackView.bottomAnchor).isActive = true
    popupStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    popupStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    popupStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }
  
  func setupTabButtons(usingViewControllers viewControllers: [EventContainerViewProtocol]) {
    tabStackView.arrangedSubviews.forEach({tabStackView.removeArrangedSubview($0)})
    popupStackView.arrangedSubviews.forEach({popupStackView.removeArrangedSubview($0)})
    
    if viewControllers.count < 4 {
      for viewController in viewControllers {
        let tabBarButton = viewController.tabButton
        tabBarButton.addAction(#selector(didTapTabBarButton), to: self)
        tabStackView.addArrangedSubview(tabBarButton)
      }
    } else {
      var i = 0
      for viewController in viewControllers {
        let tabBarButton = viewController.tabButton
        if i < 4 {
          if i == 0 {
            tabBarButton.setIcon(to: FontAwesome.bars)
            tabBarButton.addAction(#selector(didTapHamburgerTabButton), to: self)
          } else {
            tabBarButton.addAction(#selector(didTapTabBarButton), to: self)
          }
          tabStackView.addArrangedSubview(tabBarButton)
        } else {
          popupStackView.addArrangedSubview(tabBarButton)
        }
        i += 1
      }
    }
  }
  
  func didTapTabBarButton(sender: UIButton) {
    guard let tabBarButton = sender.superview as? EventTabBarButtonView else {
      fatalError("fatal error: tabBarButton.button is not a subview of EventTabBarButtonView")
    }
    delegate?.eventTabBar(self, didTapTabButton: tabBarButton)
  }
  
  func didTapHamburgerTabButton(sender: UIButton) {
  
  }
}
