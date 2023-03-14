//
//  ViewController.swift
//  Plasticiti
//
//  Created by Daniel Zimmerman on 11/11/22.
//
import GameKit

class ViewController: UIViewController {
    
    // IB Outlet for username label
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        // GC Access Point
        GKAccessPoint.shared.parentWindow = self.view.window
        GKAccessPoint.shared.isActive = true
        GKAccessPoint.shared.showHighlights = true
        
        // get username
         username.text = "scoopnisker"
        // username.text = GKLocalPlayer.local.alias
        
        // list available fonts
        for family in UIFont.familyNames.sorted(){
            let names = UIFont.fontNames(forFamilyName: family)
            print("family: \(family) Font Names: \(names)")
        }
    }
    
}

// unload CG VC
extension ViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
