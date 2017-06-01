//
//  GamePresenter.swift
//  tateti-ios-workshop
//
//  Created by Agustin Daguerre on 6/1/17.
//  Copyright © 2017 agustindaguerre. All rights reserved.
//

import Foundation
import CoreData

class GamePresenter {
    private var appDelegate: AppDelegate
    private var managedContext: NSManagedObjectContext
    private var currenGame: Game
    
    init(appDelegateParam: AppDelegate?) {
        appDelegate = appDelegateParam!
        managedContext = appDelegate.persistentContainer.viewContext
        currentGame = Game()
    }
    
    
}
