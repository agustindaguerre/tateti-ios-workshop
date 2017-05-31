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
    private let presenter = GamePresenter(appDelegateParam: UIApplication.shared.delegate as? AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
    }

}

