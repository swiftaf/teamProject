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
        
        // set Game Center Access Point variables
        GKAccessPoint.shared.parentWindow = self.view.window
        GKAccessPoint.shared.isActive = true
        GKAccessPoint.shared.showHighlights = true
        
        // Do any additional setup after loading the view.
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "homeVC") as! ViewController
        self.present(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get GC username
        if segue.identifier == "toNextVC" {
            let vc = segue.destination as! ViewController
            vc.username.text = GKLocalPlayer.local.alias
        }
    }
    

}
