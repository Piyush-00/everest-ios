//
//  EventFeedViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import FontAwesome_swift

class EventFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EventContainerViewProtocol {
  private let tableView = UITableView()
  private let tableHeaderImageView = UIImageView()
  private let postButton = UIButton()
  
  private let eventFeedTabButton = EventTabBarButtonView()
  
  private let userID = "583a10da2db1b150f71760a3"
  private let newsFeedID = "584472a41ef0ebd8e34c006d"
  private let eventID = "584472a41ef0ebd8e34c006c"
  
  private var cellData: [Dictionary<String, Any>] = []
  private let cellReuseIdentifier = "Cell"
  
  private let postButtonDiameter: CGFloat = 60.0
  private let postButtonTrailingMargin: CGFloat = 20.0
  private let postButtonBottomMargin: CGFloat = 20.0
  
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
    
    hideKeyboardWhenTappedAround()
    
    let appStyle = AppStyle.sharedInstance
    
    self.title = "Event Feed"
    
    postButton.layer.cornerRadius = postButtonDiameter / 2
    postButton.layer.masksToBounds = true
    postButton.backgroundColor = appStyle.baseInputButtonColor
    postButton.setTitle("+", for: .normal)
    postButton.addTarget(self, action: #selector(didClickPostButton), for: .touchUpInside)
    
    tableHeaderImageView.clipsToBounds = true
    tableHeaderImageView.contentMode = .scaleAspectFill
    tableHeaderImageView.layer.masksToBounds = true
    tableHeaderImageView.image = appStyle.pictureImageWide
    
    tableView.register(EventFeedTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.tableHeaderView = tableHeaderImageView
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 400.0
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = appStyle.backgroundColor
  
    self.view.addSubview(tableView)
    self.view.addSubview(postButton)
    
    setupConstraints()
    
    Socket.establishConnection() { response in
      if response {
        NewsFeedSocket.joinNewsFeedRoom(userID: self.userID, eventID: self.eventID, completionHandler: { response in
          print("joinNewsFeedRoom: \(response)")
        })
      }
    }
    
    NewsFeedSocket.onNewPost() { response in
      var postData = response
      if let profilePictureUrl = postData["profilePicURL"] as? String {
        let profilePictureImageView = UIImageView()
        profilePictureImageView.downloadedFrom(link: t("/" + profilePictureUrl)) {
          success in
          postData["profilePicURL"] = nil
          postData["profileImage"] = profilePictureImageView.image
          self.cellData.append(postData)
          self.displayNewPost()
        }
      }
    }
  }
  
  private func setupConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    postButton.translatesAutoresizingMaskIntoConstraints = false
   
    tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    
    postButton.widthAnchor.constraint(equalToConstant: postButtonDiameter).isActive = true
    postButton.heightAnchor.constraint(equalToConstant: postButtonDiameter).isActive = true
    postButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -postButtonTrailingMargin).isActive = true
    postButton.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor, constant: -postButtonBottomMargin).isActive = true
  }
  
  func didClickPostButton(sender: UIButton) {
    let eventFeedModalContainer = EventFeedModalContainer()
    
    self.view.addSubview(eventFeedModalContainer)
    
    eventFeedModalContainer.translatesAutoresizingMaskIntoConstraints = false
    
    eventFeedModalContainer.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
    eventFeedModalContainer.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
    eventFeedModalContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    eventFeedModalContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }
  
  private func displayNewPost() {
    tableView.beginUpdates()
    tableView.insertRows(at: [IndexPath(row: cellData.count - 1, section: 0)], with: .automatic)
    tableView.endUpdates()
  }
  
  //MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    
    let postData = cellData[indexPath.row]
    
    guard let eventFeedCell = cell as? EventFeedTableViewCell,
          let post = postData["post"] as? String,
          let name = postData["name"] as? String,
          let profileImage = postData["profileImage"] as? UIImage?
          else { return cell }
    
    eventFeedCell.post = post
    eventFeedCell.name = name
    eventFeedCell.profilePictureImage = profileImage
    
    return eventFeedCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellData.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return AppStyle.sharedInstance.headerViewContainerHeaderHeight
  }
  
  //MARK: EventContainerViewProtocol
  
  var viewController: UIViewController {
    return self
  }
  
  var tabButton: EventTabBarButtonView {
    return eventFeedTabButton
  }
  
  var tabIcon: FontAwesome? {
    return FontAwesome.bullhorn
  }
  
  var navigationBarTitle: String? {
    return NSLocalizedString("event feed navigation", comment: "event navigation header")
  }
  
  var rightBarButtonItem: UIBarButtonItem? {
    return nil
  }
}
