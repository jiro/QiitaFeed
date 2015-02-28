//
//  AppDelegate.swift
//  QiitaFeed
//
//  Created by Jiro Nagashima on 2/26/15.
//  Copyright (c) 2015 Jiro Nagashima. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let stubbing = false
        // let stubbing = true

        if stubbing {
            QiitaProvider.sharedProvider = QiitaProvider.StubbingProvider()
        }

        return true
    }
}
