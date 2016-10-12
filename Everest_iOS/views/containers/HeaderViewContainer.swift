//
//  HeaderViewContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class HeaderViewContainer: UIView {
    var statusBarView: UIView
    var scrollView: UIScrollView
    var headerView: UIView
    var contentView: UIView
    
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
        
        scrollView.addSubview(headerView)
        scrollView.addSubview(contentView)
        
        addSubview(statusBarView)
        addSubview(scrollView)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }
    
    func setHeaderView(view: UIView) {
        headerView.addSubview(view)
    }
    
    func setContentView(view: UIView) {
        contentView.addSubview(view)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        statusBarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        statusBarView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        statusBarView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
    
        headerView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 131).isActive = true
        
        contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
