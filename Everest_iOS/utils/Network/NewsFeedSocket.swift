//
//  NewsFeedSocket.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-01.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation

class NewsFeedSocket: Socket {
  override init() {
    super.init()
    nsp = .newsFeed
    joinNamespace()
  }
  
  func joinNewsFeedRoom(userID: String, eventID: String, completionHandler: @escaping (Bool) -> () ) {
    let params = ["user_id": userID,"event_id": eventID]
    self.emit(channel: Routes.Socket.NewsFeed.Subscribe, parameters: params) { response in
      if let jsonResult = response as? Dictionary<String,Any> {
        if (jsonResult["valid"] != nil) {
          completionHandler(jsonResult["valid"]! as! Bool)
        } else {
          completionHandler(false)
        }
      } else {
        print("Socket has disconnected")
        completionHandler(false)
      }
    }
  }
  
  func onNewPost(completionHandler: @escaping (Dictionary<String,Any>) -> ()) {
    self.on(channel: Routes.Socket.NewsFeed.NewPost){ response in
      if let jsonResult = response as? Dictionary<String,Any> {
        completionHandler(jsonResult)
      } else {
        completionHandler(["error" : "invalid"])
      }
    }
  }
  
  func createNewPost(userID: String, firstName: String, lastName: String, profilePicURL: String, eventID: String, post: String,  completionHandler: @escaping (Bool) -> () ) {

    let params = ["user_id": userID, "event_id": eventID, "post": post, "firstName": firstName, "lastName": lastName, "profilePicURL": profilePicURL, "timeStamp" : AppUtil.formatISODate()]

    self.emit(channel: Routes.Socket.NewsFeed.AddPost, parameters: params) { response in
      if let jsonResult = response as? Dictionary<String,Any> {
        if (jsonResult["valid"] != nil) {
          completionHandler(jsonResult["valid"]! as! Bool)
        } else {
          completionHandler(false)
        }
      } else {
        completionHandler(false)
      }
    }
  }
  
}
