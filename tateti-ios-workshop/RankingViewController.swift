
import UIKit
import Foundation

private let kCellIdentifier = "kCellIdentifier"

class RankingViewController: UIViewController {
    
    @IBOutlet weak var rankingTable: UITableView!
    
    var players = [PlayerMO]()
    var presenter = RankingPresenter(appDelegateParam: UIApplication.shared.delegate as? AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rankingTable.dataSource = self
        presenter.attachView(view: self)
        presenter.getPlayersSortedByGamesWon()
    }
}

extension RankingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(players.count)
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = rankingTable.dequeueReusableCell(withIdentifier: kCellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: kCellIdentifier)
        }
        
        let player = players[indexPath.row]
        
        let email = player.value(forKeyPath: "email") as! String
        let gamesAsWinner = player.value(forKeyPath: "gamesw") as! Int
        
        cell!.textLabel?.text = "\(email) | Games won \(gamesAsWinner)"
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return cell!
        
    }
}

extension RankingViewController: RankingView {
    func getPlayersSortedByGamesWon(players: [PlayerMO]) {
        self.players = players
        rankingTable.reloadData()
    }
}
