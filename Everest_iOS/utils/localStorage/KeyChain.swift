//
//  KeyChain.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-11-19.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit
import Security

let userAccount = "AuthenticatedUser"
let accessGroup = "SecurityService"

/**
 *  User defined keys for new entry
 *  Note: add new keys for new secure item and use them in load and save methods
 */


//SKU - Default arguments for the keychain queries
let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

public class Keychain: NSObject {
  

   //SKU - public setters and getters for keychain.

  static func deleteAll(){
    
    let mirrored_object = Mirror(reflecting: Keys.sharedInstance)
    
    for (_, attr) in mirrored_object.children.enumerated() {
      if (attr.label as String!) != nil {
        self.delete(service: attr.value as! NSString, data: "" )
      }
    }
  }
  
  public class func set(key: NSString, token: NSString) {
    self.save(service: key, data: token)
  }
  
  public class func get(key: NSString) -> NSString? {
    return self.load(service: key)
  }
  
  //SKU - Internal function for deleting all keychain data
  private class func delete(service: NSString, data: NSString) {
    
    let dataFromString: NSData = data.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
    
    //SKU - Instantiate a new default keychain query
    let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
    
    //SKU - Delete any existing items to prevent duplicates
    SecItemDelete(keychainQuery as CFDictionary)
    
    //SKU - Add the new keychain item
    SecItemAdd(keychainQuery as CFDictionary, nil)

  }
  
  
  //SKU - Internal function for saving to keychain
  private class func save(service: NSString, data: NSString) {
    let dataFromString: NSData = data.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
    
    //SKU - Instantiate a new default keychain query
    let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
    
    //SKU - Delete any existing items to prevent duplicates
    SecItemDelete(keychainQuery as CFDictionary)
    
    //SKU - Add the new keychain item
    SecItemAdd(keychainQuery as CFDictionary, nil)
  }
  
  private class func load(service: NSString) -> NSString? {
    //SKU - Instantiate a new default keychain query
    //SKU - Limit our results to one ite
    
    let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
    
    var dataTypeRef :AnyObject?
    
    //SKU - Search for the keychain items
    let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
    var contentsOfKeychain: NSString? = nil
    
    if status == errSecSuccess {
      if let retrievedData = dataTypeRef as? NSData {
        contentsOfKeychain = NSString(data: retrievedData as Data, encoding: String.Encoding.utf8.rawValue)
      }
    } else {
      print("Nothing was retrieved from the keychain. Status code \(status)")
    }
    
    return contentsOfKeychain
  }
}
