//
//  GameCenterHelper.swift
//  Plasticiti
//
//  Created by Daniel Zimmerman on 12/5/22.
//
import GameKit



class GameCenterHelper: NSObject, GKLocalPlayerListener {
    
    private let leaderboardID = "solved1wordley"
    
    let inviteMessage:String = "Hey there join me for a iVaccination fight!"
    var currentVC: GKMatchmakerViewController?
    
    //
    var viewController: UIViewController?
    init(vc:ViewController) {
        super.init()
        self.viewController = vc
    }
    
    func loadGameCenter(){
            self.authenticate()
    }
    
    func authenticate(){
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            NotificationCenter.default.post(name: Notification.Name.authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)

            if GKLocalPlayer.local.isAuthenticated {
                GKLocalPlayer.local.register(self)
                
                GKAccessPoint.shared.parentWindow = self.viewController?.view.window
                GKAccessPoint.shared.location = .topTrailing
                GKAccessPoint.shared.showHighlights = true
                GKAccessPoint.shared.showHighlights = true
                GKAccessPoint.shared.isActive = GKLocalPlayer.local.isAuthenticated
                

//                let observation2 = GKAccessPoint.shared.observe(
//                         \.isPresentingGameCenter
//                  ) { [weak self] _,_ in
//
//                      if(GKAccessPoint.shared.isPresentingGameCenter){
////                          if let gameSceneObj = (self!.viewController as! ViewController){
//                              if(gameSceneObj.gameRunning){
//                                  gameSceneObj.setGamePaused(isPaused: true)
//                              }
//                          }
//                      }else{
//                          if let gameSceneObj = (self!.viewController as! ViewController){
//                              if(gameSceneObj.gamePaused){
//                                  gameSceneObj.setGamePaused(isPaused: false)
//                              }
//                          }
//                      }
//                }
//                self.observerObj = observation2
            } else if let vc = gcAuthVC {
                    self.viewController?.present(vc, animated: true, completion: {
                      
                    })
            } else {
                print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
            }
        }
    }
    
    func showDashboard(){
        let viewController = GKGameCenterViewController(state: .dashboard)
        viewController.gameCenterDelegate = self

            self.viewController?.present(viewController, animated: true, completion: {
                
            })

    }
    
    func updateScore(with value: Int) {
        GKLeaderboard.submitScore(value, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [self.leaderboardID],  completionHandler: {error in
            if(error != nil){
                print("Error uploading score to Game Center leaderboard: \(String(describing: error))")
            }
        })
    }
    
    func updateCertificates(with value: Int) {
        GKLeaderboard.submitScore(value, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [self.leaderboardID],  completionHandler: {error in
            if(error != nil){
                print("Error uploading score to Game Center leaderboard: \(String(describing: error))")
            }
        })
    }
    
    func updateVaccinations(with value: Int) {
        GKLeaderboard.submitScore(value, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [self.leaderboardID],  completionHandler: {error in
            if(error != nil){
                print("Error uploading score to Game Center leaderboard: \(String(describing: error))")
            }
        })
    }
}



extension GameCenterHelper: GKGameCenterControllerDelegate {
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}

extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}
