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
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func newGameClick(_ sender: UIButton) {
        performSegue(withIdentifier: "gameStorySegue", sender: self)
    }
    
    @IBAction func newPlayerClick(_ sender: UIButton) {
        performSegue(withIdentifier: "playerSegue", sender: self)
    }
    @IBAction func viewRanking(_ sender: UIButton) {
        performSegue(withIdentifier: "rankingSegue", sender: self)
    }
}
