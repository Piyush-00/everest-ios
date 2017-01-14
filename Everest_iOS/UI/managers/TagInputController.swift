//
//  TagInputController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2017-01-13.
//  Copyright © 2017 Everest. All rights reserved.
//
protocol TagInputControllerProtocol: class {
  func didTapAddButton(tagController: TagFlowController)
}

import UIKit

class TagInputController: UIViewController {
  
  private let tagFlowView = TagFlowController()
  private let wrapperView = UIView()
  private let characteristicHeaderLabel = UILabel()
  private let addTagButton = UIButton()
  
  //SKU - Properties
  private let addButtonIconSize: CGFloat = 20
  
  weak var delegate: TagInputControllerProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupHeaderComponent()
    setupTagFlow()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    adjustHeight()
  }
  
  private func setupHeaderComponent() {
    wrapperView.addSubview(characteristicHeaderLabel)
    wrapperView.addSubview(addTagButton)
    view.addSubview(wrapperView)
    
    wrapperView.translatesAutoresizingMaskIntoConstraints = false
    wrapperView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    wrapperView.bottomAnchor.constraint(equalTo: characteristicHeaderLabel.bottomAnchor).isActive = true
    wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    characteristicHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
    characteristicHeaderLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
    characteristicHeaderLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
    characteristicHeaderLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -30).isActive = true
    characteristicHeaderLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
    
    characteristicHeaderLabel.numberOfLines = 0
    characteristicHeaderLabel.lineBreakMode = .byWordWrapping
    characteristicHeaderLabel.font = AppStyle.sharedInstance.textFontMedium
    
    addTagButton.titleLabel?.font = UIFont.fontAwesome(ofSize: addButtonIconSize)
    addTagButton.setTitle(String.fontAwesomeIcon(name: .plus), for: .normal)
    addTagButton.setTitleColor(UIColor.black, for: .normal)
    
    addTagButton.titleLabel?.numberOfLines = 1
    addTagButton.titleLabel?.adjustsFontSizeToFitWidth = true
    addTagButton.titleLabel?.lineBreakMode = .byClipping
    
    addTagButton.translatesAutoresizingMaskIntoConstraints = false
    addTagButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true
    addTagButton.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
    addTagButton.widthAnchor.constraint(equalToConstant: addButtonIconSize).isActive = true
    addTagButton.heightAnchor.constraint(equalToConstant: addButtonIconSize).isActive = true
    
    addTagButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
  }
  
  private func setupTagFlow() {
    tagFlowView.canRemoveCell = true
    tagFlowView.setBackgroundColor(AppStyle.sharedInstance.backgroundColor)
      
    addChildViewController(tagFlowView)
    view.addSubview(tagFlowView.view)
    
    tagFlowView.view.translatesAutoresizingMaskIntoConstraints = false
    tagFlowView.view.heightAnchor.constraint(equalToConstant: 80).isActive = true
    tagFlowView.view.topAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
    tagFlowView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tagFlowView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
  @objc private func didTapAddButton() {
    addTagButton.setTitleColor(UIColor.lightGray, for: .normal)
    Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changeButtonState), userInfo: nil, repeats: false);
    delegate?.didTapAddButton(tagController: tagFlowView)
  }
  
  func changeButtonState() {
    addTagButton.setTitleColor(UIColor.black, for: .normal)
  }
  
  func setTitle(title: String) {
    characteristicHeaderLabel.text = title
  }

  private func adjustHeight() {
    view.bottomAnchor.constraint(equalTo: tagFlowView.view.bottomAnchor).isActive = true
  }
  
  func loadData(inputValues: [String]) {
    tagFlowView.loadData(inputValues: (inputValues))
  }
  
  func getData() -> [String] {
    return tagFlowView.tags
  }
}
