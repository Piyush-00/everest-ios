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
  private var descriptionLabel: UILabel?
  private var dateTextField: BaseInputTextField?
  private var locationTextField: BaseInputTextField?
  private var promptLabel: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerImageView.contentMode = .scaleAspectFill
    headerImageView.layer.masksToBounds = true
    
    headerAndStackViewContainer.setHeaderView(view: headerImageView)
    headerAndStackViewContainer.backgroundColor = .white
    
    self.view.addSubview(headerAndStackViewContainer)
    self.edgesForExtendedLayout = []
    
    headerAndStackViewContainer.baseInputView.spacing(value: 10.0)
    
    setupConstraints()
    
    loadViews()
  }
  
  private func setupConstraints() {
    headerAndStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
    
    headerAndStackViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    headerAndStackViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    headerAndStackViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    headerAndStackViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
  }
  
  //SKO - Should be called in the event info GET request callback once the event singleton has been updated.
  private func loadViews() {
    guard let event = Session.manager.event else {
      fatalError("fatal error: event singleton is nil in EventPageViewController instance.")
    }
    
    let titleToContentConstant: CGFloat = -10.0
    
    self.title = event.getName()
    
    headerImageView.image = event.getHeaderImage() // ?? default image
    
    if let description = event.getDescription() {
      if !description.isEmpty {
        let descriptionLabelContainer = UIView()
        let leftPaddingGuide = UILayoutGuide()
        let bottomPaddingGuide = UILayoutGuide()
        
        descriptionLabel = UILabel()
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.numberOfLines = 0
        descriptionLabel?.lineBreakMode = .byWordWrapping
        descriptionLabel?.font = AppStyle.sharedInstance.textFontMedium
        descriptionLabel?.text = description
        
        descriptionLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabelContainer.addLayoutGuide(leftPaddingGuide)
        descriptionLabelContainer.addSubview(descriptionLabel!)
        //descriptionLabelContainer.addLayoutGuide(bottomPaddingGuide)
        
        leftPaddingGuide.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
        leftPaddingGuide.topAnchor.constraint(equalTo: descriptionLabelContainer.topAnchor).isActive = true
        leftPaddingGuide.bottomAnchor.constraint(equalTo: descriptionLabelContainer.bottomAnchor).isActive = true
        leftPaddingGuide.leadingAnchor.constraint(equalTo: descriptionLabelContainer.leadingAnchor).isActive = true
        
        descriptionLabel?.topAnchor.constraint(equalTo: descriptionLabelContainer.topAnchor).isActive = true
        descriptionLabel?.bottomAnchor.constraint(equalTo: descriptionLabelContainer.bottomAnchor, constant: -10.0).isActive = true
        descriptionLabel?.leadingAnchor.constraint(equalTo: leftPaddingGuide.trailingAnchor).isActive = true
        descriptionLabel?.trailingAnchor.constraint(equalTo: descriptionLabelContainer.trailingAnchor).isActive = true
        
        descriptionContainer = TitleAndContentContainer(withTitle: NSLocalizedString("about", comment: "about placeholder"), andContent: descriptionLabelContainer)
        descriptionContainer?.contentViewTopConstraint.constant = -1.0
        descriptionContainer?.contentViewHeightConstraint.isActive = false
        descriptionContainer?.setNeedsLayout()
        descriptionContainer?.layoutIfNeeded()
        
        headerAndStackViewContainer.addArrangedSubviewToStackView(view: descriptionContainer!)
      }
    }
    
    if let date = event.getDate(),
      let startTime = event.getStartTime(),
      let endTime = event.getEndTime() {
      if !date.isEmpty && !startTime.isEmpty && !endTime.isEmpty {
        dateTextField = BaseInputTextField(hintText: NSLocalizedString("date and time", comment: "date and time placeholder"))
        dateTextField?.isUserInteractionEnabled = false
        dateTextField?.text = "\(date), \(startTime) to \(endTime)."
        dateContainer = TitleAndContentContainer(withTitle: NSLocalizedString("date and time", comment: "date and time placeholder"), andContent: dateTextField!)
        dateContainer?.contentViewTopConstraint.constant = titleToContentConstant
        dateContainer?.setNeedsLayout()
        dateContainer?.layoutIfNeeded()
        headerAndStackViewContainer.addArrangedSubviewToStackView(view: dateContainer!)
      }
    }
    
    if let location = event.getLocation() {
      if !location.isEmpty {
        locationTextField = BaseInputTextField(hintText: NSLocalizedString("location", comment: "location placeholder"))
        locationTextField?.isUserInteractionEnabled = false
        locationTextField?.text = location
        locationContainer = TitleAndContentContainer(withTitle: NSLocalizedString("location", comment: "location placeholder"), andContent: locationTextField!)
        locationContainer?.contentViewTopConstraint.constant = titleToContentConstant
        locationContainer?.setNeedsLayout()
        locationContainer?.layoutIfNeeded()
        headerAndStackViewContainer.addArrangedSubviewToStackView(view: locationContainer!)
      }
    }
  }
}
