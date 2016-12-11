//
//  EventListViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-10.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  private let tableView = UITableView()
  private let headerView = HeaderContainer(withNavigationBar: false)
  private let cellReuseIdentifier = "Cell"
  private let cellHeight: CGFloat = 140
  let section = ["Hosted Events", "Joined Events"]
  var x = 1
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appStyle = AppStyle.sharedInstance
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(EventListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.separatorStyle = .singleLineEtched
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = cellHeight
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = appStyle.backgroundColor
    
    self.view.addSubview(headerView)
    self.view.addSubview(tableView)
    setupConstraints()
  }
  
  func setupConstraints() {
    
    headerView.translatesAutoresizingMaskIntoConstraints = false
    headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    headerView.heightAnchor.constraint(equalToConstant: AppStyle.sharedInstance.headerContainerHeight).isActive = true
    
    headerView.setHeaderLabel(label: "Event List")
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }
  
  //MARK: UITableViewDelegate
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    
    if let cell = cell as? EventListTableViewCell {
      
      cell.eventName = String(describing: indexPath)
      cell.eventLocation = "3 lost canyon way"
      cell.eventStartTime = "3:00pm"
      cell.eventEndTime = "5:00pm"
      cell.eventBackgroundImage.downloadedFrom(link: t("/public/uploads/toronto" + String(describing: x) + ".png"))
      cell.eventBackgroundImage.contentMode = .scaleAspectFill
      x += 1
    }
    return cell
  }
  
  //MARK: UITableViewDelegate
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.section.count
  }
  
  //MARK: UITableViewDelegate
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
  }
  
  //MARK: UITableViewDelegate return number of rows per sections
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.section[section]
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
}
