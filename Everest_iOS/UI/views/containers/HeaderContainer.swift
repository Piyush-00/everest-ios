//
//  HeaderContainer.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-11.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKU - HeaderContainer is a UI skeleton that can be used in views with descriptive headers
class HeaderContainer: UIView {
  
  private var topMostView: UIView
  private var contentView: UIView? = nil
  private var headerLabel: UILabel? = nil
  
  init(withNavigationBar: Bool, _ coder: NSCoder? = nil) {
    
    if (withNavigationBar) {
      topMostView = NavigationBarView()
      topMostView.sideBorder(side: .bottom, width: 1, colour: UIColor.black.withAlphaComponent(0.2))
    } else {
      topMostView = StatusBarView(defaultBackground: true)
    }
  
    if let coder = coder {
      super.init(coder: coder)!
    } else {
      super.init(frame: CGRect.zero)
    }
    self.backgroundColor = AppStyle.sharedInstance.backgroundColor
    addSubview(topMostView)
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(withNavigationBar: false, aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    setupGeneralConstraints()
  }

  private func setupGeneralConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    
    topMostView.translatesAutoresizingMaskIntoConstraints = false
    topMostView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    topMostView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    topMostView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
  }
  
  func setHeaderLabel(label: String){
    headerLabel = UILabel()
    contentView = UIView()
    contentView?.addSubview(headerLabel!)
    self.addSubview(contentView!)
    
    headerLabel?.text = label
    headerLabel?.font = AppStyle.sharedInstance.headerFontMedium
    headerLabel?.textColor = AppStyle.sharedInstance.regularTextWhiteColor
    
    contentView?.translatesAutoresizingMaskIntoConstraints = false
    contentView?.topAnchor.constraint(equalTo: topMostView.bottomAnchor).isActive = true
    contentView?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    contentView?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    contentView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    //SKU - set up header constraints.
    headerLabel?.translatesAutoresizingMaskIntoConstraints = false
    headerLabel?.centerXAnchor.constraint(equalTo: (contentView?.centerXAnchor)!).isActive = true
    headerLabel?.centerYAnchor.constraint(equalTo: (contentView?.centerYAnchor)!).isActive = true
  }
}
