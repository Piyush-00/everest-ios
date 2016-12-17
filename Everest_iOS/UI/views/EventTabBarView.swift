//
//  EventTabBarView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-16.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

protocol EventTabBarViewDelegate: class {
  func eventTabBar(_ eventTabBar: EventTabBarView, didTapTabButton: EventTabBarButtonView)
}

class EventTabBarView: UIView {
  private let tabStackView = UIStackView()
  private let popupStackView = UIStackView()
  
  var tabButtons: [EventTabBarButtonView] {
    var tabBarButtonArray: [EventTabBarButtonView] = []
  
    for tabBarButton in tabStackView.arrangedSubviews {
      if tabBarButton == tabStackView.arrangedSubviews.first {
        continue
      }
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
    
    popupStackView.axis = .vertical
    popupStackView.spacing = 0
    
    self.addSubview(tabStackView)
    self.addSubview(popupStackView)
    tabStackView.backgroundColor = .red
    
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
    
    if viewControllers.count < 5 {
      for viewController in viewControllers {
        let tabBarButton = EventTabBarButtonView()
        tabBarButton.setViewController(to: viewController)
        tabBarButton.addAction(#selector(didTapTabBarButton), to: self)
        tabStackView.addArrangedSubview(tabBarButton)
      }
    } else {
      var i = 0
      for viewController in viewControllers {
        let tabBarButton = EventTabBarButtonView()
        if i < 4 {
          if i == 0 {
            tabBarButton.setIcon(to: String.fontAwesomeIcon(name: .bars))
            tabBarButton.addAction(#selector(didTapHamburgerTabButton), to: self)
          } else {
            tabBarButton.setViewController(to: viewController)
            tabBarButton.addAction(#selector(didTapTabBarButton), to: self)
          }
          tabStackView.addArrangedSubview(tabBarButton)
        } else {
          tabBarButton.setViewController(to: viewController)
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
