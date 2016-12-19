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
  private let settingsButton = UIButton()
  private let eventNavigationBar = UIView()
  private let contentView = UIView()
  private let eventTabBar = EventTabBarView()
  private let navigationBarTitleLabel = UILabel()
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
      navigationBarTitleLabel.text = _currentViewController?.navigationBarTitle
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
    
    let testVC1 = EventFeedViewController()
    let testVC2 = EventFeedViewController()
    let testVC3 = EventFeedViewController()
    let testVC4 = EventFeedViewController()
    let testVC5 = EventFeedViewController()
    let testVC6 = EventFeedViewController()
    
    navigationBarTitleLabel.font = appStyle.textFontLarge
    navigationBarTitleLabel.textColor = .black
    navigationBarTitleLabel.textAlignment = .center
    navigationBarTitleLabel.text = testVC1.navigationBarTitle
    
    eventNavigationBar.backgroundColor = AppStyle.sharedInstance.backgroundColor
    eventNavigationBar.addSubview(navigationBarTitleLabel)
    
    contentView.layer.borderColor = UIColor.red.cgColor
    contentView.layer.borderWidth = 1.0
    
    eventTabBar.delegate = self
    
    viewControllers = [testVC1, testVC2, testVC3, testVC4, testVC5, testVC6]
    setCurrentViewController(to: viewControllers.first)
    
    self.view.addSubview(eventNavigationBar)
    self.view.addSubview(contentView)
    self.view.addSubview(eventTabBar)
    eventTabBar.position(in: self.view)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    guard let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController else {
      fatalError("fatal error: appDelegate does not have a navigationController property.")
    }
    
    eventNavigationBar.translatesAutoresizingMaskIntoConstraints = false
    settingsButton.translatesAutoresizingMaskIntoConstraints = false
    navigationBarTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    eventNavigationBar.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
    eventNavigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    eventNavigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    eventNavigationBar.heightAnchor.constraint(equalToConstant: navigationController.navigationBar.bounds.height + UIApplication.shared.statusBarFrame.height).isActive = true
    
    navigationBarTitleLabel.centerXAnchor.constraint(equalTo: eventNavigationBar.centerXAnchor).isActive = true
    navigationBarTitleLabel.centerYAnchor.constraint(equalTo: eventNavigationBar.centerYAnchor, constant: UIApplication.shared.statusBarFrame.height/2).isActive = true
    navigationBarTitleLabel.widthAnchor.constraint(equalTo: eventNavigationBar.widthAnchor, multiplier: 0.5).isActive = true
    
    contentView.topAnchor.constraint(equalTo: eventNavigationBar.bottomAnchor).isActive = true
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
  
  //MARK: EventTabBarViewDelegate
  func eventTabBar(_ eventTabBar: EventTabBarView, didTapTabButton tabButton: EventTabBarButtonView) {
    _currentViewController = tabButton.viewController
  }
}
