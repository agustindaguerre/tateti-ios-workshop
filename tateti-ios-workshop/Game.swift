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
    // TODO : Continue with game logic
    func completeGame(winner: Int32) {
        result = winner
        endDate = Date.init(timeIntervalSinceNow: 0) as? NSDate
    }
}
