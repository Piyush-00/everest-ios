//
//  ModalViewContainer.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-27.
//  Copyright © 2016 Everest. All rights reserved.
//

protocol ModalViewContainerProtocol {
  func didTapModalBackground(view : UIView)
}


import UIKit

class ModalViewContainer: UIView {
  var contentView: BaseInputView
  var backgroundView: UIView
  
  var delegate: ModalViewContainerProtocol?
  
  init(_ coder: NSCoder? = nil) {
    contentView = BaseInputView()
    backgroundView = UIView()
    
    if let coder = coder {
      super.init(coder:coder)!
    } else {
      super.init(frame: CGRect.zero)
    }
  
    contentView.layer.cornerRadius = 10
    contentView.backgroundColor = UIColor(hex: "#ffffff")
    contentView.clipsToBounds = true
    
    addSubview(backgroundView)
    addSubview(contentView)
    
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    setupConstraints()
    animateIn()
  }
  
  private func setupConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.stackView.translatesAutoresizingMaskIntoConstraints = false
    
    backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
    backgroundView.addGestureRecognizer(tapGestureRecognizer)

    
    contentView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 140).isActive = true
    contentView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20).isActive = true
    contentView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20).isActive = true
    contentView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -140).isActive = true
    
    contentView.stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    contentView.stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    contentView.stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
  }
  
  private func animateIn(){
    contentView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
    alpha = 0
    
    UIView.animate(withDuration: 0.2) {
      self.alpha = 1
      self.contentView.transform = CGAffineTransform.identity
    }

  }
  
  private func animateOut(){
    contentView.transform = CGAffineTransform.identity
    alpha = 1
    
    UIView.animate(withDuration: 0.4) {
      self.alpha = 0
      self.contentView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
    }
  }
  
  func setBackgroundColor (color: UIColor, opacity: CGFloat = 0.5){
    backgroundView.backgroundColor = color.withAlphaComponent(opacity)
  }
  
  @objc func didTapBackground(){
    delegate?.didTapModalBackground(view: self)
  }
}
