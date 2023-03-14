//
//  WordleyViewController.swift
//  Plasticiti
//
//  Created by Rawan Alhindi on 11/19/22.
//

import UIKit
import GameKit

class WordleyViewController: UIViewController{
    
    // answers array
    let answers = [

        "later", "bloke", "there", "ultra", "dealt", "canoe", "arose", "irate", "coals", "ranch", "yards", "stale", "plane", "horse", "stare", "badly", "blimp", "finch", "funny", "audio", "round", "tepid", "stare", "least", "audit", "learn", "ounce", "untie", "strap", "right", "brave", "avert", "there", "baker", "snarl", "maple", "inane", "valet", "medal", "unite", "rainy", "spell", "dream", "photo", "aloud", "inept", "piney", "waltz", "libel", "sneak", "carry", "flout", "foggy", "fault", "spiel", "denim", "spade", "catch", "floor", "equal", "ionic", "valid"
    ]
    
    // initialize answer var
    var answer = ""
    
    // build 2D character array from guesses
    private var guesses: [[Character?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 6
    )

    // assign separate VCs for keyboard and gameboard
    let keyboardVC = Plasticiti.KeyboardViewController()
    let boardVC = BoardViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide GC access point
        GKAccessPoint.shared.isActive = false
        
        // randomize winning answer
        answer = answers.randomElement() ?? "after"
        
        // set bgcolor // hidden by gradient
        view.backgroundColor = #colorLiteral(red: 0.03728873655, green: 0.1320550442, blue: 0.2532687485, alpha: 1) //background 0A2241
        
        // function appends keyboard and gameboard VCs
        addChildren()
        
        // logs randomized answer in console for testing
        print("answer:", answer)
    }
    

    // when called, displays keyboard and gameboard
    private func addChildren(){
        
        // set up keyboard
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        // set up gameboard
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.datasource = self
        view.addSubview(boardVC.view)
        
        // add UIKit layout constraints
        addConstraints()
        
    }
    
    // when called, adds UIKit layout constraints
    func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                 multiplier: 0.65),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    // clears the board
    func clearBaord() {
        guesses = guesses.map { _ in [] }
        boardVC.reloadData()
        print("restarting")

    }
}

extension WordleyViewController: KeyboardViewControllerDelegate {
    func KeyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        print(letter)
        print(answer)
        
        // update the guesses and then let boardvc know to reload
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
        boardVC.reloadData()
    }
}

extension WordleyViewController: BoardViewControllerDatasource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        
        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == 5 else {
            return nil
        }
        
        let indexedAnswer = Array(answer)
        
        guard let letter = guesses[indexPath.section][indexPath.row],
              indexedAnswer.contains(letter) else {
            return nil
        }
        
        //if letter is in correct slot and correct positon return green
        if indexedAnswer[indexPath.row] == letter {
            let optGuesses = guesses[indexPath.row]
            let unwrappedGuesses = optGuesses.flatMap{ $0 }
            if indexedAnswer == unwrappedGuesses {

                // game won

                // Game Center acheivements
                // won at wordley
                let achievment = GKAchievement(identifier: "wonAtWordley")
                achievment.percentComplete = 100
                achievment.showsCompletionBanner = true
                GKAchievement.report([achievment]) { error
                    in
                    guard error == nil else {
                        print(error?.localizedDescription ?? "")
                        return
                    }
                    print("GC achievement added")
                }
                print("game won")

                // reset button

                let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
                    print("before: ", self.guesses)
                    self.clearBaord()
                    print("after: ", self.guesses)
                }))
                self.present(ac, animated: true)
            }
                // returns green if correct letter in correct place
                return #colorLiteral(red: 0.2333551347, green: 0.558046639, blue: 0.5564038157, alpha: 1)
            }
        
            if rowIndex == 5 {

                // game lost
                
                // GC achievement
                // lost at wordley
                let achievment = GKAchievement(identifier: "lostAtWordley")
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
                print("game lost")

                // reset button
                let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
                    print("before: ", self.guesses)
                    self.clearBaord()
                    print("after: ", self.guesses)
                }))
                self.present(ac, animated: true)

                print("game lost")
            }
        // returns orange if correct letter is in incorrect place
        return #colorLiteral(red: 0.959214747, green: 0.6740495563, blue: 0.5677136779, alpha: 1)
        }
    }
