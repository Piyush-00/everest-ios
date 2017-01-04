//
//  Keys.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-11-19.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation

class Keys {
  
  static let sharedInstance = Keys()
  
  //SKU - Central location for Keychain keys
  
  let Password:NSString = "userPassword"
  let Email:NSString = "userEmail"
  let UserID:NSString = "userID"
  let FirstName:NSString = "firstName"
  let LastName:NSString = "lastName"
  let ProfileImage:NSString = "profileImageURL"
  
  let EventID:NSString = "eventID"
}
