//
//  ViewController.swift
//  Plasticiti
//
//  Created by Daniel Zimmerman on 11/11/22.
//

import UIKit
import GameKit
import SwiftUI



class ViewController: UIViewController, GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
    }
    
    private func authenticateUser(){
        let player = GKLocalPlayer.local
        
        player.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            if let vc = vc {
                GKAccessPoint.shared.location = .topLeading
                GKAccessPoint.shared.showHighlights = true
                GKAccessPoint.shared.isActive = true
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func showAchievements(_ sender: Any) {
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .achievements
        present(vc, animated: true, completion: nil)
    }
    @IBAction func showLeaderboards(_ sender: Any) {
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .leaderboards
        vc.leaderboardIdentifier = "WordleysWon"
        present(vc, animated: true, completion: nil)
    }
    @IBAction func unlockAchievement(_ sender: Any) {
        let achievment = GKAchievement(identifier: "solved1wordley")
        achievment.percentComplete = 100
        achievment.showsCompletionBanner = true
        GKAchievement.report([achievment]) { error
            in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("done!")
        }
    }
    @IBAction func submitScore(_ sender: Any) {
        let score = GKScore(leaderboardIdentifier: "WordleysWon")
        score.value = 100
        GKScore.report([score]) { error
            in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("done!")
        }
    }
    
}



//extension ViewController: GKGameCenterControllerDelegate {
//    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
//        gameCenterViewController.dismiss(animated: true, completion: nil)
//    }
//}
