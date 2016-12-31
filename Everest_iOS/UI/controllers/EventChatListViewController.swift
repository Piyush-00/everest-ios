//
//  EventChatListViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

struct EventChatData {
  var picture: UIImage?
  var names: [String]
  var message: String
  var timestamp: String
  var id: String
}

struct ChatListMessage {
  var pictureUrl: String?
  var message: String
  var timestamp: String
  //var messageNumber: Int // add msgnumber prop in chat vc (and lower bound msg number?)
}

class EventChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EventContainerViewProtocol {
  private let eventChatListTabButton = EventTabBarButtonView()
  private var addChatButton: UIBarButtonItem!
  private let tableView = UITableView()
  
  let socket = ChatSocket()
  
  private let cellReuseIdentifier = "Cell"
  
  private var eventChatData: [EventChatData] = []
  
  private var cellHashMap: [String: EventChatListTableViewCell] = [:]
  
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
    
    tableView.register(EventChatListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 200.0
    tableView.separatorStyle = .none
    
    addChatButton.tintColor = appStyle.normalColor
    
    self.view.addSubview(tableView)
    self.navigationItem.rightBarButtonItem = addChatButton
    
    socket.establishConnection { response in
      print("established chat socket: \(response)")
    }
    
    socket.onNewMessage { response in
      guard let chatId = response["ChatId"] as? String,
        let pictureUrl = response["PicturePictureURL"] as? String,
        let message = response["Message"] as? String,
        let isoString = response["Timestamp"] as? String
        else { return }
      
      let timestamp = AppUtil.timestampStringFromISOString(isoString)
      
      let chatListMessage = ChatListMessage(pictureUrl: pictureUrl, message: message, timestamp: timestamp)
      
      if let cell = self.cellHashMap[chatId] {
        //NOTE: might need to update tableview to see result
        cell.updateContent(using: chatListMessage)
      }
    }
    
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    //TODO: get request for list of chats --> subscribe to chat rooms here too or in cellfor row?
  }
  
//  //SKO - Temporary fix to bug where tableView portion was under navigationBar
//  override func viewDidLayoutSubviews() {
//    super.viewDidLayoutSubviews()
//    if let rect = self.navigationController?.navigationBar.frame {
//      let y = rect.size.height + rect.origin.y
//      tableView.contentInset = UIEdgeInsets(top: y, left: 0, bottom: 0, right: 0)
//    }
//  }
  
  private func setupConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
  }
  
  @objc private func didTapAddChatButton(sender: UIBarButtonItem) {
    let eventChatPeopleListViewController = EventChatPeopleListViewController()
    eventChatPeopleListViewController.socket = socket
    self.navigationController?.pushViewController(eventChatPeopleListViewController, animated: true)
  }
  
  //MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? EventChatListTableViewCell else {
      fatalError("fatal error: EventChatListViewController cell is not a EventChatListTableViewCell")
    }
    
    let eventChatDataElement = eventChatData[indexPath.row]
    
    cellHashMap[eventChatDataElement.id] = cell
    
    cell.picture = eventChatDataElement.picture
    cell.names = eventChatDataElement.names
    cell.message = eventChatDataElement.message
    cell.timestamp = eventChatDataElement.timestamp
    cell.chatId = eventChatDataElement.id
    
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
    guard let cell = tableView.cellForRow(at: indexPath) as? EventChatListTableViewCell else {
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
    return NSLocalizedString("event chat list navigation", comment: "event navigation header")
  }
  
  var rightBarButtonItem: UIBarButtonItem? {
    return addChatButton
  }
}
