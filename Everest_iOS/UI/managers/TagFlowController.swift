//
//  TagFlowController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-11.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class TagFlowController : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  var tags : [String]?
  
  private var collectionView: UICollectionView!
  private var sizingCell : PropertyTagCell = PropertyTagCell()
  private var propertyLabel = UILabel()
  private var cellColor = UIColor.randomColor()
  
  //Attributes
  var canRemoveCell: Bool = false
  
  //Properties
  private var backgroundColor: UIColor = UIColor.white
  
  let test = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()
  
    let layout: UICollectionViewFlowLayout = TagFlowLayoutManager()
    
    self.view.backgroundColor = backgroundColor
    
    collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(PropertyTagCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.backgroundColor = backgroundColor
    self.view.addSubview(propertyLabel)
    self.view.addSubview(collectionView)
    
    propertyLabel.translatesAutoresizingMaskIntoConstraints = false
    propertyLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    propertyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    propertyLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    collectionView.topAnchor.constraint(equalTo: propertyLabel.bottomAnchor, constant: 5).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
  }
  
  func loadData(inputValues: [String]){
    tags = inputValues
  }
  
  func addNewTag(inputText: String){
    tags?.append(inputText)
    collectionView.reloadData()
  }
  
  func reloadData() {
    collectionView.reloadData()
  }
  
  func setBackgroundColor(_ color: UIColor) {
    backgroundColor = color
  }
  
  func configureCell(cell: PropertyTagCell, forIndexPath indexPath: NSIndexPath) {
    if (tags == nil) {
      return
    } else {
      let tag = tags![indexPath.row]
      cell.propertyName = tag
      cell.setTagColor(cellColor)
      
      if (canRemoveCell) {
        cell.addRemoveLabel()
      }
    }
  }
  
  func setTitle (title: String) {
    propertyLabel.text = title
    propertyLabel.font = AppStyle.sharedInstance.headerFontSmall
  }
  
  //MARK - UICollectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if (tags == nil) {
      return 0
    } else {
    return tags!.count
    }
  }
  
  //MARK - UICollectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
    self.configureCell(cell: cell as! PropertyTagCell, forIndexPath: indexPath as NSIndexPath)
    
    return cell
  }
  
  //MARK - UICollectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    self.configureCell(cell: self.sizingCell, forIndexPath: indexPath as NSIndexPath)
    return CGSize(width: self.sizingCell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width + AppStyle.sharedInstance.tagPropertyMargin, height: AppStyle.sharedInstance.tagPropertyHeight)
  }
  
  //MARK - UICollectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if (canRemoveCell) {
      
    tags?.remove(at: indexPath.item)
    self.collectionView.deleteItems(at: [indexPath])
    }
  }
}
