//
//  ChatMessageInputContainer.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-18.
//  Copyright © 2016 Everest. All rights reserved.
//
protocol ChatMessageInputContainerProtocol {
  func didTapSendButton(inputText: String)
}

import UIKit

class ChatMessageInputContainer: UIView {
  
  private let textInputView = UITextField()
  private let sendButton = AppStyle.sharedInstance.baseInputButton()
  
  var delegate: ChatMessageInputContainerProtocol?
  
  init(_ coder: NSCoder? = nil) {
    if let coder = coder {
      super.init(coder:coder)!
    } else {
      super.init(frame: CGRect.zero)
    }
  
    backgroundColor = UIColor.white
    sideBorder(side: .top, width: 1, colour: UIColor.lightGray)
    setupInputComponents()
  }
  
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(aDecoder)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
  }
  
  private func setupInputComponents() {
    textInputView.placeholder = "Enter message..."
    textInputView.font = AppStyle.sharedInstance.headerFontSmall
    
    sendButton.setTitle("Send", for: .normal)
    sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    addSubview(sendButton)
    addSubview(textInputView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    sendButton.translatesAutoresizingMaskIntoConstraints = false
    sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    
    textInputView.translatesAutoresizingMaskIntoConstraints = false
    textInputView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    textInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    textInputView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8).isActive = true
    textInputView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  @objc private func didTapSendButton(){
    if ((textInputView.text?.characters.count)! > 0) {
      delegate?.didTapSendButton(inputText: textInputView.text!)
      textInputView.clearText()
    }
  }
}
