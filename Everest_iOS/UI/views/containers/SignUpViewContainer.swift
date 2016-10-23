//
//  SignUpViewContainer.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-16.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class SignUpViewContainer: UIView {
  var statusBarView: UIView
  var headerView: UIView
  var contentView: BaseInputView
  var scrollView: UIScrollView
  private var keyboardHeight: CGFloat?
  
  init(_ coder: NSCoder? = nil) {
    
    statusBarView = UIView()
    headerView = UIView()
    contentView = BaseInputView()
    scrollView = UIScrollView()
    
    if let coder = coder {
      super.init(coder:coder)!
    } else {
      super.init(frame: CGRect.zero)
    }
    
    scrollView.delaysContentTouches = false
    scrollView.addSubview(headerView)
    scrollView.addSubview(contentView)
    
    addSubview(statusBarView)
    addSubview(scrollView)
    
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(aDecoder)
  }

  private func setupConstraints() {
    
    translatesAutoresizingMaskIntoConstraints = false
    headerView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    statusBarView.translatesAutoresizingMaskIntoConstraints = false
    
    statusBarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    statusBarView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    statusBarView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height).isActive = true
    
    headerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    headerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    headerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
    contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
    contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    scrollView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
    scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    setupConstraints()
  }
  
  func addArrangedContentSubview(view: UIView){
    contentView.addArrangedSubviewToStackView(view: view)
  }
  
  func addArrangedHeaderSubview(view: UIView){
    headerView.addSubview(view)
  }

  
}
