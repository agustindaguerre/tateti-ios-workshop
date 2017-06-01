//
//  GamePresenter.swift
//  tateti-ios-workshop
//
//  Created by Agustin Daguerre on 5/30/17.
//  Copyright © 2017 agustindaguerre. All rights reserved.

import Foundation
import CoreData

class GamePresenter {
    private var appDelegate: AppDelegate
    private var managedContext: NSManagedObjectContext
    private var currentGame: Game
    
    init(appDelegateParam: AppDelegate?) {
        appDelegate = appDelegateParam!
        managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Game", in: managedContext)!
        currentGame = NSManagedObject(entity: entity, insertInto: managedContext) as! Game
    }
    
    func setPlayers(players: [Player]) {
        currentGame.setValue(players[0], forKeyPath: "playerOne")
        currentGame.setValue(players[1], forKeyPath: "playerTwo")
    }
    
    func movement(position: Int) -> Bool {
        let completed = currentGame.makePlay(position: position) || currentGame.gameTied()
        if (completed) {
            do {
                try managedContext.save()
            } catch let error as NSError {
//                errorMsj = "Could not save. Try again"
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        return completed
    }
    
    func getWinner() -> Player? {
        return currentGame.getWinner()
    }
    
}
