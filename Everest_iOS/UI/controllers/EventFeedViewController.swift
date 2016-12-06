//
//  EventFeedViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  private let tableView = UITableView()
  private let tableHeaderImageView = UIImageView()
  private let postButton = UIButton()
  
  private let cellReuseIdentifier = "Cell"
  
  private let postButtonDiameter: CGFloat = 60.0
  private let postButtonTrailingMargin: CGFloat = 20.0
  private let postButtonBottomMargin: CGFloat = 20.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideKeyboardWhenTappedAround()
    
    let appStyle = AppStyle.sharedInstance
    
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
    tableView.translatesAutoresizingMaskIntoConstraints = false
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
  
  //MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    
    if let cell = cell as? EventFeedTableViewCell {
      cell.name = "Test Name"
      cell.post = "Test Post"
      cell.timestamp = "16:55"
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 15
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return AppStyle.sharedInstance.headerViewContainerHeaderHeight
  }
}
