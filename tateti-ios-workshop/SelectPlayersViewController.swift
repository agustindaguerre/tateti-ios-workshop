//
//  SelectPlayersViewController.swift
//  tateti-ios-workshop
//
//  Created by Agustin Daguerre on 5/30/17.
//  Copyright © 2017 agustindaguerre. All rights reserved.
//

import Foundation
import UIKit

fileprivate let kCellIdentifier = "kCellIdentifier"

class SelectPlayersViewController : UIViewController {
    
    private let presenter = PlayerPresenter(appDelegateParam: UIApplication.shared.delegate as? AppDelegate)
    
    var data: [Player] = []
    var selectedItem: Player!
    
    var selectedPlayers: [Player] = []
    
    @IBOutlet weak var playerSelectTable: UITableView!
    
    override func viewDidLoad() {
        playerSelectTable.dataSource = self
        playerSelectTable.delegate = self
        super.viewDidLoad()
        data = presenter.getPlayers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameSegue" {
            let gameController = segue.destination as! GameViewController
            gameController.players = selectedPlayers
        }
    }
}

extension SelectPlayersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: kCellIdentifier)
        }
        let player = data[indexPath.row]
        let name = player.value(forKeyPath: "name") as! String
        let email = player.value(forKeyPath: "email") as! String
        
        cell!.textLabel?.text = "Name \(name) - Email: \(email)"
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return cell!
    }
}

extension SelectPlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlayer = data[indexPath.row]
        selectedPlayers.append(selectedPlayer)
        if (selectedPlayers.count == 2) {
            performSegue(withIdentifier: "gameSegue", sender: self)
        }
    }
}
