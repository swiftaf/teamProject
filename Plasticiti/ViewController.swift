//
//  ViewController.swift
//  Plasticiti
//
//  Created by Daniel Zimmerman on 11/11/22.
//

import UIKit
import GameKit

class ViewController: UIViewController {

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
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func showAchievements(_ sender: Any) {
    }
    @IBAction func showLeaderboards(_ sender: Any) {
    }
    @IBAction func unlockAchievement(_ sender: Any) {
    }
    @IBAction func submitScore(_ sender: Any) {
    }
}

