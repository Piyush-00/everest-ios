//
//  EventContainerViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-07.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

protocol EventContainerViewProtocol {
  var viewController: UIViewController {get}
  var tabButton: EventTabBarButtonView {get}
  var tabIcon: FontAwesome? {get}
  var navigationBarTitle: String? {get}
}

extension EventContainerViewProtocol {
  func attachTabButton() {
    tabButton.setViewController(to: viewController as? EventContainerViewProtocol)
  }
}

class EventContainerViewController: UIViewController, EventTabBarViewDelegate {
  private var eventTabBar = EventTabBarView()
  var viewControllers: [EventContainerViewProtocol] = [] {
    didSet {
      eventTabBar.setupTabButtons(usingViewControllers: viewControllers)
    }
  }
  
  private var _currentViewController: EventContainerViewProtocol? {
    willSet {
      
    }
    didSet {
      
    }
  }
  
  var currentViewController: EventContainerViewProtocol? {
    return _currentViewController
  }
  
  override init(nibName: String?, bundle: Bundle?) {
    super.init(nibName: nibName, bundle: bundle)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    let testVC1 = EventFeedViewController()
    let testVC2 = EventFeedViewController()
    let testVC3 = EventFeedViewController()
    let testVC4 = EventFeedViewController()
    
    eventTabBar.delegate = self
    
    viewControllers = [testVC1, testVC2, testVC3, testVC4]
    setCurrentViewController(to: viewControllers.first)
    
    self.view.addSubview(eventTabBar)
    setupConstraints()
  }
  
  private func setupConstraints() {
    eventTabBar.translatesAutoresizingMaskIntoConstraints = false
    
    eventTabBar.topAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor, constant: -AppStyle.sharedInstance.tabBarButtonIconSize).isActive = true
    eventTabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    eventTabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }
  
  //TODO: implement check to see if viewController is in viewControllers
  func setCurrentViewController(to viewController: EventContainerViewProtocol?) {
    eventTabBar.setCurrentTabBarButton(to: viewController?.tabButton)
    _currentViewController = viewController
  }
  
  //MARK: EventTabBarViewDelegate
  func eventTabBar(_ eventTabBar: EventTabBarView, didTapTabButton tabButton: EventTabBarButtonView) {
    _currentViewController = tabButton.viewController
  }
}
