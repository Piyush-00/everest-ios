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
  private let cellReuseIdentifier = "Cell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appStyle = AppStyle.sharedInstance
    
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
  
    self.view.addSubview(tableView)
    tableView.backgroundColor = appStyle.backgroundColor
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
