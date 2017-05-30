//
//  PlayerPresenter.swift
//  tateti-ios-workshop
//
//  Created by Agustin Daguerre on 5/30/17.
//  Copyright © 2017 agustindaguerre. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PlayerPresenter {
    private var appDelegate: AppDelegate
    private var managedContext: NSManagedObjectContext
    
    init(appDelegateParam: AppDelegate?) {
        appDelegate = appDelegateParam!
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    private func getPlayers(email: String) -> [PlayerMO] {
        // filter predicate
        let predicate = NSPredicate(format: "email == %@", email)
        // fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Player")
        fetchRequest.predicate = predicate
        
        var players: [PlayerMO] = []
        do {
            players = try managedContext.fetch(fetchRequest) as! [PlayerMO]
            print(players.count)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return players
    }
    
    private func getPlayerAttributes(values: [String : Any?]) -> (name: String, dob: NSDate, email: String) {
        var result: (String, NSDate, String) = ("", NSDate(), "")
        
        for value in values {
            switch value.key {
            case "name":
                result.0 = value.value! as! String
                break
            case "DoB":
                result.1 = value.value! as! NSDate
                break
            case "email":
                result.2 = value.value! as! String
                break
            default:
                break
                //throw error
            }
        }
        
        return result
    }
    
    func savePlayer(values: [String : Any?]) -> (saved: Bool, error: String) {
        var result = true
        var errorMsj = ""
        let playerAttrs = getPlayerAttributes(values: values)
        
        if (getPlayers(email: playerAttrs.email).count > 0) {
            result = false
            errorMsj = "Player with \(playerAttrs.2) email already exists"
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Player", in: managedContext)!
        let player = NSManagedObject(entity: entity, insertInto: managedContext)
        
        player.setValue(playerAttrs.name, forKeyPath: "name")
        player.setValue(playerAttrs.dob, forKeyPath: "dob")
        player.setValue(playerAttrs.email, forKeyPath: "email")
        
        if (result) {
            do {
                try managedContext.save()
            } catch let error as NSError {
                result = false
                errorMsj = "Could not save. Try again"
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        return (result, errorMsj)
    }
}

protocol PlayerView {
}
