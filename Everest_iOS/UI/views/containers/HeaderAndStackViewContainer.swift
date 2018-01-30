//
//  HeaderAndStackViewContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-07.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKO 
/*
 UI skeleton composed of a 'header' and 'content' section,
 the content section containing a stack view for uniform
 subview layout.
*/
class HeaderAndStackViewContainer: HeaderViewContainer, BaseInputViewProtocol {
    var baseInputView: BaseInputView
    var contentViewHeightConstraint: NSLayoutConstraint?
    var isScrollableByDefault: Bool?
    var isCurrentlyScrollable: Bool?
    var gotDefaultScrollability = false
  
    override init(withNavigationBar: Bool, _ coder: NSCoder? = nil) {
        baseInputView = BaseInputView()
        
        if let coder = coder {
            super.init(withNavigationBar: false, coder)
        } else {
            super.init(withNavigationBar: withNavigationBar)
        }
      
        baseInputView.delegate = self
        setContentView(view: baseInputView)
      
        //SKO - Register for 'keyboard did show' notification to get its frame
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(withNavigationBar: false, aDecoder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
        
        //SKO - Since sideBorder depends on constraints, call here
        contentView.sideBorder(side: .top, width: 1, colour: UIColor.black.withAlphaComponent(0.2))
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        baseInputView.translatesAutoresizingMaskIntoConstraints = false
        
        baseInputView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        baseInputView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        baseInputView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        baseInputView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

    }
  
    //SKO - Keyboard showed up notification listener
    @objc func keyboardWillShow(notification: NSNotification) {
      isCurrentlyScrollable = getIsCurrentlyScrollable()
      //SKO - prevent scroll view's content size from increasing every time click on textField
      if !isKeyboardVisible {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
          let keyboardHeight = keyboardSize.height
          if let isScrollableByDefault = isScrollableByDefault {
            if isScrollableByDefault {
              contentViewHeightConstraint?.constant += (keyboardHeight + 1)
            } else {
              scrollViewContentViewHeightConstaint.constant += (keyboardHeight + 1)
            }
          }
          isKeyboardVisible = true
        }
        //SKO - Prioritize scrollView touches when active
        if !scrollView.delaysContentTouches {
          scrollView.delaysContentTouches = true
        }
      }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?
        .cgRectValue{
        let keyboardHeight = keyboardSize.height
        if let isScrollableByDefault = isScrollableByDefault {
          if isScrollableByDefault {
            contentViewHeightConstraint?.constant -= (keyboardHeight + 1)
          } else {
            scrollViewContentViewHeightConstaint.constant -= (keyboardHeight + 1)
          }
        }
        if let isCurrentlyScrollable = isCurrentlyScrollable {
            UIView.animate(withDuration: 1000, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
              if (self.scrollView.contentOffset.y != 0 && !isCurrentlyScrollable) {
                self.scrollView.contentOffset.y = 0
              }
            }, completion: nil)
        }
      }
      
      //SKO - Go back to prioritizing touches of scrollView's subviews if scroll view no longer scrolling
      if (scrollViewContentViewHeightConstaint.constant == (UIScreen.main.bounds.height - topMostView.bounds.height)) {
        scrollView.delaysContentTouches = false
      }
      
      isKeyboardVisible = false
    }
  
    //SKO - Pass subview on for handling by BaseInputView instance
    func addArrangedSubviewToStackView(view: UIView) {
        baseInputView.addArrangedSubviewToStackView(view: view)
    }
  
    func getIsCurrentlyScrollable() -> Bool {
      return (scrollViewContentView.bounds.height > (UIScreen.main.bounds.height - heightConstraintConstant))
    }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
    //MARK: BaseInputViewProtocol
  
    func stackviewFramesDidGetSet() {
      if !gotDefaultScrollability {
        isScrollableByDefault = (scrollViewContentView.bounds.height > (UIScreen.main.bounds.height - heightConstraintConstant))
        gotDefaultScrollability = true
      }
    }
}
