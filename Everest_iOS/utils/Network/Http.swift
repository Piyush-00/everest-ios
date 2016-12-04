//
//  Http.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-06.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation
import Alamofire

class Http  {
  
  //SKU
  /*  I was reading up on completion handlers and there were multiple articles on using inner closures to
   handle errors properly? Not really sure the impact but I have managed to incorporate that into this wrapper:
   - http://stackoverflow.com/questions/33927530/using-a-value-from-alamofire-request-outside-the-function
   - http://appventure.me/2015/06/19/swift-try-catch-asynchronous-closures/
   
   This wrapper is simply a working progress and will most definitely not work yet. Once we have some
   clarity from the backend, I will clean this function up. */
  
  static func getRequest(requestURL: String, parameters: Parameters? = nil, completionHandler: @escaping (DataResponse<Any>) -> ()) {
    
    Alamofire.request(requestURL, method: .get, parameters: parameters, encoding: JSONEncoding.default).validate()
      .responseJSON { response in
        completionHandler(response)
    }
  }
  
  static func postRequest(requestURL: String, parameters: Parameters? = nil, completionHandler: @escaping (DataResponse<Any>) -> ()) {
    
    Alamofire.request(requestURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate()
      .responseJSON { response in
        completionHandler(response)
    }
  }
  
  //SKU Simple imageRequest function that will return the ResponseHeader. We can use any values from response for error handelling
  static func multipartRequest(requestURL: String, image: UIImage? = nil, parameters: Parameters? = nil, completion : @escaping (DataResponse<Any>) -> ()) {
    
    Alamofire.upload(multipartFormData: {
      multipartFormData in
      for (key, _) in parameters! {
        if let data = parameters?[key] as? String {
        multipartFormData.append(data.data(using: .utf8)!, withName: key)
        } else if let data = parameters?[key] as? [Any] {
          multipartFormData.append(data.description.data(using: .utf8)!, withName: key)
        }
      }
      if let uploadImage = image {
        if let imageData = UIImageJPEGRepresentation(uploadImage, 1) {
          multipartFormData.append(imageData, withName: "file",fileName: "file.png", mimeType: "image/png")
        }
      } }, to: requestURL, encodingCompletion: { encodingResult in
        switch encodingResult {
        case .success(let upload, _, _):
          upload.responseJSON { response in
            completion(response)
          }
        default:
          print("Encoding Error")
        //SKU - TODO: How do we handle encoding errors?
        //case .failure(let encodingError):
        }
    })
  }
  
}
