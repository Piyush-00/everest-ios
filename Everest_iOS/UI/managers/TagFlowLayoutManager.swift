//
//  FlowLayoutManager.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-12-11.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class TagFlowLayoutManager : UICollectionViewFlowLayout {
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let attributesForElementsinRect = super.layoutAttributesForElements(in: rect)
    var newAttributesForElementsinRect = [UICollectionViewLayoutAttributes]()
    
    var leftMargin: CGFloat = 0.0
    
    for attributes in attributesForElementsinRect! {
      let refAttributes = attributes.copy() as! UICollectionViewLayoutAttributes
      //SKU - assign value if next row
      if (refAttributes.frame.origin.x == self.sectionInset.left) {
        leftMargin = self.sectionInset.left
      } else {
        //SKU - set x position of attributes to current margin
        var newLeftAlignedFrame = refAttributes.frame
        newLeftAlignedFrame.origin.x = leftMargin
        refAttributes.frame = newLeftAlignedFrame
      }
      //SKU - calculate new value for current margin
      leftMargin += refAttributes.frame.size.width + AppStyle.sharedInstance.tagPropertySpacing
      newAttributesForElementsinRect.append(refAttributes)
    }
    return newAttributesForElementsinRect
  }
  
}
