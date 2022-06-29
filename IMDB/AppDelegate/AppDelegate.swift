//
//  AppDelegate.swift
//  IMDB
//
//  Created by Usama on 28/06/2022.
//

import UIKit
import netfox

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // ...
        NFX.sharedInstance().start()
        return true
    }
}
