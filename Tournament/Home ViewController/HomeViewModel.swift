//
//  HomeViewModel.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Combine
import Foundation

protocol HomeViewable {
    func getHomeData() async
    func getHomeData() throws -> AnyPublisher<[PlayerDataModel],StarwarError>
    var playerDatamodel: [PlayerDataModel] { get set }
}

class HomeViewModel: HomeViewable {
    let playerUrlString = "https://api.npoint.io/ca180e840b481675d500"
    let matchListUrlString = "https://api.npoint.io/bc3f07c7442e85446788"
    
    let networkClient: NetworkClient
    var playerDatamodel: [PlayerDataModel] = []
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getHomeData() async {
        do {
            async let playerdata: [Player] = try networkClient.fetchData(urlString: playerUrlString) ?? []
            async let matchData: [MatchList] = try networkClient.fetchData(urlString: matchListUrlString) ?? []
            playerDatamodel =  try await getPlayerDataModel(players: playerdata, matchList: matchData)
        } catch {
            //Error to be handled here
            /*
             async let a = something Int
             async let b = something Int
             let c = await (a + b)
             
             */
        }
    }
    
    func getPlayerDataModel(players: [Player], matchList: [MatchList]) async -> [PlayerDataModel] {
        return players.map { $0.asPlayerDataModel(matchList: matchList, players: players) }
    }
    
    func getHomeData() throws -> AnyPublisher<[PlayerDataModel],StarwarError> {
        let playerList: AnyPublisher<[Player], StarwarError> = try networkClient.fetchData(urlString: playerUrlString)
        let matchList: AnyPublisher<[MatchList], StarwarError> = try networkClient.fetchData(urlString: matchListUrlString)
        return Publishers.CombineLatest(playerList, matchList)
        .map { playerData, matchData in
            return self.getPlayerDataModel(players: playerData, matchList: matchData)
        }
        .eraseToAnyPublisher()
    }
    
    func getPlayerDataModel(players: [Player], matchList: [MatchList]) -> [PlayerDataModel] {
        return players.map { $0.asPlayerDataModel(matchList: matchList, players: players) }
    }
}
