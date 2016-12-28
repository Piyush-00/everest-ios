//
//  EventChatNavigationController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-19.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

class EventChatNavigationController: UINavigationController, EventContainerViewProtocol {
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
    let eventChatListViewController = EventChatListViewController()
    
    self.viewControllers = [eventChatListViewController]
    
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
    return FontAwesome.comments
  }
  
  var navigationBarTitle: String? {
    return nil
  }
  
  var rightBarButtonItem: UIBarButtonItem? {
    return nil
  }
}
