//
//  EventFeedModalContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventFeedModalContainer: UIView {
  var modal = EventFeedModal()
  var socket: NewsFeedSocket? {
    didSet {
      modal.socket = socket
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  convenience init(withNewsFeedSocket socket: NewsFeedSocket) {
    self.init(frame: .zero)
    self.socket = socket
    modal.socket = self.socket!
  }
  
  private func setup() {
    self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    self.addSubview(modal)
    setupConstraints()
  }
  
  private func setupConstraints() {
    let modalWidthRatio: CGFloat = 0.9
    let modalHeightDisplacement: CGFloat = 30.0
    
    modal.translatesAutoresizingMaskIntoConstraints = false
    
    modal.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    modal.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -modalHeightDisplacement).isActive = true
    modal.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: modalWidthRatio).isActive = true
  }
}
