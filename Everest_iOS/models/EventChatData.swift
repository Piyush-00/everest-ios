//
//  EventChatData.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

struct EventChatData {
  private var _picture: UIImage?
  private var _names: [String]?
  private var _latestMessage: String?
  private var _timestamp: String?
  private var _id: String?
  
  var picture: UIImage? {
    return _picture
  }
  
  var names: [String]? {
    return _names
  }
  
  var latestMessage: String? {
    return _latestMessage
  }
  
  var timestamp: String? {
    return _timestamp
  }
  
  var id: String? {
    return _id
  }
  
  init(withPicture picture: UIImage?, names: [String]?, latestMessage: String?, timestamp: String?, id: String?) {
    _picture = picture
    _names = names
    _latestMessage = latestMessage
    _timestamp = timestamp
  }
  
  mutating func setPicture(to picture: UIImage?) {
    _picture = picture
  }
  
  mutating func setNames(to names: [String]?) {
    _names = names
  }
  
  mutating func setLatestMessage(to message: String?) {
    _latestMessage = message
  }
  
  mutating func setTimestamp(to timestamp: String?) {
    _timestamp = timestamp
  }
  
  mutating func setId(to id: String?) {
    _id = id
  }
}
