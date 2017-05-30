//
//  PlayerViewController.swift
//  tateti-ios-workshop
//
//  Created by Agustin Daguerre on 5/29/17.
//  Copyright © 2017 agustindaguerre. All rights reserved.
//

import Eureka
import UIKit
import CoreData

class PlayerViewController : FormViewController {
    
    private let presenter = PlayerPresenter(appDelegateParam: UIApplication.shared.delegate as? AppDelegate)

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("New Player")
            <<< NameRow() { row in
                row.tag = "name"
                row.title = "Name"
                row.placeholder = "Full name"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< DateRow() { row in
                row.tag = "DoB"
                row.title = "Birth date"
                row.value = Date(timeIntervalSinceReferenceDate: 0)
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< EmailRow() { row in
                row.tag = "email"
                row.title = "Email"
                row.placeholder = "name@example.com"
                row.add(rule: RuleRequired())
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesOnDemand
            }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
        form +++ Section()
            <<< ButtonRow() { row in
                row.title = "Done"
            }
                .onCellSelection { cell, row in
                    let errors = self.form.validate()
                    if (errors.count == 0) {
                        // Create a new player
                        self.submitNewPlayer()
                    }
                    
                }
        
        navigationOptions = RowNavigationOptions.Disabled
    }
    
    func submitNewPlayer() {
        presenter.savePlayer(values: form.values())
        let players = presenter.getPlayers()
        
        for player in players {
            let name = player.value(forKeyPath: "name") as? String
            print(name ?? "Failed cast :(")
        }
        
        // TODO: Show notification and wait to dismmis, then go back (?)
        navigationController?.popViewController(animated: true)
    }
    
}
