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
import SwiftMessages

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
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
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
        let result = presenter.savePlayer(values: form.values())
        let view = MessageView.viewFromNib(layout: .CardView)
        var config = SwiftMessages.Config()
        config.dimMode = .gray(interactive: true)
        config.duration = .seconds(seconds: 1.5)
        view.button = nil
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        if (result.saved) {
            // Theme message elements with the warning style.
            view.configureTheme(.success)
            let iconText = "✅"
            view.configureContent(title: "Success!", body: "Player created", iconText: iconText)
            // Specify one or more event listeners to respond to show and hide events.
            config.eventListeners.append() { event in
                if case .didHide = event { self.navigationController?.popViewController(animated: true) }
            }
        } else {
            // Theme message elements with the warning style.
            view.configureTheme(.error)
            let iconText = "❌"
            view.configureContent(title: "Create player error", body: result.error, iconText: iconText)
        }
        
        // Show the message.
        SwiftMessages.show(config: config, view: view)
        
    }
    
}
