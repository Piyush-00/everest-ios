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
  var picture: UIImage? //TODO: eventually make non-optional once implement client-side default image
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
  
  private let user = Session.manager.user
  private let event = Session.manager.event
  
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
        let message = response["Message"] as? String,
        let isoString = response["Timestamp"] as? String
        else { return }
      
      let timestamp = AppUtil.timestampStringFromISOString(isoString)
      
      let profilePictureUrl = response["ProfilePictureURL"] as? String
      
      let chatListMessage = ChatListMessage(pictureUrl: profilePictureUrl, message: message, timestamp: timestamp)
      
      if let cell = self.cellHashMap[chatId] {
        //NOTE: might need to update tableview to see result
        cell.updateContent(using: chatListMessage)
      }
    }
    
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let url = t(String(format: Routes.Api.FetchAllChats, user!.id!, event!.getId()!))
    
    Http.getRequest(requestURL: url) { response in
      switch response.result {
      case .success(let json):
        guard let jsonArray = json as? [Dictionary<String, Any>] else { return }
        
        var chatData: [EventChatData] = []
        
        for (index, json) in jsonArray.enumerated() {
          guard let id = json["ChatID"] as? String,
            let participants = json["Participants"] as? [Dictionary<String, Any>],
            let latestMessageJson = json["LatestMessage"] as? Dictionary<String, Any>
            else { return }
          
          var participantFirstNames: [String] = []
          
          for participant in participants {
            guard let firstName = participant["FirstName"] as? String else { return }
            participantFirstNames.append(firstName)
          }
          
          guard let message = latestMessageJson["Message"] as? String,
            let isoString = latestMessageJson["Timestamp"] as? String
            else { return }
          
          let timestamp = AppUtil.timestampStringFromISOString(isoString)
          
          if let profileImageUrl = latestMessageJson["ProfileImageURL"] as? String {
            let profileImageView = UIImageView()
            profileImageView.downloadedFrom(link: t("/" + profileImageUrl)) { _ in
              let eventChatData = EventChatData(picture: profileImageView.image, names: participantFirstNames, message: message, timestamp: timestamp, id: id)
              chatData.append(eventChatData)
              self.eventChatData = chatData
              self.tableView.reloadData()
            }
          } else {
            let eventChatData = EventChatData(picture: nil, names: participantFirstNames, message: message, timestamp: timestamp, id: id)
            chatData.append(eventChatData)
            self.eventChatData = chatData
            self.tableView.reloadData()
          }
        }
        break
      case .failure(let error):
        print(error)
        break
      }
    }
    
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
