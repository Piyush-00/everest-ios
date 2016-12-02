//
//  NewsFeedSocket.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-01.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation

class NewsFeedSocket {
  
  init(){}
  
  public func joinNewsFeedRoom(userID: String, eventID: String, completionHandler: @escaping (Bool) -> () ) {
    let params = ["user_id": userID,"event_id": eventID]
    Socket.emit(channel: Routes.Socket.NewsFeed.Subscribe, parameters: params) { response in
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
  
  public func onNewPost(completionHandler: @escaping (Dictionary<String,Any>) -> ()) {
    Socket.on(channel: Routes.Socket.NewsFeed.NewPost){ response in
      if let jsonResult = response as? Dictionary<String,Any> {
        completionHandler(jsonResult)
      } else {
        completionHandler(["error" : "invalid"])
      }
    }
  }
  
  public func createNewPost(userID: String, firstName: String, lastName: String, profilePicURL: String, eventID: String, newsFeedID: String, post: String,  completionHandler: @escaping (Bool) -> () ) {
    let params = ["user_id": userID, "event_id": eventID, "room": newsFeedID, "post": post, "firstName": firstName, "lastName": lastName, "profilePicURL": profilePicURL]
    Socket.emit(channel: Routes.Socket.NewsFeed.AddPost, parameters: params) { response in
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
