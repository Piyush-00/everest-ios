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
  
  var id: String? {
    return Keychain.get(key: Keys.sharedInstance.UserID) as String? ?? ""
  }
  
  //SKU - First Name
  public func setFirstName(firstName: String, keyChain: Bool = false){
    self.FirstName = firstName
    if (keyChain) { self.setKeyChainFirstName(firstName: firstName) }
  }
  
  private func setKeyChainFirstName(firstName: String){
    Keychain.set(key: Keys.sharedInstance.FirstName, token: firstName as NSString)
  }
  
  public func getFirstName() -> String?{
    return self.FirstName
  }
  
  private func getKeyChainFirstName() -> String{
    let firstName = Keychain.get(key: Keys.sharedInstance.FirstName) ?? ""
    return firstName as String
  }
  
  //SKU - Last Name
  public func setLastName(lastName: String, keyChain: Bool = false){
    self.LastName = lastName
    if (keyChain) { self.setKeyChainLastName(lastName: lastName) }
  }
  
  private func setKeyChainLastName(lastName: String){
    Keychain.set(key: Keys.sharedInstance.LastName, token: lastName as NSString)
  }
  
  public func getLastName() -> String?{
    return self.LastName
  }
  
  private func getKeyChainLastName() -> String{
    let lastName = Keychain.get(key: Keys.sharedInstance.LastName) ?? ""
    return lastName as String
  }
  
  
  //SKU - Profile Image
  public func setProfileImageURL(profileImageURL: String, keyChain: Bool = false){
    self.ProfileImageURL = profileImageURL
    if (keyChain) { self.setKeyChainProfileImageURL(profileImageURL: profileImageURL) }
  }
  
  private func setKeyChainProfileImageURL(profileImageURL: String){
    Keychain.set(key: Keys.sharedInstance.ProfileImage, token: profileImageURL as NSString)
  }
  
  public func getProfileImageURL() -> String?{
    return self.ProfileImageURL
  }
  
  private func getKeyChainProfileImageURL() -> String{
    let profileImageURL = Keychain.get(key: Keys.sharedInstance.ProfileImage) ?? ""
    return profileImageURL as String
  }
  
  
  //SKU - User ID
  public func setUserID(userID: String){
    self.setKeyChainUserID(userID: userID)
  }
  
  private func setKeyChainUserID(userID: String){
    Keychain.set(key: Keys.sharedInstance.UserID, token: userID as NSString)
  }
  
  static func getUserID()-> String? {
    return self.getKeyChainUserID()
  }
  
  private static func getKeyChainUserID() -> String? {
    return Keychain.get(key: Keys.sharedInstance.UserID) as String?
  }
  

  //SKU - Keychain storage functions for Email Address
  private func setKeyChainEmail(email: String){
    Keychain.set(key: Keys.sharedInstance.Email, token: email as NSString)
  }
  
  public func getKeyChainEmail() -> String{
    let email = Keychain.get(key: Keys.sharedInstance.Email) ?? ""
    return email as String
  }
  
  
  //SKU - Keychain storage functions for Password
  private func setKeyChainPassword(password: String){
    Keychain.set(key: Keys.sharedInstance.Password, token: password as NSString)
  }
  
  public func getKeyChainPassword() -> String{
    let password = Keychain.get(key: Keys.sharedInstance.Password) ?? ""
    return password as String
  }
  
  public func loadKeyChainData() {
    self.FirstName = self.getKeyChainFirstName()
    self.LastName = self.getKeyChainLastName()
    self.ProfileImageURL = self.getKeyChainProfileImageURL()
  }
  
  //SKU - Signin
  public func signIn(email: String, password: String, completionHandler: @escaping (Bool) -> ()){
    let params = ["Email": email, "Password": password]
    Http.postRequest(requestURL: t(Routes.Api.SignInUser), parameters: params) {
      response in
      
      switch response.result {
      case .success (let JSON):
        
        if let httpStatusCode = response.response?.statusCode {
          switch (httpStatusCode) {
          case 200:
            if let jsonResult = JSON as? Dictionary<String,Any> {
              self.setUserID(userID: jsonResult["_id"]! as! String)
              self.setKeyChainEmail(email: email)
              self.setKeyChainPassword(password: password)
              
              if let firstName = jsonResult["FirstName"] as? String {
                self.setFirstName(firstName: firstName, keyChain: true)
              } else {
                self.setFirstName(firstName: "", keyChain: true)
              }
              
              if let lastName = jsonResult["LastName"] as? String {
                self.setLastName(lastName: lastName, keyChain: true)
              } else {
                self.setLastName(lastName: "", keyChain: true)
              }
              
              if let profilePicURL = jsonResult["ProfileImageURL"] as? String {
                self.setProfileImageURL(profileImageURL: profilePicURL, keyChain: true)
              } else {
                self.setProfileImageURL(profileImageURL: "", keyChain: true)
              }
              
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
              self.setUserID(userID: jsonResult["_id"]! as! String)
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
  //TODO: refactor to make firstName and lastName non-optional
  public func signUpProfile(image: UIImage? = nil, firstName: String? = nil, lastName: String? = nil, completionHandler: @escaping (Bool) -> ()) {
    let params = ["FirstName": firstName ?? "", "LastName": lastName ?? ""]
    let queryString = "?id=\(User.getUserID()!)&isimageset="
    var url = t(Routes.Api.SetUpUserProfile + queryString)
    
    if let image = image {
      url += "true"
      Http.multipartRequest(requestURL: url, image: image, parameters: params) {
        response in
        switch response.result {
        case .success (let JSON):
          
          if let httpStatusCode = response.response?.statusCode {
            switch (httpStatusCode) {
            case 200:
              if let jsonResult = JSON as? Dictionary<String,Any> {
                self.setProfileImageURL(profileImageURL: jsonResult["ProfileImageURL"]! as! String, keyChain: true)
                self.setFirstName(firstName: firstName!, keyChain: true)
                self.setLastName(lastName: lastName!, keyChain: true)
                
                Session.manager.user = self
                
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
    } else {
      url += "false"
      Http.postRequest(requestURL: url) { response in
        switch response.result {
        case .success (let JSON):
          if let httpStatusCode = response.response?.statusCode {
            switch (httpStatusCode) {
            case 200:
              if let jsonResult = JSON as? Dictionary<String,Any> {
                self.setProfileImageURL(profileImageURL: "", keyChain: true)
                self.setFirstName(firstName: firstName!, keyChain: true)
                self.setLastName(lastName: lastName!, keyChain: true)
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
  
}
