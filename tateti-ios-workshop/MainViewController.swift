//
//  MainViewController.swift
//  tateti-ios-workshop
//
//  Created by Agustin Daguerre on 5/29/17.
//  Copyright © 2017 agustindaguerre. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func newGameClick(_ sender: UIButton) {
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
    
    @IBAction func newPlayerClick(_ sender: UIButton) {
        performSegue(withIdentifier: "playerSegue", sender: self)
    }
}
