//
//  PlayerDataModel.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Foundation

struct PlayerDataModel {
    let id: Int
    let name: String
    let icon: String
    let score: Int
    let playerMatchDetails: [PlayerMatchDetails]
}

struct PlayerMatchDetails {
    let player1Id: Int
    let player1Name: String?
    let player1score: Int
    let player2id: Int
    let player2Name: String?
    let player2Score: Int
    let resultStatus: ResultStatus?
}

enum ResultStatus: Int {
    case lost = 0
    case draw = 1
    case won = 3
}
