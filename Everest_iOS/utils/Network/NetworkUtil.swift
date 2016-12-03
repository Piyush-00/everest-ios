//
//  NetworkUtil.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-11-24.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class NetworkUtil {

  static func getEnvironment() -> String {
    let path = Bundle.main.path(forResource: "Env", ofType: "plist")
    let dict = NSDictionary(contentsOfFile: path!)
    let env = dict?.value(forKey: "Development") as! String
    return env
  }
  
}

func t(_ url: String? = nil) -> String {
  if (url != nil) {
  return NetworkUtil.getEnvironment() + url!
  } else {
  //SKU - If the function t(), is called, then return the enviornment.
  return NetworkUtil.getEnvironment()
  }
}
