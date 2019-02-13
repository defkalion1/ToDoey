//
//  AppDelegate.swift
//  ToDoey
//
//  Created by Defkalion on 03/12/2018.
//  Copyright © 2018 Constantine Defkalion. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            _ = try Realm()
            
        } catch {
            
            print("Error with Realm \(error)")
        }
        
        return true
    }
}
