//
//  EventPeopleListViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-23.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventPeopleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  private let tableView = UITableView()
  private let searchController = UISearchController(searchResultsController: nil)
  
  private let cellReuseIdentifier = "Cell"
  private var eventPeopleData: [EventPersonData] = []
  private var filteredEventPeopleData: [EventPersonData] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let evd1 = EventPersonData(withPicture: nil, name: "Sebastian Kolosa", content: "Swift, Objective-C, AngularJS, HTML/CSS", timestamp: nil, id: nil, type: EventPersonData.EventPersonType.admin, person: nil)
    let evd2 = EventPersonData(withPicture: nil, name: "Sathoshi Kumarawadu", content: "NodeJS, ExpressJS, Swift, MongoDB", timestamp: nil, id: nil, type: EventPersonData.EventPersonType.admin, person: nil)
    let evd3 = EventPersonData(withPicture: nil, name: "Hayes Lee", content: "ReactJS, UI/UX, HTML/CSS, SQL", timestamp: nil, id: nil, type: EventPersonData.EventPersonType.attendee, person: nil)
    let evd4 = EventPersonData(withPicture: nil, name: "Zain Khan", content: "NodeJS, ExpressJS, MongoDB, ReactJS", timestamp: nil, id: nil, type: EventPersonData.EventPersonType.admin, person: nil)
    
    eventPeopleData.append(evd1)
    eventPeopleData.append(evd2)
    eventPeopleData.append(evd3)
    eventPeopleData.append(evd4)
    
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchResultsUpdater = self
    searchController.searchBar.scopeButtonTitles = [NSLocalizedString("search all", comment: "search filter option"), NSLocalizedString("search attendee", comment: "search filter option"), NSLocalizedString("search admin", comment: "search filter option")]
    searchController.searchBar.delegate = self
    
    tableView.register(EventPeopleListTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 200.0
    tableView.tableHeaderView = searchController.searchBar
    tableView.separatorStyle = .none
    
    self.view.addSubview(tableView)
    self.title = NSLocalizedString("event people list navigation", comment: "event navigation header")
    self.definesPresentationContext = true
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }
  
  func filterContentForSearchText(searchText: String, scope: String = NSLocalizedString("search all", comment: "search filter option")) {
    filteredEventPeopleData = eventPeopleData.filter { eventPerson in
      let categoryMatch = (scope == NSLocalizedString("search all", comment: "search filter option")) || (scope.lowercased() == eventPerson.type?.rawValue)
      let parseMatch = (eventPerson.name!.lowercased().contains(searchText.lowercased())) || (eventPerson.content!.lowercased().contains(searchText.lowercased()))
      return categoryMatch && parseMatch
    }
    tableView.reloadData()
  }
  
  //MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? EventPeopleListTableViewCell else {
      fatalError("fatal error: EventPeopleListViewController cell is not a EventPeopleListTableViewCell")
    }
    
    var eventPersonData: EventPersonData
    
    if searchController.isActive && searchController.searchBar.text != "" {
      eventPersonData = filteredEventPeopleData[indexPath.row]
    } else {
      eventPersonData = eventPeopleData[indexPath.row]
    }
    
    cell.picture = eventPersonData.picture
    cell.name = eventPersonData.name
    cell.content = eventPersonData.content
    cell.person = eventPersonData.person
    cell.setContentLeadingMargin(to: tableView.separatorInset.left)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.isActive && searchController.searchBar.text != "" {
      return filteredEventPeopleData.count
    }
    return eventPeopleData.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? EventPeopleListTableViewCell else {
      fatalError("fatal error: EventPeopleListViewController cell is not a EventPeopleListTableViewCell")
    }
    
    switch cell.person {
    case is Admin:
      //TODO: show admin profile view inited with cell.person
      break
    case is Attendee:
      //TODO: show attendee profile view inited with cell.person
      break
    default:
      break
    }
  }
}

extension EventPeopleListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchText: searchBar.text!, scope: scope)
  }
}

extension EventPeopleListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}
