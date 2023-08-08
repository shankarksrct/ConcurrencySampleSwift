//
//  File.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Foundation

struct MatchList: Codable {
    let match: Int
    let player1: Matchplayer
    let player2: Matchplayer
}


struct Matchplayer: Codable {
    let id: Int
    let score: Int
}

extension MatchList {
    func getScore(playerId: Int) -> Int {
        if (player1.id == playerId && player1.score > player2.score) ||
            (player2.id == playerId && player2.score > player1.score) {
            return 3
        } else if (player1.id == playerId && player1.score == player2.score) ||
                    (player2.id == playerId && player2.score == player1.score) {
            return 1
        }
        return 0
    }
}
