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
  var scrollViewContentView: UIView
  var headerViewHeight: CGFloat = 150
  private var keyboardHeight: CGFloat?
  private var scrollViewContentViewHeightConstaint: NSLayoutConstraint
  
  init(_ coder: NSCoder? = nil) {
    
    statusBarView = UIView()
    headerView = UIView()
    contentView = BaseInputView()
    scrollView = UIScrollView()
    scrollViewContentView = UIView()
    scrollViewContentViewHeightConstaint = NSLayoutConstraint()
    
    if let coder = coder {
      super.init(coder:coder)!
    } else {
      super.init(frame: CGRect.zero)
    }
    
    scrollView.delaysContentTouches = false
    scrollView.showsVerticalScrollIndicator = false
    
    self.isUserInteractionEnabled = true
    scrollViewContentView.isUserInteractionEnabled = true
    scrollViewContentView.addSubview(headerView)
    scrollViewContentView.addSubview(contentView)
    
    scrollView.addSubview(scrollViewContentView)
    addSubview(statusBarView)
    addSubview(scrollView)
    
    //SKU - Listeners that are used to adjust the scrollview content based on keyboard height
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    setupConstraints()
  }

  private func setupConstraints() {
    
    translatesAutoresizingMaskIntoConstraints = false
    headerView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    statusBarView.translatesAutoresizingMaskIntoConstraints = false
    scrollViewContentView.translatesAutoresizingMaskIntoConstraints = false
    
    statusBarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    statusBarView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    statusBarView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height).isActive = true
    
    headerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    headerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    headerView.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
    
    contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
    contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    scrollView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
    scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    scrollViewContentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    scrollViewContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    scrollViewContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    scrollViewContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    scrollViewContentViewHeightConstaint = scrollViewContentView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height))
    scrollViewContentViewHeightConstaint.isActive = true

  }
  
  //SKU - Calculate the height of the keyboard to account for the scroll view.
  internal func keyboardDidShow(notification: NSNotification) {
    scrollViewContentViewHeightConstaint.isActive = false
    scrollViewContentViewHeightConstaint = scrollViewContentView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height) + headerViewHeight)
    scrollViewContentViewHeightConstaint.isActive = true
    
    scrollView.delaysContentTouches = false
  }
  
  //SKU - Calculate the height of the keyboard to account for the scroll view.
  internal func keyboardWillHide(notification: NSNotification) {
    
    scrollViewContentViewHeightConstaint.isActive = false
    self.scrollViewContentViewHeightConstaint = self.scrollViewContentView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height))
    self.scrollViewContentViewHeightConstaint.isActive = true
    
    //SKU - The scroll view will set its offset back to 0 smoothly.
    if (scrollView.contentOffset.y != 0) {
      UIView.animate(withDuration: 1000, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
        self.scrollView.contentOffset.y = 0
        }, completion: nil)
    }
    
    scrollView.delaysContentTouches = false
  }
  
  func addArrangedContentSubview(view: UIView){
    contentView.addArrangedSubview(view: view)
  }
  
  func addArrangedHeaderSubview(view: UIView){
    headerView.addSubview(view)
  }
  
  func setHeaderViewHeight(height: CGFloat){
    headerViewHeight = height
    headerView.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
  }
  
}
