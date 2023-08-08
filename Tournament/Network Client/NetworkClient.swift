//
//  NetworkClient.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Combine
import Foundation

protocol NetworkClient {
    func fetchData<T: Codable>(urlString: String) async throws -> T?
    func fetchData<T:Codable>(urlString: String) throws -> AnyPublisher<T, StarwarError>
}

class NetworkClientImp: NetworkClient {
    
    func fetchData<T: Codable>(urlString: String) async throws -> T? {
        guard let url = URL(string: urlString) else {
            throw StarwarError.requestError
        }
        //let (data, response) = try await URLSession.shared.data(from: url)
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let response: HTTPURLResponse = response as? HTTPURLResponse,
                   (200...299).contains(response.statusCode),
                   error == nil,
                    let data {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        continuation.resume(returning: model)
                    } catch {
                        continuation.resume(throwing: StarwarError.decodeError)
                    }
                }
            }.resume()
        }
    }
    
    func fetchDataWithModernConcurrency<T: Codable>(urlString: String) async throws -> T? {
        guard let url = URL(string: urlString) else {
            throw StarwarError.requestError
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        if let response: HTTPURLResponse = response as? HTTPURLResponse,
           (200...299).contains(response.statusCode) {
            return try JSONDecoder().decode(T.self, from: data)
        }
        throw StarwarError.invalidResponse
    }
    
    func fetchData<T:Codable>(urlString: String) throws -> AnyPublisher<T, StarwarError> {
        guard let url = URL(string: urlString) else {
            throw StarwarError.requestError
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                if let response: HTTPURLResponse = response as? HTTPURLResponse,
                   (200...299).contains(response.statusCode) {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    return model
                }
                throw StarwarError.decodeError
            }
            .mapError { error in
                if let starwarError: StarwarError = error as? StarwarError {
                    return starwarError
                }
                return StarwarError.underlyingError(error)
            }
            .eraseToAnyPublisher()
    }
}
