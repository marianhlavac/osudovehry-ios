//
//  AppDelegate.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 21/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBar: UITabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let tabBar = UITabBarController()
        
        // Tabs
        let upcomingEventsViewController = EventTableViewController(type: .upcoming)
        let allEventsViewController = EventTableViewController(type: .all)
        let resultsViewController = ResultsTableViewController()
        let settingsViewController = SettingsTableViewController()
        
        tabBar.viewControllers = [ upcomingEventsViewController, allEventsViewController, resultsViewController, settingsViewController ]
        
        // Fetch data on load
        APIWrapper.service.fetchData()
        upcomingEventsViewController.displayActivityIndicator(center: window.center)
        allEventsViewController.displayActivityIndicator(center: window.center)
        
        // Register notifications
        SettingsTableViewController.setupNotifications()
        
        window.rootViewController = UINavigationController(rootViewController: tabBar)
        window.makeKeyAndVisible()
        
        self.window = window
        self.tabBar = tabBar
        
        if (UserDefaults.standard.bool(forKey: "firstRun")) {
            let introViewController = IntroViewController(introCallback: switchRootViewControllerToDefault)
            window.rootViewController = introViewController
            UserDefaults.standard.setValue(true, forKey: "firstRun")
        }
        
        return true
    }
    
    func switchRootViewControllerToDefault() {
        window?.rootViewController = UINavigationController(rootViewController: tabBar!)
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


}

