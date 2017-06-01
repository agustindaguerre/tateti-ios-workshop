
import UIKit
import Foundation
import SwiftMessages
import DZNEmptyDataSet

private let kCellIdentifier = "kCellIdentifier"

class RankingViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var rankingTable: UITableView!
    
    var players = [PlayerMO]()
    var presenter = RankingPresenter(appDelegateParam: UIApplication.shared.delegate as? AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rankingTable.dataSource = self
        rankingTable.emptyDataSetSource = self
        rankingTable.emptyDataSetDelegate = self
        rankingTable.tableFooterView = UIView()
        presenter.attachView(view: self)
        presenter.getPlayersSortedByGamesWon()
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attr = [NSFontAttributeName: UIFont(name: "Helvetica", size: 16)]
        return NSAttributedString(string: "We don't have players added yet", attributes: attr)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty")
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
    
    func showError() {
        let view = MessageView.viewFromNib(layout: .CardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.configureContent(title: "Error", body: "There was a problem while fetching players", iconText: "❌")
        SwiftMessages.show(view: view)
    }
}
