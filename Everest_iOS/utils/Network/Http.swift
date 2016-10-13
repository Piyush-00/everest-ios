//
//  Http.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-06.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation
import Alamofire

class Http {
  
  //SKU
  /*  I was reading up on completion handlers and there were multiple articles on using inner closures to
   handle errors properly? Not really sure the impact but I have managed to incorporate that into this wrapper:
   - http://stackoverflow.com/questions/33927530/using-a-value-from-alamofire-request-outside-the-function
   - http://appventure.me/2015/06/19/swift-try-catch-asynchronous-closures/
   
   This wrapper is simply a working progress and will most definitely not work yet. Once we have some
   clarity from the backend, I will clean this function up. */
  
  static func getRequest<T>(requestURL: String, parameters: Parameters? = nil, ObjectType: T, completionHandler: @escaping (_ inner: () throws -> String) -> ()) {
    
    Alamofire.request(requestURL, method: .get, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
      switch response.result {
        case .success:
          if (response.request?.value) != nil {
            //SKU - JSON parsing into the respected objects
            completionHandler({ return "" })
          }
        case .failure(let error):
          print(error)
          //SKU - We need to talk with DB to figure out appropriate error handling
          completionHandler({ return "" })
        }
    }
  }
}
