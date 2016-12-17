//
//  EventTabBarButtonView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-16.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventTabBarButtonView: UIView {
  private let button = UIButton()
  
  var icon: UIImage? {
    return button.image(for: .normal)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    self.addSubview(button)
    setupConstraints()
  }
  
  private func setupConstraints() {
    button.translatesAutoresizingMaskIntoConstraints = false
    button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
  }
  
  func setIcon(to icon: String?) {
  
  }
  
  func addAction(_ action: Selector) {
    button.addTarget(self, action: action, for: .touchUpInside)
  }
}
