//
//  User.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-11-19.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import Foundation

class User {
  
  private var FirstName: String?
  private var LastName: String?
  private var ProfileImageURL: String?
  private var UserID: String?
  
  //SKU - First Name
  public func setFirstName(firstName: String, keyChain: Bool = false){
    self.FirstName = firstName
    if (keyChain) { self.setKeyChainFirstName(firstName: firstName) }
  }
  
  public func setKeyChainFirstName(firstName: String){
    Keychain.set(key: Keys.sharedInstance.FirstName, token: firstName as NSString)
  }
  
  public func getFirstName() -> String?{
    return self.FirstName
  }
  
  public func getKeyChainFirstName() -> String{
    return Keychain.get(key: Keys.sharedInstance.FirstName) as! String
  }

  
  //SKU - Last Name
  public func setLastName(lastName: String, keyChain: Bool = false){
    self.LastName = lastName
    if (keyChain) { self.setKeyChainLastName(lastName: lastName) }
  }
  
  public func setKeyChainLastName(lastName: String){
    Keychain.set(key: Keys.sharedInstance.LastName, token: lastName as NSString)
  }
  
  public func getLastName() -> String?{
    return self.LastName
  }
  
  public func getKeyChainLastName() -> String{
    return Keychain.get(key: Keys.sharedInstance.LastName) as! String
  }
  
  
  //SKU - Profile Image
  public func setProfileImageURL(profileImageURL: String, keyChain: Bool = false){
    self.ProfileImageURL = profileImageURL
    if (keyChain) { self.setKeyChainProfileImageURL(profileImageURL: profileImageURL) }
  }
  
  public func setKeyChainProfileImageURL(profileImageURL: String){
    Keychain.set(key: Keys.sharedInstance.ProfileImage, token: profileImageURL as NSString)
  }
  
  public func getProfileImageURL() -> String?{
    return self.ProfileImageURL
  }
  
  public func getKeyChainProfileImageURL() -> String{
    return Keychain.get(key: Keys.sharedInstance.ProfileImage) as! String
  }
  
  
  //SKU - User ID
  public func setUserID(userID: String, keyChain: Bool = false){
    self.UserID = userID
    if (keyChain) { self.setKeyChainUserID(userID: userID) }
  }
  
  public func setKeyChainUserID(userID: String){
    Keychain.set(key: Keys.sharedInstance.UserID, token: userID as NSString)
  }
  
  public func getUserID() -> String?{
    return self.UserID
  }
  
  public func getKeyChainUserID() -> String{
    return Keychain.get(key: Keys.sharedInstance.UserID) as! String
  }
  
  
  //SKU - Keychain storage functions for Email Address
  public func setKeyChainEmail(email: String){
    Keychain.set(key: Keys.sharedInstance.Email, token: email as NSString)
  }
  
  public func getKeyChainEmail() -> String{
    return Keychain.get(key: Keys.sharedInstance.Email) as! String
  }
  
  
  //SKU - Keychain storage functions for Password
  public func setKeyChainPassword(password: String){
    Keychain.set(key: Keys.sharedInstance.Password, token: password as NSString)
  }
  
  public func getKeyChainPassword() -> String{
    return Keychain.get(key: Keys.sharedInstance.Password) as! String
  }
  
  
  //SKU - Signup
  public func signUp(email: String, password: String, completionHandler: @escaping (Bool) -> ()){
    
    let params = ["Email": email, "Password": password]
    Http.postRequest(requestURL: t(Routes.Api.CreateNewUser), parameters: params) {
      response in
      
      switch response.result {
      case .success (let JSON):
        
        if let httpStatusCode = response.response?.statusCode {
          switch (httpStatusCode) {
          case 200:
            if let jsonResult = JSON as? Dictionary<String,Any> {
              self.setUserID(userID: jsonResult["_id"]! as! String, keyChain: true)
              self.setKeyChainEmail(email: email)
              self.setKeyChainPassword(password: password)
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
  
  
  //SKU - SignUpProfileUpdate
  public func signUpProfile (image: UIImage? = nil, firstName: String? = nil, lastName: String? = nil, completionHandler: @escaping (Bool) -> ()) {
    
    let params = ["FirstName": firstName, "LastName": lastName]
    
    Http.multipartRequest(requestURL: t(Routes.Api.SetUpUserProfile + self.getUserID()!), image: image, parameters: params) {
      response in
      switch response.result {
      case .success (let JSON):
        
        if let httpStatusCode = response.response?.statusCode {
          switch (httpStatusCode) {
          case 200:
            if let jsonResult = JSON as? Dictionary<String,Any> {
              self.setProfileImageURL(profileImageURL: jsonResult["ProfileImageURL"]! as! String, keyChain: true)
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
