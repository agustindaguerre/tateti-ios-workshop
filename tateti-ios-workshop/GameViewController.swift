//
//  ViewController.swift
//  tateti-ios-workshop
//
//  Created by Agustin Daguerre on 5/28/17.
//  Copyright © 2017 agustindaguerre. All rights reserved.
//

import UIKit
import SwiftMessages

class GameViewController: UIViewController {
    
    var players: [Player] = []
    var playerOneTurn = true
    var ended = false
    var clickedSpaces: [Int] = []
    
    private let presenter = GamePresenter(appDelegateParam: UIApplication.shared.delegate as? AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        presenter.setPlayers(players: players)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func buttonClick(_ sender: UIButton) {
        if (clickedSpaces.contains(sender.tag) || ended) {
            return
        }
        clickedSpaces.append(sender.tag)
        let buttonSymbol = playerOneTurn ? "X" : "O"
        sender.setTitle(buttonSymbol, for: UIControlState.normal)
        playerOneTurn = !playerOneTurn
        
        ended = presenter.movement(position: sender.tag)
        if (ended) {
            let view = MessageView.viewFromNib(layout: .CardView)
            var config = SwiftMessages.Config()
            config.dimMode = .gray(interactive: true)
            view.button = nil
            
            // Add a drop shadow.
            view.configureDropShadow()
            
            if let winner = presenter.getWinner() {
                // Show winner message
                view.configureTheme(.success)
                let iconText = "🎉"
                view.configureContent(title: "Winner!", body: "\(winner.name!) wins!", iconText: iconText)
            } else {
                // If no winner, game tied
                // Show tied message
                view.configureTheme(.warning)
                let iconText = "😴"
                view.configureContent(title: "Boring!", body: "Game ends in a tie", iconText: iconText)
            }
            
            // Show the message.
            SwiftMessages.show(config: config, view: view)
                
                // Specify one or more event listeners to respond to show and hide events.
            config.eventListeners.append() { event in
                if case .didHide = event { self.navigationController?.popViewController(animated: true) }
            }
        }
    }

}

