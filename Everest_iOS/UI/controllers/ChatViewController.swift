//
//  ChatViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-18.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChatMessageInputContainerProtocol {
  private let tableView = UITableView()
  private let messageInputView = ChatMessageInputContainer()

  private var bottomConstraint: NSLayoutConstraint?
  
  private var cellData: [Dictionary<String, Any>] = []
  private let cellReuseIdentifier = "Cell"
  private var previousUser: String?
  
  private let postButtonDiameter: CGFloat = 60.0
  private let postButtonTrailingMargin: CGFloat = 20.0
  private let postButtonBottomMargin: CGFloat = 20.0
  
  private let userID = "58448aedbef3300530bbb835"
  private let newsFeedID = "5850c22ddabe3d01ff24a753"
  private let eventID = "5850c22ddabe3d01ff24a752"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    
    hideKeyboardWhenTappedAround()
  
    tableView.register(ChatViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 400.0
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = UIColor.white
  
    messageInputView.delegate = self
    
    self.view.addSubview(messageInputView)
    self.view.addSubview(tableView)
    
    NotificationCenter.default.addObserver(self, selector: #selector(KeyboardDidActivate), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(KeyboardDidActivate), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    setupConstraints()
    
//    Socket.establishConnection() { response in
//      if response {
//        NewsFeedSocket.joinNewsFeedRoom(userID: self.userID, eventID: self.eventID, completionHandler: { response in
//          print("joinNewsFeedRoom: \(response)")
//        })
//      }
//    }
//    
//    NewsFeedSocket.onNewPost() { response in
//      var postData = response
//      if let profilePictureUrl = postData["profilePicURL"] as? String {
//        let profilePictureImageView = UIImageView()
//        profilePictureImageView.downloadedFrom(link: t("/" + profilePictureUrl)) {
//          success in
//          postData["profilePicURL"] = nil
//          postData["profileImage"] = profilePictureImageView.image
//          self.cellData.append(postData)
//          self.displayPost()
//        }
//      }
//    }
  }
  
  private func setupConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.messageInputView.topAnchor).isActive = true
    
    bottomConstraint = NSLayoutConstraint(item: messageInputView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    view.addConstraint(bottomConstraint!)
    
    messageInputView.translatesAutoresizingMaskIntoConstraints = false
    messageInputView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    messageInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    messageInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
  private func displayPost() {
    tableView.beginUpdates()
    tableView.insertRows(at: [IndexPath(row: cellData.count - 1, section: 0)], with: .automatic)
    tableView.endUpdates()
  }
  
  func KeyboardDidActivate(notification: NSNotification) {
    
    if (notification.name == NSNotification.Name.UIKeyboardWillShow) {
      if let userAgent = notification.userInfo {
        let keyboardFrame = (userAgent[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        bottomConstraint?.constant = -(keyboardFrame?.height)!
      }
    } else if (notification.name == NSNotification.Name.UIKeyboardWillHide) {
      bottomConstraint?.constant = 0
    }
    
    UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
      self.view.superview?.layoutIfNeeded()
      }, completion: {
        response in
    })
  }
  
  //MARK: UITableViewDelegate
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    
    let postData = cellData[indexPath.row]
    
    guard let chatMessageCell = cell as? ChatViewCell,
          let post = postData["post"] as? String,
          let name = postData["name"] as? String,
          let userID = postData["userID"] as? String,
//          let timeStamp = "15:55",
          let profileImage = postData["profileImage"] as? UIImage?
          else {  return cell }
    
    chatMessageCell.post = post
    chatMessageCell.name = name
    chatMessageCell.timeStamp = "15:55"
    chatMessageCell.profilePictureImage = profileImage
    
    //SKU - Check if the previous message was by the same person
    if(previousUser == nil || (previousUser != userID)) {
      chatMessageCell.renderInitialPostComps()
    }
    //Set the latest post as the "Previous User"
    previousUser = userID
    
    return chatMessageCell
  }
  
  //MARK: UITableViewDelegate
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellData.count
  }
  
  //MARK: UITableViewDelegate
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func didTapSendButton(inputText: String) {
    print(inputText)
    //SKU - Add in socket Emit function here
  }
}
