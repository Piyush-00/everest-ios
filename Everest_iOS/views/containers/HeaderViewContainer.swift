//
//  HeaderViewContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class HeaderViewContainer: UIView {
    var headerView: UIView
    var contentView: UIView
    var baseInputStackView: BaseInputStackView
    private var headerHeight: CGFloat
    
    init(_ coder: NSCoder? = nil) {
        self.headerHeight = 100
        let headerViewRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.headerHeight)
        let contentViewRect = CGRect(x: 0, y: self.headerHeight, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - self.headerHeight))
        
        self.headerView = UIView(frame: headerViewRect)
        self.headerView.backgroundColor = UIColor.blue
        
        self.contentView = UIView(frame: contentViewRect)
        self.contentView.backgroundColor = UIColor.gray
        
        self.baseInputStackView = BaseInputStackView()
        self.baseInputStackView.frame = self.contentView.bounds
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: UIScreen.main.bounds)
        }
        
        self.setContentView(view: self.baseInputStackView)
        self.addSubview(self.headerView)
        self.addSubview(self.contentView)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    func setHeaderView(view: UIView) {
        self.headerView.addSubview(view)
    }
    
    func setContentView(view: UIView) {
        self.contentView.addSubview(view)
    }
}
