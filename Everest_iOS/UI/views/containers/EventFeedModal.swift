//
//  EventFeedModal.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventFeedModal: UIView, UITextViewDelegate {
  private let cancelButton = UIButton()
  private let wordCountLabel = UILabel()
  private let postTextView = BaseInputTextView(hintText: NSLocalizedString("feed modal text placeholder", comment: "event feed odal text placeholder"))
  private let postButton = UIButton()
  
  private let wordCountMax: Int = 200
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    let appStyle = AppStyle.sharedInstance
    
    cancelButton.setTitle("X", for: .normal)
    cancelButton.addTarget(self, action: #selector(didClickCancelbutton), for: .touchUpInside)
    
    wordCountLabel.font = appStyle.textFontSmallRegular
    wordCountLabel.alpha = 0.2
    wordCountLabel.text = String(wordCountMax)
    
    postTextView.delegate = self
    
    postButton.setTitle(NSLocalizedString("post button", comment: "event feed modal post button"), for: .normal)
    postButton.backgroundColor = appStyle.baseInputSecondaryButtonColor
    postButton.addTarget(self, action: #selector(didClickPostButton), for: .touchUpInside)
    
    self.addSubview(cancelButton)
    self.addSubview(wordCountLabel)
    self.addSubview(postTextView)
    self.addSubview(postButton)
  }
  
  private func setupConstraints() {
    let modalWidthRatio: CGFloat = 0.9
    let modalHeightRatio: CGFloat = 0.25
    let cancelButtonDimension: CGFloat = 20.0
    let postTextViewWidthRatio: CGFloat = 0.9
    let postTextViewHeightRatio: CGFloat = 0.75
    let postButtonWidth: CGFloat = 120.0
    let postButtonHeight: CGFloat = 40.0
    
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
    postTextView.translatesAutoresizingMaskIntoConstraints = false
    postButton.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func didClickCancelbutton(sender: UIButton) {
    
  }
  
  func didClickPostButton(sender: UIButton) {
    
  }
}
