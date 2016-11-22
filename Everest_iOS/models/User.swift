//
//  User.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-11-19.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation

class User {
  
  public var FirstName: String?
  public var LastName: String?
  public var Email: String?
  public var ProfileImageURL: String?
  public var UserID: String?
  public var Password: String?
  
  //SKU - First Name
  public func setFirstName(firstName: String){
    Keychain.set(key: Keys.sharedInstance.FirstName, token: firstName as NSString)
  }
  
  public func getFirstName() -> String{
    return Keychain.get(key: Keys.sharedInstance.FirstName) as! String
  }
  
  //SKU - Last Name
  public func setLastName(lastName: String){
    Keychain.set(key: Keys.sharedInstance.LastName, token: lastName as NSString)
  }
  
  public func getLastName() -> String{
    return Keychain.get(key: Keys.sharedInstance.LastName) as! String
  }
  
  //SKU - Email Address
  public func setEmail(email: String){
    Keychain.set(key: Keys.sharedInstance.Email, token: email as NSString)
  }
  
  public func getEmail() -> String{
    return Keychain.get(key: Keys.sharedInstance.Email) as! String
  }
  
  //SKU - Profile Image
  public func setProfileImageURL(profileImageURL: String){
    Keychain.set(key: Keys.sharedInstance.ProfileImage, token: profileImageURL as NSString)
  }
  
  public func getProfileImageURL() -> String{
    return Keychain.get(key: Keys.sharedInstance.ProfileImage) as! String
  }
  
  //SKU - User ID
  public func setUserID(userID: String){
    Keychain.set(key: Keys.sharedInstance.UserID, token: userID as NSString)
  }
  
  public func getUserID() -> String{
    return Keychain.get(key: Keys.sharedInstance.UserID) as! String
  }
  
  //SKU - Password
  public func setPassword(password: String){
    Keychain.set(key: Keys.sharedInstance.Password, token: password as NSString)
  }
  
  public func getPassword() -> String{
    return Keychain.get(key: Keys.sharedInstance.Password) as! String
  }
  
  public func signUp(email: String, password: String, completionHandler: @escaping (Bool) -> ()){
    
    let params = ["Email": email, "Password": password]
    Http.postRequest(requestURL: "http://192.168.2.17:3000/createNewUser", parameters: params) {
      response in
      
      switch response.result {
      case .success (let JSON):
        
        if let httpStatusCode = response.response?.statusCode {
          switch (httpStatusCode) {
          case 200:
            if let jsonResult = JSON as? Dictionary<String,Any> {
              self.setUserID(userID: jsonResult["_id"]! as! String)
              self.setEmail(email: email)
              self.setPassword(password: password)
              completionHandler(true)
            }
          default:
            print("default case")
            completionHandler(false)
          }
        }
      case .failure(let error):
        print(error)
      }
    }
  }
}
