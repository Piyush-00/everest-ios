//
//  NavigationController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation
import UIKit

/* SKO
 The class used as the root navigation controller for the app.
*/
class NavigationController: UINavigationController {
    var currentAnimationType = animationType.void
    
    //SKO - same functionality as the original pushViewController, but just lets you specify what direction to transition in
    func pushViewController(_ viewController: UIViewController, withAnimation animation: animationType) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        
        switch animation {
        case .fromBottom:
            transition.subtype = kCATransitionFromBottom
            currentAnimationType = .fromBottom
            break
        case .fromTop:
            transition.subtype = kCATransitionFromTop
            currentAnimationType = .fromTop
            break
        case .fromRight:
            transition.subtype = kCATransitionFromRight
            currentAnimationType = .fromRight
            break
        case .fromLeft:
            transition.subtype = kCATransitionFromLeft
            currentAnimationType = .fromLeft
            break
        default:
            return
        }
        
        self.view.layer.add(transition, forKey: nil)
        self.pushViewController(viewController, animated: false)
    }
    
    //SKO - same functionality as the original popViewController, but just lets you specify what direction to transition in
    func popViewController(withAnimation animation: animationType) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush

        switch animation {
        case .fromBottom:
            transition.subtype = kCATransitionFromBottom
            currentAnimationType = .fromBottom
            break
        case .fromTop:
            transition.subtype = kCATransitionFromTop
            currentAnimationType = .fromTop
            break
        case .fromRight:
            transition.subtype = kCATransitionFromRight
            currentAnimationType = .fromRight
            break
        case .fromLeft:
            transition.subtype = kCATransitionFromLeft
            currentAnimationType = .fromLeft
            break
        default:
            return
        }
        
        self.view.layer.add(transition, forKey: nil)
        _ = self.popViewController(animated: false)
    }
    
    //SKO - used to pop back to a view with the animation opposite of what it was pushed with
    func getPopAnimationType() -> animationType {
        var popAnimationType = animationType.void
        
        switch currentAnimationType {
        case .fromTop:
            popAnimationType = .fromBottom
            break
        case .fromBottom:
            popAnimationType = .fromTop
            break
        case .fromLeft:
            popAnimationType = .fromRight
            break
        case .fromRight:
            popAnimationType = .fromLeft
            break
        default:
            break
        }
        
        return popAnimationType
    }
}
