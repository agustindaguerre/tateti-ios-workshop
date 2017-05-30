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
    
    func getPlayers() -> [NSManagedObject] {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Player")
        var players: [NSManagedObject] = []
        do {
            players = try managedContext.fetch(fetchRequest)
            print(players.count)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return players
    }
    
    func savePlayer(values: [String : Any?]) {
        let entity = NSEntityDescription.entity(forEntityName: "Player", in: managedContext)!
        
        let player = NSManagedObject(entity: entity, insertInto: managedContext)
        
        for value in values {
            switch value.key {
            case "name":
                player.setValue(value.value! as? String, forKeyPath: "name")
                break
            case "DoB":
                player.setValue(value.value! as? NSDate, forKeyPath: "dob")
                break
            case "email":
                player.setValue(value.value! as? String, forKeyPath: "email")
                break
            default:
                break
                //throw error
            }
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

protocol PlayerView {
}
