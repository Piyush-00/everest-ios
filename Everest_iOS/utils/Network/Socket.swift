//
//  Socket.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-11-27.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation
import SocketIO

class Socket : NSObject {

  private static let socket = SocketIOClient(socketURL: URL(string: t())!)
  
  static func establishConnection() {
    socket.connect()
  }
  
  static func closeConnection() {
    self.socket.disconnect()
  }
  
  static func on(channel: String, completionHandler : @escaping (Any?) -> ()) {
    Socket.socket.on(channel) { data, ack in
      
      //SKU - Obscure the acknowledgement as we are not using it for now.
      if (data.count > 0) {
        completionHandler(data.first!)
      } else {
        completionHandler(nil)
      }
    }
  }
  
  static func emit(channel: String, parameters: [String: Any], completionHandler : @escaping (Any?) -> ()){
    
    Socket.socket.emitWithAck(channel, parameters).timingOut(after: 0) { data in
      if (data.count > 0) {
        completionHandler(data.first)
      } else {
        completionHandler(nil)
      }
    }
  }
  
}
