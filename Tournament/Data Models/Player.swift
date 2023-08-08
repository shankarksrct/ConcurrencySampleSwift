//
//  Player.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Foundation

struct Player: Codable {
    let id: Int
    let icon: String
    let name: String
}

extension Player {
    func asPlayerDataModel(matchList: [MatchList], players: [Player]) -> PlayerDataModel {
        let matchesplayed = matchList.filter { ($0.player1.id == id) || ($0.player2.id == id) }
        let score = matchesplayed.reduce(0) { $0 + $1.getScore(playerId: id) }
        
        let playerMatchDetails = matchesplayed.map { matchList in
            
            let player1Name = matchList.player1.id == id ? name : players.first(where: { $0.id == matchList.player1.id })?.name
            let player2Name = matchList.player2.id == id ? name : players.first(where: { $0.id == matchList.player2.id })?.name
            
            return PlayerMatchDetails(
                player1Id: matchList.player1.id,
                player1Name: player1Name,
                player1score: matchList.player1.score,
                player2id: matchList.player2.id,
                player2Name: player2Name,
                player2Score: matchList.player2.score,
                resultStatus: ResultStatus(rawValue: matchList.getScore(playerId: id))
            )
        }
        
        return PlayerDataModel(id: id, name: name, icon: icon, score: score, playerMatchDetails: playerMatchDetails)
    }
}
