//
//  AppDelegate.swift
//  Plasticiti
//
//  Created by Daniel Zimmerman on 11/11/22.
//

import GameKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // main Game Center declaration
        let gameCenterHelper:GameCenterHelper!
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! ViewController
        
        // override point for customization after application launch.
        gameCenterHelper = GameCenterHelper(vc: homeVC)
        gameCenterHelper.loadGameCenter()
        
        // authenticate user
        if GKLocalPlayer.local.isAuthenticated {
            homeVC.username?.text = GKLocalPlayer.local.alias
        }
        return true
    }

    // configure new scene
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // discard session
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
    }
}

