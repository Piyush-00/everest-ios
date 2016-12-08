//
//  EventTabBarViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-07.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventTabBarViewController: UITabBarController {
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
    
    eventNavigationController.viewControllers = [eventFeedViewController]
    
    self.viewControllers = [eventNavigationController]
  }
}
