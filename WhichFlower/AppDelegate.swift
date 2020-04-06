//
//  AppDelegate.swift
//  WhichFlower
//
//  Created by aisenur on 29.03.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do {
            _ = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL, "***************")
        } catch {
            print("Error initializing new realm, \(error)")
        }
        
        return true
    }

}

