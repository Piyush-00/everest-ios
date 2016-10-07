//
//  CreateEventViewContainer.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-04.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class CreateEventViewContainer: HeaderViewContainer {
    override init(_ coder: NSCoder? = nil) {
        super.init(coder)
        
        let labelOne = UILabel()
        let labelTwo = UILabel()
        let labelThree = UILabel()
        
        labelOne.backgroundColor = UIColor.green
        labelTwo.backgroundColor = UIColor.purple
        labelThree.backgroundColor = UIColor.cyan
        
        self.baseInputStackView.addArrangedSubview(labelOne)
        self.baseInputStackView.addArrangedSubview(labelTwo)
        self.baseInputStackView.addArrangedSubview(labelOne)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
}
