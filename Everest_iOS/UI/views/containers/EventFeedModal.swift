//
//  EventFeedModal.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventFeedModal: UIView, UITextViewDelegate {
  private let headerView = UIView()
  private let contentView = UIView()
  private let footerView = UIView()
  private let cancelButton = UIButton()
  private let wordCountLabel = UILabel()
  private let postTextView = BaseInputTextView(hintText: NSLocalizedString("feed modal text placeholder", comment: "event feed modal text placeholder"))
  private let postButton = UIButton()

  private var wordCount: Int = 200 {
    willSet {
      wordCountLabel.text = String(newValue)
      if newValue < 0 {
        if !(wordCountLabel.textColor == UIColor.red.withAlphaComponent(0.6)) {
           wordCountLabel.textColor = UIColor.red.withAlphaComponent(0.6)
        }
        if postButton.isEnabled {
          postButton.isEnabled = false
        }
      } else {
        if (wordCountLabel.textColor == UIColor.red.withAlphaComponent(0.6)) {
          wordCountLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        }
        if !postButton.isEnabled {
          postButton.isEnabled = true
        } else {
          if newValue == 200 {
            postButton.isEnabled = false
          }
        }
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    animateIn()
  }
  
  private func setup() {
    let appStyle = AppStyle.sharedInstance
    
    self.layer.cornerRadius = 10.0
    self.clipsToBounds = true
    self.backgroundColor = .white
    
    cancelButton.setTitle("X", for: .normal)
    cancelButton.setTitleColor(.black, for: .normal)
    cancelButton.titleLabel?.font = appStyle.textFontBold
    cancelButton.setTitleColor(UIColor.black.withAlphaComponent(0.6), for: .normal)
    cancelButton.addTarget(self, action: #selector(didClickCancelButton), for: .touchUpInside)
    cancelButton.layer.cornerRadius = 10.0
    cancelButton.clipsToBounds = true
    
    wordCountLabel.font = appStyle.textFontMedium
    wordCountLabel.alpha = 0.6
    wordCountLabel.text = String(wordCount)
    
    headerView.backgroundColor = appStyle.backgroundColor
    headerView.sideBorder(side: .bottom, width: 1.0, colour: UIColor.black.withAlphaComponent(0.2))
    headerView.addSubview(wordCountLabel)
    headerView.addSubview(cancelButton)
    
    postTextView.delegate = self
    postTextView.textContainerInset = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 40.0)
    
    contentView.addSubview(postTextView)
    
    postButton.setTitle(NSLocalizedString("post button", comment: "event feed modal post button"), for: .normal)
    postButton.setBackgroundImage(AppUtil.resizableImageWithColor(color: appStyle.baseInputSecondaryButtonColor), for: .normal)
    postButton.addTarget(self, action: #selector(didClickPostButton), for: .touchUpInside)
    postButton.layer.cornerRadius = 4.0
    postButton.clipsToBounds = true
    postButton.titleLabel?.font = appStyle.textFontBold
    postButton.isEnabled = false
    
    footerView.backgroundColor = appStyle.backgroundColor
    footerView.sideBorder(side: .top, width: 1.0, colour: UIColor.black.withAlphaComponent(0.2))
    footerView.addSubview(postButton)
    
    self.addSubview(headerView)
    self.addSubview(contentView)
    self.addSubview(footerView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    let headerViewHeight: CGFloat = 40.0
    let cancelButtonDimension: CGFloat = 40.0
    let wordCountLabelLeadingMargin: CGFloat = 10.0
    let postButtonWidth: CGFloat = 120.0
    let postButtonHeight: CGFloat = 40.0
    let postButtonTrailingMargin: CGFloat = 10.0
    let footerViewHeight: CGFloat = 60.0
    let contentViewHeight: CGFloat = 150.0
    
    headerView.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
    postTextView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    postButton.translatesAutoresizingMaskIntoConstraints = false
    footerView.translatesAutoresizingMaskIntoConstraints = false
    
    headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    headerView.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
    
    wordCountLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
    wordCountLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: wordCountLabelLeadingMargin).isActive = true
    
    cancelButton.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
    cancelButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
    cancelButton.widthAnchor.constraint(equalToConstant: cancelButtonDimension).isActive = true
    cancelButton.heightAnchor.constraint(equalToConstant: cancelButtonDimension).isActive = true
    
    contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
    contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    contentView.heightAnchor.constraint(equalToConstant: contentViewHeight).isActive = true
    
    postTextView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    postTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    postTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    postTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    
    footerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    footerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    footerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    footerView.heightAnchor.constraint(equalToConstant: footerViewHeight).isActive = true
    
    postButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
    postButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -postButtonTrailingMargin).isActive = true
    postButton.widthAnchor.constraint(equalToConstant: postButtonWidth).isActive = true
    postButton.heightAnchor.constraint(equalToConstant: postButtonHeight).isActive = true
  }
  
  func didClickCancelButton(sender: UIButton) {
    self.superview?.removeFromSuperview()
  }
  
  func didClickPostButton(sender: UIButton) {
    
  }
  
  private func animateIn() {
    self.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
    alpha = 0
    
    UIView.animate(withDuration: 0.2) {
      self.alpha = 1
      self.transform = CGAffineTransform.identity
    }
  }
  
  //SKO - Emulate placeholder text functionality
  func textViewDidChange(_ textView: UITextView) {
    if let textView = textView as? BaseInputTextView {
      if textView.text == "" {
        textView.placeholderLabel.isHidden = false
      } else {
        textView.placeholderLabel.isHidden = true
      }
    }
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "" {
      wordCount += range.length
    } else {
      wordCount -= text.characters.count
    }
  
    return true
  }
}
