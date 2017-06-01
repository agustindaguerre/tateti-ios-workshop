import Foundation

protocol RankingView {
    func getPlayersSortedByGamesWon(players: [Player])
    func showError()
}
