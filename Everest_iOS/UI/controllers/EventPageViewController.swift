//
//  EventPageViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-12-19.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class EventPageViewController: UIViewController {
  private let headerAndStackViewContainer = HeaderAndStackViewContainer(withNavigationBar: false)
  private let headerImageView = UIImageView()
  private var descriptionContainer: TitleAndContentContainer?
  private var dateContainer: TitleAndContentContainer?
  private var locationContainer: TitleAndContentContainer?
  private var descriptionTextView: BaseInputTextView?
  private var dateTextField: BaseInputTextField?
  private var locationTextField: BaseInputTextField?
  private var promptLabel: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerImageView.contentMode = .scaleAspectFill
    headerImageView.layer.masksToBounds = true
    
    headerAndStackViewContainer.setHeaderView(view: headerImageView)
  }
}
