//
//  DetailViewModel.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Foundation
import UIKit

protocol DetailViewable {
    var playerDatamodel: PlayerDataModel? { get set }
}

class DetailViewModel: DetailViewable {
    var playerDatamodel: PlayerDataModel?
}

extension ResultStatus {
    func getUIcolor() -> UIColor {
        switch self {
        case .draw: return .white
        case .lost: return .red
        case .won: return .green
        }
    }
}
