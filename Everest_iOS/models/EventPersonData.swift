//
//  EventPersonData.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-23.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

struct EventPersonData {
  enum EventPersonType: String {
    case admin = "host"
    case attendee = "guest"
  }
  
  init(withPicture picture: UIImage?, name: String?, content: String?, timestamp: String?, id: String?, type: EventPersonType?, person: Person?) {
    _picture = picture
    _name = name
    _content = content
    _timestamp = timestamp
    _id = id
    _type = type
    _person = person
  }
  
  private var _picture: UIImage?
  private var _name: String?
  private var _content: String?
  private var _timestamp: String?
  private var _id: String?
  private var _type: EventPersonType?
  private var _person: Person?
  
  var picture: UIImage? {
    return _picture
  }

  var name: String? {
    return _name
  }
  
  var content: String? {
    return _content
  }
  
  var timestamp: String? {
    return _timestamp
  }
  
  var id: String? {
    return _id
  }
  
  var type: EventPersonType? {
    return _type
  }
  
  var person: Person? {
    return _person
  }
  
  mutating func setPicture(to picture: UIImage?) {
    _picture = picture
  }
  
  mutating func setName(to name: String?) {
    _name = name
  }
  
  mutating func setContent(to content: String?) {
    _content = content
  }
  
  mutating func setTimestamp(to timestamp: String?) {
    _timestamp = timestamp
  }
  
  mutating func setId(to id: String?) {
    _id = id
  }
  
  mutating func setType(to type: EventPersonType?) {
    _type = type
  }
  
  mutating func setPerson(to person: Person?) {
    _person = person
  }
}
