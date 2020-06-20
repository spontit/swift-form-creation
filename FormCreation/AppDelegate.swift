//
//  AppDelegate.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        IQKeyboardManager.shared.enable = true
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        // controller identifier sets up in storyboard utilities
        // panel (on the right), it called Storyboard ID
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.START_CONTROLLER) as! StartController
        self.window?.rootViewController = viewController        
        self.window!.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

}

