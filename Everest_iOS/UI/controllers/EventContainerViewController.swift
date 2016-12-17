//
//  EventContainerViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-07.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

protocol EventContainerViewProtocol {
  var tabIcon: String? {get}
  var navigationBarTitle: String? {get}
}

class EventContainerViewController: UIViewController, EventTabBarViewDelegate {
  private var eventTabBar = EventTabBarView()
  var viewControllers: [EventContainerViewProtocol] = [] {
    didSet {
      
      eventTabBar.setupTabButtons(usingViewControllers: viewControllers)
    }
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
    let eventFeedViewController = EventFeedViewController()
    let createEventViewController = CreateEventViewController()
    let eventConfirmVC = EventConfirmationViewController()
    let eventDescription = AdminDescriptionFormViewController()
    
    viewControllers = [eventFeedViewController]
    
    self.view.addSubview(eventTabBar)
    setupConstraints()
  }
  
  private func setupConstraints() {
    eventTabBar.translatesAutoresizingMaskIntoConstraints = false
    
    eventTabBar.topAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor, constant: -AppStyle.sharedInstance.tabBarButtonIconSize).isActive = true
    eventTabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    eventTabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }
  
  //MARK: EventTabBarViewDelegate
  func eventTabBar(_ eventTabBar: EventTabBarView, didTapTabButton: EventTabBarButtonView) {
    print("tapped")
  }
}
