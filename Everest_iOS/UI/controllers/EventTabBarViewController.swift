//
//  EventTabBarViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-07.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventTabBarViewController: UIViewController {
  override init(nibName: String?, bundle: Bundle?) {
    super.init(nibName: nibName, bundle: bundle)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    let eventNavigationController = UINavigationController()
    let eventFeedViewController = EventFeedViewController()
    let createEventViewController = CreateEventViewController()
    
    eventNavigationController.viewControllers = [eventFeedViewController]
  
    let test = UIView()
    
    test.translatesAutoresizingMaskIntoConstraints = false
    test.backgroundColor = .black
    self.view.addSubview(test)
    
    test.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    test.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    test.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    test.heightAnchor.constraint(equalToConstant: 60).isActive = true

    
  }
}
