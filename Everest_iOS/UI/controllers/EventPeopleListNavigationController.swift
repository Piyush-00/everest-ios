//
//  EventPeopleListNavigationController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-23.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

class EventPeopleListNavigationController: UINavigationController, EventContainerViewProtocol {
  private let eventPageTabButton = EventTabBarButtonView()
  
  override init(nibName: String?, bundle: Bundle?) {
    super.init(nibName: nibName, bundle: bundle)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    let eventPeopleListViewController = EventPeopleListViewController()
    
    self.viewControllers = [eventPeopleListViewController]
    
    self.navigationBar.backgroundColor = AppStyle.sharedInstance.eventNavigationBarBackgroundColor
    self.navigationBar.isTranslucent = false
    
    self.attachTabButton()
  }
  
  //MARK: EventContainerViewProtocol
  
  var viewController: UIViewController {
    return self
  }
  
  var tabButton: EventTabBarButtonView {
    return eventPageTabButton
  }
  
  var tabIcon: FontAwesome? {
    return FontAwesome.users
  }
  
  var navigationBarTitle: String? {
    return nil
  }
}
