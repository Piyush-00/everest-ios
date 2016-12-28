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
  var rightBarButtonItem: UIBarButtonItem? {get}
}

extension EventContainerViewProtocol {
  func attachTabButton() {
    tabButton.setViewController(to: viewController as? EventContainerViewProtocol)
  }
}

class EventContainerViewController: UIViewController, EventTabBarViewDelegate {
  private var settingsButton: UIBarButtonItem!
  private let contentView = UIView()
  private let eventTabBar = EventTabBarView()
  var viewControllers: [EventContainerViewProtocol] = [] {
    didSet {
      displayCurrentViewControllerView()
      eventTabBar.setupTabButtons(usingViewControllers: viewControllers)
    }
  }
  
  private var _currentViewController: EventContainerViewProtocol? {
    willSet {
      removeCurrentViewControllerView()
    }
    didSet {
      displayCurrentViewControllerView()
      title = _currentViewController?.navigationBarTitle
      self.navigationController?.navigationBar.isHidden = _currentViewController is UINavigationController
      self.navigationItem.rightBarButtonItem = _currentViewController?.rightBarButtonItem ?? settingsButton
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
    let appStyle = AppStyle.sharedInstance
    
    let eventFeedViewController = EventFeedViewController()
    let eventChatListViewController = EventChatListViewController()
    let eventPeopleListNavigationController = EventPeopleListNavigationController(nibName: nil, bundle: nil)
    let eventProfileNavigationController = EventProfileNavigationController(nibName: nil, bundle: nil)
    let eventPageNavigationController = EventPageNavigationController(nibName: nil, bundle: nil)
    
    eventTabBar.delegate = self
    
    viewControllers = [eventFeedViewController, eventChatListViewController, eventPeopleListNavigationController, eventProfileNavigationController, eventPageNavigationController]
    
    setCurrentViewController(to: viewControllers.first)
    
    self.view.addSubview(contentView)
    self.view.addSubview(eventTabBar)
    eventTabBar.position(in: self.view)
    
    settingsButton = appStyle.eventSettingsBarButtonItem(withTarget: self, andAction: #selector(didTapSettingsButton))
    self.navigationItem.rightBarButtonItem = settingsButton
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
    contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: eventTabBar.topAnchor).isActive = true
  }
  
  //TODO: implement check to see if viewController is in viewControllers
  func setCurrentViewController(to viewController: EventContainerViewProtocol?) {
    eventTabBar.setCurrentTabBarButton(to: viewController?.tabButton)
    _currentViewController = viewController
  }
  
  private func displayCurrentViewControllerView() {
    guard let currentViewController = _currentViewController as? UIViewController else {
      return
    }
    
    self.addChildViewController(currentViewController)
    contentView.addSubview(currentViewController.view)
    
    let view = currentViewController.view
    
    view?.translatesAutoresizingMaskIntoConstraints = false
    view?.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    view?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    view?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    view?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    
    currentViewController.didMove(toParentViewController: self)
  }
  
  private func removeCurrentViewControllerView() {
    guard let currentViewController = _currentViewController as? UIViewController else {
      return
    }
    
    currentViewController.willMove(toParentViewController: nil)
    currentViewController.view.removeFromSuperview()
    currentViewController.removeFromParentViewController()
  }
  
  func didTapSettingsButton(sender: UIBarButtonItem) {
    AppUtil.presentEventSettingsActionSheet(using: self)
  }
  
  //MARK: EventTabBarViewDelegate
  func eventTabBar(_ eventTabBar: EventTabBarView, didTapTabButton tabButton: EventTabBarButtonView) {
    _currentViewController = tabButton.viewController
  }
}
