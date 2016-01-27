//
//  AppDelegate.swift
//  StateMachine
//
//  Created by Mike on 1/22/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = CDPlayerViewController()
        return true
    }
}