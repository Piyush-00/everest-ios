//
//  EventChatListViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

class EventChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EventContainerViewProtocol {
  private let eventChatListTabButton = EventTabBarButtonView()
  private var addChatButton: UIBarButtonItem!
  private let tableView = UITableView()
  
  private let cellReuseIdentifier = "Cell"
  
  private var eventChatData: [EventChatData] = []
  
  override init(nibName: String?, bundle: Bundle?) {
    super.init(nibName: nibName, bundle: bundle)
    
    self.attachTabButton()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.attachTabButton()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let appStyle = AppStyle.sharedInstance
    
    addChatButton = UIBarButtonItem(image: UIImage.fontAwesomeIcon(name: .plus, textColor: UIColor.black, size: CGSize(width: appStyle.tabBarButtonIconSize, height: appStyle.tabBarButtonIconSize)), style: .plain, target: self, action: #selector(didTapAddChatButton))
    
    let ecd = EventChatData(withPicture: nil, names: ["Sebastian", "Zain", "Hayes"], latestMessage: "latest message lmao", timestamp: "18:49", id: nil)
    let ecd2 = EventChatData(withPicture: nil, names: ["Sebastian", "Zain", "Hayes"], latestMessage: "latest message lmao", timestamp: "18:49", id: nil)
    let ecd3 = EventChatData(withPicture: nil, names: ["Sebastian", "Zain", "Hayes"], latestMessage: "latest message lmao", timestamp: "18:49", id: nil)
    
    eventChatData.append(ecd)
    eventChatData.append(ecd2)
    eventChatData.append(ecd3)
    
    tableView.register(EventChatListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 200.0
    tableView.separatorStyle = .none
    
    addChatButton.tintColor = appStyle.normalColor
    
    self.view.addSubview(tableView)
    self.navigationItem.rightBarButtonItem = addChatButton
    self.edgesForExtendedLayout = .top
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
  }
  
  @objc private func didTapAddChatButton(sender: UIBarButtonItem) {
    
  }
  
  //MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? EventChatListTableViewCell else {
      fatalError("fatal error: EventChatListViewController cell is not a EventChatListTableViewCell")
    }
    
    let eventChatDataInstance = eventChatData[indexPath.row]
    
    cell.picture = eventChatDataInstance.picture
    cell.names = eventChatDataInstance.names
    cell.message = eventChatDataInstance.latestMessage
    cell.timestamp = eventChatDataInstance.timestamp
    cell.chatId = eventChatDataInstance.id
    
    cell.setContentHorizontalMargin(to: tableView.separatorInset.left)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return eventChatData.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? EventChatListTableViewCell else {
      fatalError("fatal error: EventChatListViewController cell is not a EventChatListTableViewCell")
    }
    
    let chatViewController = ChatViewController()
    self.navigationController?.pushViewController(chatViewController, animated: true)
  }
  
  //MARK: EventContainerViewProtocol
  
  var viewController: UIViewController {
    return self
  }
  
  var tabButton: EventTabBarButtonView {
    return eventChatListTabButton
  }
  
  var tabIcon: FontAwesome? {
    return FontAwesome.comments
  }
  
  var navigationBarTitle: String? {
    return NSLocalizedString("event chat navigation", comment: "event navigation header")
  }
  
  var rightBarButtonItem: UIBarButtonItem? {
    return addChatButton
  }
}
