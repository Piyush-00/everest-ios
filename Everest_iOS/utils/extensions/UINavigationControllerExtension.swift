//
//  UINavigationControllerExtension.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-30.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

extension UINavigationController {
    //SKO - animation types pertaining to pushing and popping a view controller on and off the navigation stack, respectivelly. 
    enum animationType {
        case fromTop
        case fromBottom
        case fromLeft
        case fromRight
        case void
    }
}
