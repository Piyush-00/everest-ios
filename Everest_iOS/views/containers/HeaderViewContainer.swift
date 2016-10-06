//
//  HeaderViewContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class HeaderViewContainer: UIView {
    var headerView: UIView?
    var contentView: UIView?
    var contentTableview: UITableView?
    private var headerHeight: CGFloat?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(frame: UIScreen.main.bounds)
        
        self.headerHeight = 100
        let headerViewRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.headerHeight!)
        let contentViewRect = CGRect(x: 0, y: self.headerHeight!, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - self.headerHeight!))
        
        self.headerView = UIView(frame: headerViewRect)
        self.headerView?.backgroundColor = UIColor.blue
        self.addSubview(self.headerView!)
        
        self.contentView = UIView(frame: contentViewRect)
        self.contentView?.backgroundColor = UIColor.gray
        self.addSubview(self.contentView!)
        
        self.contentTableview = UITableView(frame: (self.contentView?.bounds)!, style:UITableViewStyle.plain)
        self.contentView?.addSubview(self.contentTableview!)
    }
}
