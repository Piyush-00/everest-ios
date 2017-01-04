//
//  Socket.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-11-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation
import SocketIO

enum namespace: String {
  case newsFeed = "/newsfeed"
  case chat = "/chat"
}

class Socket : NSObject {
  
  private let socket = SocketIOClient(socketURL: URL(string: t())!)
  
  func establishConnection(completionHandler : @escaping (Bool) -> ()) {
    socket.connect()
    
    socket.on("connect"){ data, ack in
      completionHandler(true)
    }
    socket.on("error"){ _,_ in
      self.closeConnection()
      completionHandler(false)
    }
  }
  
  func closeConnection() {
    self.socket.disconnect()
  }
  
  func on(channel: String, completionHandler : @escaping (Any?) -> ()) {
    socket.on(channel) { data, ack in
      
      //SKU - Obscure the acknowledgement as we are not using it for now.
      if (data.count > 0) {
        completionHandler(data.first!)
      } else {
        completionHandler(nil)
      }
    }
  }
  
  func emit(channel: String, parameters: [String: Any], completionHandler : @escaping (Any?) -> ()){
    
    socket.emitWithAck(channel, parameters).timingOut(after: 0) { data in
      if (data.count > 0) {
        completionHandler(data.first)
      } else {
        completionHandler(nil)
      }
    }
  }
  
  func setNamespace(to namespace: namespace) {
    socket.joinNamespace(namespace.rawValue)
  }
}
