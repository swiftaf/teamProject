//
//  ViewController.swift
//  Plasticiti
//
//  Created by Daniel Zimmerman on 11/11/22.
//

import UIKit
import GameKit
//import SwiftUI


class ViewController: UIViewController {
    
//    var gameCenterHelper:GameCenterHelper!
    
    
    @IBOutlet weak var username: UILabel!
  
    
    
    
//    func getTopMostViewController() -> UIViewController? {
//        var topMostViewController = UIApplication.shared.windows[0].rootViewController
//
//        while let presentedViewController = topMostViewController?.presentedViewController {
//            topMostViewController = presentedViewController
//        }
//
//        return topMostViewController
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")


//        loadView()
//        print("view:",view!)
        GKAccessPoint.shared.parentWindow = self.view.window
        GKAccessPoint.shared.isActive = true
        GKAccessPoint.shared.showHighlights = true
        
//        while GKLocalPlayer.local.isAuthenticated != true {
//            username.text = "Not Logged In"
//        }
//        self.loadView()
        username.text = GKLocalPlayer.local.alias
        
        
        //  if username != nil {
//            username.text = GKLocalPlayer.local.alias
//        } else {
//            username.text = "User"
//        }

        //print("parent window:", GKAccessPoint.shared.parentWindow)
    }
    

   
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        print("GKLocalPlayer.local.alias:", GKLocalPlayer.local.alias)

//        if GKLocalPlayer.local.isAuthenticated {
//            username.text = GKLocalPlayer.local.alias
//        } else {
//            self.loadView()
//            username.text = GKLocalPlayer.local.alias
//        }
        
//
//
//        GKAccessPoint.shared.isActive = true
//        GKAccessPoint.shared.showHighlights = true
//
//
    }
    
    

    
    
    

    

//    let profileVC = GKGameCenterViewController(state: .localPlayerProfile)
//    profileVC;.gameCenterDelegate = self
//
//    present(profileVC, animated: true, completion: nil)


}



//    func authenticateUser(){
//        let player = GKLocalPlayer.local
//
//        player.authenticateHandler = { vc, error in
//            guard error == nil else {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//            if let vc = vc {
//                GKAccessPoint.shared.location = .topLeading
//                GKAccessPoint.shared.showHighlights = true
//                GKAccessPoint.shared.isActive = true
//                self.present(vc, animated: true, completion: nil)
//                self.username.text = player.displayName;
//
//            }
//        }
//    }
//
    
    
//    @IBAction func showAchievements(_ sender: Any) {
//        let vc = GKGameCenterViewController()
//        vc.gameCenterDelegate = self
//        vc.viewState = .achievements
//        present(vc, animated: true, completion: nil)
//    }
//    @IBAction func showLeaderboards(_ sender: Any) {
//        let vc = GKGameCenterViewController()
//        vc.gameCenterDelegate = self
//        vc.viewState = .leaderboards
//        vc.leaderboardIdentifier = "WordleysWon"
//        present(vc, animated: true, completion: nil)
//    }
//    @IBAction func unlockAchievement(_ sender: Any) {
//        let achievment = GKAchievement(identifier: "solved1wordley")
//        achievment.percentComplete = 100
//        achievment.showsCompletionBanner = true
//        GKAchievement.report([achievment]) { error
//            in
//            guard error == nil else {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//            print("done!")
//        }
//    }
//    @IBAction func submitScore(_ sender: Any) {
//        let score = GKScore(leaderboardIdentifier: "WordleysWon")
//        score.value = 200
//        GKScore.report([score]) { error
//            in
//            guard error == nil else {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//            print("done!")
//        }
//    }
//
//}



extension ViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
//extension GKAccessPoint {
//  enum Location : Int {
//    init?(rawValue: Int)
//    var rawValue: Int { get }
//    case topLeading
//    case topTrailing
//    case bottomLeading
//    case bottomTrailing
//  }
//}
//@available(iOS 14.0, *)
//class GKAccessPoint : NSObject {
//  class var shared: GKAccessPoint { get }
//  var isActive: Bool
//  var isVisible: Bool { get }
//  var isPresentingGameCenter: Bool { get }
//  var showHighlights: Bool
//  var location: GKAccessPoint.Location
//  var frameInScreenCoordinates: CGRect { get }
//  weak var parentWindow: @sil_weak UIWindow?
//  func trigger(handler: @escaping () -> Void)
//  func trigger(state: GKGameCenterViewControllerState, handler: @escaping () -> Void)
//}




