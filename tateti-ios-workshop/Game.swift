//
//  Game.swift
//  tateti-ios-workshop
//
//  Created by Agustin Daguerre on 5/30/17.
//  Copyright © 2017 agustindaguerre. All rights reserved.
//

import UIKit
import CoreData

@objc(Game)
class Game: NSManagedObject {
    let winningCombinations =
        [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,5], [2,5,8], [0,4,8], [2,4,7]]
    
    var playerOneTurn = true
    var moves: [(String, Int)] = []
    
    func completeGame(_ result: Int32) {
        self.result = result
        endDate = Date.init(timeIntervalSinceNow: 0) as NSDate
    }
    
    func makePlay(position: Int) -> Bool {
        let currentPlayer = playerOneTurn ? playerOne : playerTwo
        moves.append((currentPlayer!.email!, position))
        playerOneTurn = !playerOneTurn
        if (checkWinner(currentPlayer: currentPlayer!)) {
            completeGame(playerOneTurn ? 2 : 1)
            return true
        } else {
            return false
        }
    }
    
    func gameTied() -> Bool {
        let tied = moves.count >= 9
        if (tied) {
            completeGame(0)
        }
        
        return tied        
    }
    
    func getWinner() -> Player? {
        switch result {
        case 1:
            return playerOne
        case 2:
            return playerTwo
        case 0:
            return nil
        default:
            // Should throw exception
            return nil
        }
    }
    
    private func checkWinner(currentPlayer: Player) -> Bool {
        var winner = false
        var movePositions = moves.map { pair in
            pair.0.isEqual(currentPlayer.email!) ? pair.1 : nil
        }
        
        movePositions = movePositions.filter { position in
            position != nil
        }
        
        var movePositonsInt = movePositions as! [Int]
        movePositonsInt = movePositonsInt.sorted()
        
        movePositonsInt.forEach { position in
            var combination = [position]
            movePositonsInt.forEach { position2 in
                combination.append(position2)
                movePositonsInt.forEach { position3 in
                    combination.append(position3)
                    
                    // Compare with possible winning combos
                    winningCombinations.forEach { winningCombo in
                        let winningComboSorted = winningCombo.sorted()
                        if (winningComboSorted == combination) {
                            winner = true
                        }
                    }
                    
                    combination.popLast()
                }
                
                combination.popLast()
            }
        }
        
        return winner
    }
}
