//
//  HeaderViewContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKO - UI skeleton composed of a 'header' and 'content' section
class HeaderViewContainer: UIView {
    var topMostView: UIView
    var scrollView: UIScrollView
    var scrollViewContentView: UIView
    var headerView: UIView
    var contentView: UIView
    private var headerViewHeight: CGFloat
    var scrollViewContentViewHeightConstaint: NSLayoutConstraint
    var isKeyboardVisible = false
    
    init(withNavigationBar: Bool, _ coder: NSCoder? = nil) {
        scrollView = UIScrollView()
        scrollViewContentView = UIView()
        headerView = UIView()
        contentView = UIView()
        scrollViewContentViewHeightConstaint = NSLayoutConstraint()
        headerViewHeight = 131
        
        if (withNavigationBar) {
            topMostView = NavigationBarView()
            topMostView.sideBorder(side: .bottom, width: 1, colour: UIColor.black.withAlphaComponent(0.2))
        } else {
            topMostView = StatusBarView()
        }
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: CGRect.zero)
        }
        
        self.backgroundColor = AppStyle.sharedInstance.backgroundColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
        addGestureRecognizer(tapGestureRecognizer)
        
        //SKO - Prioritize touches of scrollView's subviews
        scrollView.delaysContentTouches = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollViewContentView.addSubview(headerView)
        scrollViewContentView.addSubview(contentView)

        scrollView.addSubview(scrollViewContentView)
    
        addSubview(topMostView)
        addSubview(scrollView)
        
        //SKO - Register for 'keyboard did show' notification to get its frame
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(withNavigationBar: false, aDecoder)
    }
    
    //SKO - Setup auto layout constraints once the view has moved to its superview
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }
    
    //SKO - Keyboard showed up notification listener
    func keyboardWillShow(notification: NSNotification) {
      //SKO - prevent scroll view's content size from increasing every time click on textField
      if !isKeyboardVisible {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
          let keyboardHeight = keyboardSize.height
          scrollViewContentViewHeightConstaint.constant += (keyboardHeight + 1)
          isKeyboardVisible = true
        }
        //SKO - Prioritize scrollView touches when active
        if !scrollView.delaysContentTouches {
          scrollView.delaysContentTouches = true
        }
      }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?
          .cgRectValue{
            let keyboardHeight = keyboardSize.height
            scrollViewContentViewHeightConstaint.constant -= (keyboardHeight + 1)
        }
      
        if (scrollView.contentOffset.y != 0) {
            UIView.animate(withDuration: 1000, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.scrollView.contentOffset.y = 0
            }, completion: nil)
        }
      
        //SKO - Go back to prioritizing touches of scrollView's subviews if scroll view no longer scrolling
        if (scrollViewContentViewHeightConstaint.constant == (UIScreen.main.bounds.height - topMostView.bounds.height)) {
            scrollView.delaysContentTouches = false
        }
      
        isKeyboardVisible = false
    }
    
    func setHeaderView(view: UIView) {
        headerView.addSubview(view)
        setHeaderSubviewConstraints(view: view)
    }
    
    func setContentView(view: UIView) {
        contentView.addSubview(view)
    }
    
    private func setupConstraints() {
        //SKO
        /*
         When programmatically setting auto layout constraints, always set property
         'translatesAutoresizingMaskIntoConstraints' of views
         constraining to false.
        */
        translatesAutoresizingMaskIntoConstraints = false
        topMostView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContentView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        topMostView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topMostView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topMostView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: topMostView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        scrollViewContentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        if topMostView is NavigationBarView {
            scrollViewContentViewHeightConstaint = scrollViewContentView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height - (topMostView as! NavigationBarView).getHeight()))
        } else {
            scrollViewContentViewHeightConstaint = scrollViewContentView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height))
        }
        
        scrollViewContentViewHeightConstaint.isActive = true

        headerView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
        
        contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor).isActive = true
    }
    
    private func setHeaderSubviewConstraints(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
    }
    
    //SKO - resignFirstResponder of any UIView when click outside said UIView
    func didTapSelf(sender: UITapGestureRecognizer) {
        for subview in contentView.subviews {
            if subview is BaseInputView {
                if let stackView = (subview as? BaseInputView)?.stackView {
                    for arrangedSubview in stackView.arrangedSubviews {
                        if arrangedSubview.isFirstResponder {
                            arrangedSubview.resignFirstResponder()
                            break
                        }
                    }
                    break
                }
            }
        }
    }
    
    func getHeaderViewHeight() -> CGFloat {
        return headerViewHeight
    }
}
