//
//  TopViewController.swift
//  Plasticiti
//
//  Created by Daniel Zimmerman on 12/14/22.
//

import UIKit
import GameKit

class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismiss(animated: true)
        GKAccessPoint.shared.parentWindow = self.view.window
        GKAccessPoint.shared.isActive = true
        GKAccessPoint.shared.showHighlights = true
        // Do any additional setup after loading the view.
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "homeVC") as! ViewController
        self.present(vc, animated: true)
        
        
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toNextVC" {
            let vc = segue.destination as! ViewController
            vc.username.text = GKLocalPlayer.local.alias
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
