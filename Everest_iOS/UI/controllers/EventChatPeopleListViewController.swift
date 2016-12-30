//
//  EventChatPeopleListViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

struct ChatPerson {
  var name: String
  var id: String
}

class EventChatPeopleListViewController: EventPeopleListViewController {
  private var chatPeople: [ChatPerson] = []
  
  private var listPeople: [ListPerson] {
    get {
      return searchController.isActive ? self.filteredEventPeopleData : self.eventPeopleData
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
    self.navigationItem.rightBarButtonItem?.isEnabled = false
    self.tableView.allowsMultipleSelection = true
  }
  
  @objc private func didTapDoneButton(sender: UIBarButtonItem) {
    let eventChatViewController = ChatViewController(withChatPeople: chatPeople)
    self.navigationController?.pushViewController(eventChatViewController, animated: true)
  }
  
  //MARK: UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    cell.selectionStyle = .default
    return cell
  }
  
  //MARK: UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? EventPeopleListTableViewCell,
      let person = cell.person
      else { fatalError("fatal error: EventChatPeopleListViewController cell is not an EventPeopleListTableViewCell") }
    
    let chatPerson = ChatPerson(name: person.firstName, id: person.id)
    
    chatPeople.append(chatPerson)
    
    self.navigationItem.rightBarButtonItem?.isEnabled = true
    listPeople[indexPath.row].isSelected = true
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? EventPeopleListTableViewCell,
      let person = cell.person
      else { fatalError("fatal error: EventChatPeopleListViewController cell is not an EventPeopleListTableViewCell") }
    
    chatPeople = chatPeople.filter { $0.id != person.id }
    
    self.navigationItem.rightBarButtonItem?.isEnabled = !chatPeople.isEmpty
    listPeople[indexPath.row].isSelected = false
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.setSelected(listPeople[indexPath.row].isSelected, animated: false)
    if cell.isSelected {
      self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
  }
}
