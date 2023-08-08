//
//  HomeViewModelTests.swift
//  TournamentTests
//
//  Created by shankar_muthusamy on 07/08/23.
//

import Combine
import Foundation
import XCTest
@testable import Tournament

class HomeViewModelTests: XCTestCase {
    
    var subject: HomeViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        subject = HomeViewModel(networkClient: MockNetworkClient())
    }
    
    func testNetworkCalls() async {
        await subject.getHomeData()
        await MainActor.run {
            
        }
        XCTAssertEqual(subject.playerDatamodel.first?.name, nil)
    }
}

class MockNetworkClient: NetworkClient {
    func fetchData<T>(urlString: String) async throws -> T? where T : Decodable, T : Encodable {
        nil
    }
    
    func fetchData<T>(urlString: String) throws -> AnyPublisher<T, Tournament.StarwarError> where T : Decodable, T : Encodable {
        Result.success(Player(id: 0, icon: "", name: "") as! T).publisher.eraseToAnyPublisher()
    }
}
