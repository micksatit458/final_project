//
//  AppDelegate.swift
//  tradeFinal
//
//  Created by Satit Nangnoi on 2/4/2563 BE.
//  Copyright © 2563 Satit Nangnoi. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db)
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        // Override point for customization after application launch.
        return true
    }
    
    func application(application: UIApplication,
                   openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {

    var flag: Bool = false

        if let googlePlusFlag: Bool = GIDSignIn.sharedInstance().handle(url as URL, sourceApplication: sourceApplication!, annotation: annotation) {
      flag = googlePlusFlag
    }

    return flag
    }
    
    
    
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
    return handled
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

