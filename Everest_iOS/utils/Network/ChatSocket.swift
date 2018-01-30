//
//  ChatSocket.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-30.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation

class ChatSocket: Socket {
  override init() {
    super.init()
    nsp = .chat
    joinNamespace()
  }
  
  func joinChatRoom(withChatId chatId: String, eventId: String, userId: String, completionHandler: @escaping (Bool) -> ()) {
    let params: Dictionary<String, Any> = ["ChatID": chatId, "EventID": eventId, "UserID": userId]
    
    self.emit(channel: Routes.Socket.NewsFeed.Subscribe, parameters: params) { response in
      if let jsonResult = response as? Dictionary<String, Any> {
        let result = jsonResult["valid"] as? Bool ?? false
        completionHandler(result)
      } else {
        completionHandler(false)
      }
    }
  }
  
  func onNewMessage(completionHandler: @escaping (Dictionary<String, Any>) -> ()) {
    self.on(channel: Routes.Socket.Chat.NewMessage) { response in
      if let jsonResult = response as? Dictionary<String,Any> {
        completionHandler(jsonResult)
      } else {
        completionHandler(["error" : "invalid"])
      }
    }
  }
  
  func createNewMessage(withChatId chatId: String, userId: String, firstName: String, lastName: String, profileImageUrl: String, message: String, andTimestamp timestamp: Date, completionHandler: @escaping (Bool) -> ()) {
    let params: Dictionary<String, Any> = ["ChatID": chatId, "UserID": userId, "FirstName": firstName, "LastName": lastName, "ProfileImageURL": profileImageUrl, "Message": message, "Timestamp": timestamp]
    
    self.emit(channel: Routes.Socket.Chat.AddMessage, parameters: params) { response in
      if let jsonResult = response as? Dictionary<String, Any> {
        let result = jsonResult["valid"] as? Bool ?? false
        completionHandler(result)
      } else {
        completionHandler(false)
      }
    }
  }
}
