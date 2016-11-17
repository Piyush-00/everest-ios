//
//  BaseInputView.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-06.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

//SKO
/*
 Allows conforming classes to access point in lifecycle where
 stackview's frame has been set.
 Currently being used to check if a headerAndStackViewContainer
 is scrollable by default.
*/
protocol BaseInputViewProtocol {
  func stackviewFramesDidGetSet()
}

//SKO
/*
 UI skeleton for embedded stack view that
 specifies in containing textFields and 
 textViews.
*/
class BaseInputView: UIView {
    var stackView: UIStackView
    var baseInputTextViewHeightConstraintConstant: CGFloat = 100
    var baseInputTextFieldHeightConstraintConstant: CGFloat = 40
    var causesScrollingByDefault: Bool?
  
    var delegate: BaseInputViewProtocol?
  
    init(_ coder: NSCoder? = nil) {
        stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.fill
        stackView.spacing = 20
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(frame: CGRect.zero)
        }
        
        addSubview(stackView)
    }
    
    required convenience init(coder: NSCoder) {
        self.init(coder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    delegate?.stackviewFramesDidGetSet()
  }
  
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppStyle.sharedInstance.baseInputViewSideMargin).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppStyle.sharedInstance.baseInputViewSideMargin).isActive = true
    }
    
    private func setupStackViewContraints(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        //SKO - Set appropriate constraints according to what type of field it is
        if view is BaseInputTextView {
            view.heightAnchor.constraint(equalToConstant: baseInputTextViewHeightConstraintConstant).isActive = true
        } else if view is BaseInputTextField {
            view.heightAnchor.constraint(equalToConstant: baseInputTextFieldHeightConstraintConstant).isActive = true
        }
    }
    
  func addArrangedSubviewToStackView(view: UIView, aboveView subview: UIView? = nil) {
    if let subview = subview {
      if let subviewIndex = stackView.arrangedSubviews.index(of: subview) {
        if subviewIndex >= 0 {
          stackView.insertArrangedSubview(view, at: subviewIndex)
        }
      }
    } else {
      stackView.addArrangedSubview(view)
    }
      //SKO - Setup constraints for each arranged subview added
      setupStackViewContraints(view: view)
    }
  
  func spacing(value: CGFloat){
    stackView.spacing = value
  }
}
