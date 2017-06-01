//
//  ViewController.swift
//  tateti-ios-workshop
//
//  Created by Agustin Daguerre on 5/28/17.
//  Copyright © 2017 agustindaguerre. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var players: [Player] = []
    var playerOneTurn = true
    var ended = false
    
    private let presenter = GamePresenter(appDelegateParam: UIApplication.shared.delegate as? AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        presenter.setPlayers(players: players)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func buttonClick(_ sender: UIButton) {
        if (ended) {
            return
        }
        
        let buttonSymbol = playerOneTurn ? "X" : "O"
        sender.setTitle(buttonSymbol, for: UIControlState.normal)
        playerOneTurn = !playerOneTurn
        
        ended = presenter.movement(position: sender.tag)
        if (ended) {
            if let winner = presenter.getWinner() {
                // Show winner message
            } else {
                // If no winner, game tied
                // Show tied message
            }
        }
    }

}

