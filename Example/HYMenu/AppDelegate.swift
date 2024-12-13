//
//  AppDelegate.swift
//  HYMenu
//
//  Created by HENRY on 02/12/2022.
//  Copyright (c) 2022 HENRY. All rights reserved.
//

import UIKit
import HYMenu
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: ViewController())
        nav.view.backgroundColor = .blue
        let left = MenuViewController(nibName: "MenuViewController", bundle: nil)
        left.view.backgroundColor = .brown
        let right = MenuViewController(nibName: "MenuViewController", bundle: nil)
        right.view.backgroundColor = .red
        let menu = HYMenuViewController.shared
        menu.setupLeft(left).setupCenter(nav).setupRight(right)
        left.selectedIndexPath = { indexPath in
            switch indexPath.row {
            case    0:
                nav.view.backgroundColor = .white
            case    1:
                nav.view.backgroundColor = .green
            case    2:
                nav.view.backgroundColor = .yellow
            default:
                break
            }
            menu.closeSideMenu(edges: .left)
        }
        right.selectedIndexPath = { indexPath in
            switch indexPath.row {
            case    0:
                nav.view.backgroundColor = .white
            case    1:
                nav.view.backgroundColor = .green
            case    2:
                nav.view.backgroundColor = .yellow
            default:
                break
            }
            menu.closeSideMenu(edges: .right)
        }
        window?.rootViewController = menu
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

