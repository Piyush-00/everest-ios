//
//  UIImageView.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

extension UIImageView {
  private func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit, completionHandler: ((Bool) -> ())? = nil) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else {
          if let completionHandler = completionHandler {
            completionHandler(false)
          }
          return
        }
      DispatchQueue.main.async() { () -> Void in
        self.image = image
        if let completionHandler = completionHandler {
          completionHandler(true)
        }
      }
      }.resume()
  }
  func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, completionHandler: ((Bool) -> ())? = nil) {
    guard let url = URL(string: link) else { return }
    downloadedFrom(url: url, contentMode: mode, completionHandler: completionHandler)
  }
}
