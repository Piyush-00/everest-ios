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
    var statusBarView: UIView
    var scrollView: UIScrollView
    var headerView: UIView
    var contentView: UIView
    private var keyboardHeight: CGFloat?
    
    init(_ coder: NSCoder? = nil) {
        scrollView = UIScrollView()
        headerView = UIView()
        contentView = UIView()
        statusBarView = UIView()
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: CGRect.zero)
        }
        
        scrollView.delaysContentTouches = false
        
        scrollView.addSubview(headerView)
        scrollView.addSubview(contentView)
    
        addSubview(statusBarView)
        addSubview(scrollView)
        
        //SKO - Register for 'keyboard did show' notification to get its frame
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    //SKO - setup auto layout constraints once the view has moved to its superview
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }
    
    //SKO - Keyboard showed up notification listener
    func keyboardDidShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                //SKO - Take max/min of both dimensions to account for screen rotation (if landscape eventually implemented)
                keyboardHeight = min(keyboardSize.height, keyboardSize.width)
                setupKeyboardConstraints()
            }
        }
    }
    
    func setHeaderView(view: UIView) {
        headerView.addSubview(view)
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
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        statusBarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        statusBarView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        //SKO - Get height of statusBar and use it for constraint
        statusBarView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
        headerView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 131).isActive = true
        
        contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    //SKO - Modify constraints to account for keyboard
    private func setupKeyboardConstraints() {
        if keyboardHeight != nil {
        }
    }
}
