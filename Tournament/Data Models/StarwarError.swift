//
//  StarwarError.swift
//  Tournament
//
//  Created by Muthusamy, Shankar (S.) on 21/06/23.
//

import Foundation

enum StarwarError: Error {
    case networkError
    case decodeError
    case requestError
    case underlyingError(Error)
    case invalidResponse
}
