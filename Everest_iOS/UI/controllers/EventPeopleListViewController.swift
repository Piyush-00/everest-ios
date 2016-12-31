//
//  EventPeopleListViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-23.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class ListPerson {
  enum Role: String {
    case admin = "host"
    case attendee = "guest"
  }
  
  var id: String
  var role: Role
  var firstName: String
  var lastName: String
  var picture: UIImage?
  var content: String?
  var isSelected: Bool = false
  
  init(id: String, role: Role, firstName: String, lastName: String, picture: UIImage?, content: String?) {
    self.id = id
    self.role = role
    self.firstName = firstName
    self.lastName = lastName
    self.picture = picture
    self.content = content
  }
}

class EventPeopleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  let tableView = UITableView()
  let searchController = UISearchController(searchResultsController: nil)
  
  private let eventId = Session.manager.event?.getId() ?? ""
  
  private let cellReuseIdentifier = "Cell"
  
  var eventPeopleData: [ListPerson] = []
  var filteredEventPeopleData: [ListPerson] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appStyle = AppStyle.sharedInstance
    
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
    self.navigationItem.rightBarButtonItem = appStyle.eventSettingsBarButtonItem(withTarget: self, andAction: #selector(didTapSettingsButton))
    
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let url = t(String(format: Routes.Api.FetchAllUsers, eventId))
    
    Http.getRequest(requestURL: url) { response in
      switch response.result {
      case .success (let json):
        guard let json = json as? Dictionary<String, Any>,
          let admins = json["Admins"] as? [Any],
          let attendees = json["Attendees"] as? [Any]
          else { return }
        
        let adminListPeople = admins.map { (admin: Any) -> ListPerson? in
          guard let admin = admin as? Dictionary<String, Any>,
            let id = admin["_id"] as? String,
            let firstName = admin["FirstName"] as? String,
            let lastName = admin["LastName"] as? String
            else { return nil }
          
          let listPerson = ListPerson(id: id, role: .admin, firstName: firstName, lastName: lastName, picture: nil, content: nil)
          
          return listPerson
        }
        
        let attendeeListPeople = attendees.map { (attendee: Any) -> ListPerson? in
          guard let attendee = attendee as? Dictionary<String, Any>,
            let id = attendee["_id"] as? String,
            let firstName = attendee["FirstName"] as? String,
            let lastName = attendee["LastName"] as? String
            else { return nil }
          
          let listPerson = ListPerson(id: id, role: .attendee, firstName: firstName, lastName: lastName, picture: nil, content: nil)
          
          return listPerson
        }
        
        var listPeople = adminListPeople + attendeeListPeople
        
        listPeople = listPeople.filter { $0 != nil }
        
        self.eventPeopleData = listPeople as! [ListPerson]
        self.tableView.reloadData()
      case .failure (let error):
        print(error)
      }
    }
  }
  
  private func setupConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }
  
  func filterContentForSearchText(searchText: String, scope: String = NSLocalizedString("search all", comment: "search filter option")) {
    
    filteredEventPeopleData = eventPeopleData.filter { eventPersonData in
      let categoryMatch = (scope == NSLocalizedString("search all", comment: "search filter option")) || (scope.lowercased() == eventPersonData.role.rawValue)
      if searchText.isEmpty {
        return categoryMatch
      } else {
        let parseMatch = eventPersonData.firstName.lowercased().contains(searchText.lowercased()) || eventPersonData.lastName.lowercased().contains(searchText.lowercased()) || (eventPersonData.content ?? "").lowercased().contains(searchText.lowercased())
        return categoryMatch && parseMatch
      }
    }
    
    tableView.reloadData()
  }
  
  @objc private func didTapSettingsButton(sender: UIBarButtonItem) {
    AppUtil.presentEventSettingsActionSheet(using: self)
  }
  
  //MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? EventPeopleListTableViewCell else {
      fatalError("fatal error: EventPeopleListViewController cell is not a EventPeopleListTableViewCell")
    }
    
    var eventPersonData: ListPerson
    
    if searchController.isActive {
      eventPersonData = filteredEventPeopleData[indexPath.row]
    } else {
      eventPersonData = eventPeopleData[indexPath.row]
    }
    
    cell.person = eventPersonData
    cell.setContentHorizontalMargin(to: tableView.separatorInset.left)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.isActive {
      return filteredEventPeopleData.count
    }
    return eventPeopleData.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? EventPeopleListTableViewCell,
    let role = cell.person?.role
    else { fatalError("fatal error: EventPeopleListViewController cell is not a EventPeopleListTableViewCell") }
    
    switch role {
    case .admin:
      break
    case .attendee:
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
