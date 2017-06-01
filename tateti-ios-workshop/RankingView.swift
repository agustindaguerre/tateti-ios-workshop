import Foundation

protocol RankingView {
    func getPlayersSortedByGamesWon(players: [PlayerMO])
    func showError()
}
