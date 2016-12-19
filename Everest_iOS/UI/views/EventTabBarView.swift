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
  private let tabContainer = UIView()
  private let tabStackView = UIStackView()
  private let popupContainer = UIView()
  private let popupStackView = UIStackView()
  private var topConstraint: NSLayoutConstraint?
  private var tabBarHamburgerButton: EventTabBarButtonView?
  private var _currentTabBarButton: EventTabBarButtonView? {
    willSet {
      _currentTabBarButton?.isSelected = false
    }
    didSet {
      if let currentTabBarButton = _currentTabBarButton {
        tabBarHamburgerButton?.isSelected = popupStackView.arrangedSubviews.contains(currentTabBarButton)
      }
      _currentTabBarButton?.isSelected = true
      if isTabPoppedUp {
        isTabPoppedUp = false
      }
    }
  }
  
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
  
  var currentTabBarButton: EventTabBarButtonView? {
    return _currentTabBarButton
  }
  
  var isTabPoppedUp: Bool = false {
    didSet {
      var topConstraintConstant: CGFloat
      var viewAnimationOption: UIViewAnimationOptions
      if isTabPoppedUp {
        topConstraintConstant = -self.bounds.height
        viewAnimationOption = .curveEaseIn
      } else {
        topConstraintConstant = -tabContainer.bounds.height
        viewAnimationOption = .curveEaseOut
      }
      topConstraint?.constant = topConstraintConstant
      UIView.animate(withDuration: 0.2, delay: 0, options: viewAnimationOption, animations: {
        self.superview?.layoutIfNeeded()
      }, completion: nil)
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
    tabContainer.backgroundColor = AppStyle.sharedInstance.backgroundColor
    tabContainer.addSubview(tabStackView)
    
    popupContainer.backgroundColor = .white
    popupContainer.clipsToBounds = false
    popupContainer.addSubview(popupStackView)
    
    tabStackView.axis = .horizontal
    tabStackView.spacing = 0
    tabStackView.distribution = .fillEqually
    
    popupStackView.axis = .vertical
    popupStackView.spacing = 0
    popupStackView.distribution = .fillEqually
    
    self.addSubview(tabContainer)
    self.addSubview(popupContainer)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    tabContainer.translatesAutoresizingMaskIntoConstraints = false
    popupContainer.translatesAutoresizingMaskIntoConstraints = false
    tabStackView.translatesAutoresizingMaskIntoConstraints = false
    popupStackView.translatesAutoresizingMaskIntoConstraints = false
    
    tabContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    tabContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    tabContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    
    popupContainer.topAnchor.constraint(equalTo: tabContainer.bottomAnchor).isActive = true
    popupContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    popupContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    popupContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
    tabStackView.topAnchor.constraint(equalTo: tabContainer.topAnchor).isActive = true
    tabStackView.bottomAnchor.constraint(equalTo: tabContainer.bottomAnchor).isActive = true
    tabStackView.leadingAnchor.constraint(equalTo: tabContainer.leadingAnchor).isActive = true
    tabStackView.trailingAnchor.constraint(equalTo: tabContainer.trailingAnchor).isActive = true
    
    popupStackView.topAnchor.constraint(equalTo: popupContainer.topAnchor).isActive = true
    popupStackView.leadingAnchor.constraint(equalTo: popupContainer.leadingAnchor).isActive = true
    popupStackView.trailingAnchor.constraint(equalTo: popupContainer.trailingAnchor).isActive = true
    popupStackView.bottomAnchor.constraint(equalTo: popupContainer.bottomAnchor).isActive = true
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
        if i < 3 {
          if i == 0 {
            tabBarHamburgerButton = EventTabBarButtonView()
            tabBarHamburgerButton!.setIcon(to: FontAwesome.bars)
            tabBarHamburgerButton!.addAction(#selector(didTapHamburgerTabButton), to: self)
            tabStackView.addArrangedSubview(tabBarHamburgerButton!)
          }
          tabBarButton.addAction(#selector(didTapTabBarButton), to: self)
          tabStackView.addArrangedSubview(tabBarButton)
        } else {
          tabBarButton.addAction(#selector(didTapTabBarButton), to: self)
          popupStackView.addArrangedSubview(tabBarButton)
        }
        i += 1
      }
    }
  }
  
  func setCurrentTabBarButton(to tabBarButton: EventTabBarButtonView?) {
    _currentTabBarButton = tabBarButton
  }
  
  func didTapTabBarButton(sender: UIButton) {
    guard let tabBarButton = sender.superview as? EventTabBarButtonView else {
      fatalError("fatal error: tabBarButton.button is not a subview of EventTabBarButtonView")
    }
    setCurrentTabBarButton(to: tabBarButton)
    delegate?.eventTabBar(self, didTapTabButton: tabBarButton)
  }
  
  func didTapHamburgerTabButton(sender: UIButton) {
    isTabPoppedUp = !isTabPoppedUp
  }
  
  func position(in superView: UIView) {
    self.translatesAutoresizingMaskIntoConstraints = false
    
    topConstraint = self.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: -AppStyle.sharedInstance.tabBarButtonIconSize)
    topConstraint?.isActive = true
    
    self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
    self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
  }
}
