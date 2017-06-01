import Foundation
import CoreData

class RankingPresenter {
    private var rankingView: RankingView?
    private var managedContext: NSManagedObjectContext
    private var appDelegate: AppDelegate
    
    init(appDelegateParam: AppDelegate?) {
        appDelegate = appDelegateParam!
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func attachView(view: RankingView) {
        rankingView = view
    }
    
    func getPlayersSortedByGamesWon() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "Player")
        let sortDescriptor = NSSortDescriptor(key: "gamesw", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        var playersByGamesWon = [PlayerMO]()
        
        do {
            playersByGamesWon = try managedContext.fetch(request) as! [PlayerMO]
        } catch _ as NSError {
            self.showError()
        }
        self.rankingView?.getPlayersSortedByGamesWon(players: playersByGamesWon)
    }
    
    func showError() {
        self.rankingView?.showError()
    }
}
