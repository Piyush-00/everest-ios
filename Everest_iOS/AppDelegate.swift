//
//  AppDelegate.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-02.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: NavigationController?
    var testNavCtrl = EventPeopleListNavigationController(nibName: nil, bundle: nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
      Session.manager.updateUserState()
      
      self.window = UIWindow(frame: UIScreen.main.bounds)
      
      var rootView: UIViewController
      
      if Session.manager.isActiveEvent {
        let event = Event()
        event.setId(to: Keychain.get(key: Keys.sharedInstance.EventID) as! String)
        Session.manager.event = event
        
        //TODO: make GET request for event information OR in event flow (profile, page, and feed )
        
        let eventContainerViewController = EventContainerViewController()
        let eventNavigationViewController = UINavigationController()
        
        eventNavigationViewController.viewControllers = [eventContainerViewController]
        
        self.window!.rootViewController = eventNavigationViewController
      } else {
        rootView = LandingViewController()
        self.navigationController = NavigationController()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.viewControllers = [rootView]
        self.window!.rootViewController = self.navigationController
      }
      
      self.window?.makeKeyAndVisible()
      
      return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
