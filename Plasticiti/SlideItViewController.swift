//
//  SlideItViewController.swift
//  Plasticiti
//
//  Created by Rawan Alhindi on 11/27/22.
//

import UIKit
import GameKit




class SlideItViewController: UIViewController, GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }

    enum Turn{
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross //keep track who's turn to go first
    var currentTurn = Turn.Cross //current turn
    
    var NOUGHT = "O"
    var CROSS = "X"
    var panel = [UIButton]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
        initPanel()
    }
    
    func authenticateUser(){
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
    
    func initPanel() {
        panel.append(a1)
        panel.append(a2)
        panel.append(a3)
        
        panel.append(b1)
        panel.append(b2)
        panel.append(b3)
        
        panel.append(c1)
        panel.append(c2)
        panel.append(c3)
        
    }
    
    @IBAction func boardAction(_ sender: UIButton) {
        addBoard(sender)
        
        if checkForWin(CROSS){
            result(title: "Cross wins!")
        }
        
        if checkForWin(NOUGHT){
            result(title: "O wins!")
        }
        
        
        if checkForEmptySpace() {
            result(title: "Tie")
        }
    }
    
    func checkForWin(_ s: String) -> Bool {
        //Horizontal
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s){
            return true
        }
        
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s){
            return true
        }
        
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s){
            return true
        }
        
        //Vertical
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s){
            return true
        }
        
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s){
            return true
        }
        
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s){
            return true
        }
        
        //Diagonal
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s){
            return true
        }
        
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s){
            return true
        }
        
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func result(title: String)  {
        let achievment = GKAchievement(identifier: "wonAtSlideIt")
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

        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetPanel()
        }))
        self.present(ac, animated: true)
    }
    
    func resetPanel() {
        for button in panel {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        if(firstTurn == Turn.Nought){
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        
        else if(firstTurn == Turn.Cross){
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
    
    
    func checkForEmptySpace() -> Bool {
        for button in panel {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    
    func addBoard(_ sender: UIButton){
        if(sender.title(for: .normal) == nil) {
            
            if(currentTurn == Turn.Nought) {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
                
            }
            
            else if(currentTurn == Turn.Cross) {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
                
            }
            sender.isEnabled = false
        }
    }

}
