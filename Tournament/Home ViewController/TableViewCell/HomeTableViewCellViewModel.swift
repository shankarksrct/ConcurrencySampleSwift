//
//  HomeTableViewCellViewModel.swift
//  Tournament
//
//  Created by shankar_muthusamy on 03/08/23.
//

import Foundation

protocol HomeTableViewCellViewable {
    func configure()
}

class HomeTableViewCellViewModel: HomeTableViewCellViewable {

    @Published var avatarImage: String?
    @Published var name: String?
    @Published var score: String?
    
    var playerDataModel: PlayerDataModel
    
    init(playerDataModel: PlayerDataModel) {
        self.playerDataModel = playerDataModel
        configure()
    }
    
    func configure() {
        self.avatarImage = playerDataModel.icon
        self.name = playerDataModel.name
        self.score = "\(playerDataModel.score)"
    }
}
