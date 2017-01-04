//
//  Session.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-08.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation

protocol SessionProtocol {
  func didReceiveUserState(response: Bool)
}

class Session {
  
  static let manager = Session()
  
  var isActiveEvent: Bool {
    return Keychain.get(key: Keys.sharedInstance.EventID) != nil
  }
  
  var user: User?
  var event: Event?
  var userState: State = .loggedOut
  
  static var delegate: SessionProtocol?
  
  func checkState() {
    let userID: String? = User.getUserID()
    
    if (userID != nil && userID != "") {
      userState =  .loggedIn
      print("loggedin")
    } else {
      userState =  .loggedOut
      print("loggedOut")
    }
  }
  
  func updateUserState() {
    
    //SKU - Check the state of the app.
    checkState()
    
    switch userState {
     case .loggedIn:
      
      //SKU - First state is user is logged in. We have user data stored.
      //SKU - Create new instance of User Session
      Session.manager.user = User()
      Session.manager.user?.loadKeyChainData()
      
      /* Sign in user to make sure we have the most up to date information from DB */
      Session.manager.user?.signIn(email: (Session.manager.user?.getKeyChainEmail())!, password: (Session.manager.user?.getKeyChainPassword())!) {
      response in
        //SKU - If response == true, sign in successful
          if (response) {
          print("successful sign in")
        } else {
          //SKU - log in failed and there is no valid uesr for there to be a session.
          Session.manager.user = nil
          print("Login failed.")
        }
        
        //SKU - The procol handler used to make sure that there are no racing conditions.
        Session.delegate?.didReceiveUserState(response: true)
      }
      
    case .loggedOut:
      
      //SKU - We have no user property which means there is no user.
      Session.manager.user = nil
      //SKU - The completion handler used to make sure that there are no racing conditions.
    }
  }
}

public enum State {
  
  case loggedIn
  case loggedOut
  
}
