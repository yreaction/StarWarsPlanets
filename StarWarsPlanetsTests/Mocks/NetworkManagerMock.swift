//
//  NetworkManagerMock.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 20/1/25.
//

import Foundation
@testable import StarWarsPlanets

class NetworkManagerMock: NetworkManagerProtocol {
    var mockResponse: Data?
    var mockError: Error?
    var delayInSeconds: TimeInterval = 0

    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type) async throws -> T {
        // Simulate network delay if needed
        if delayInSeconds > 0 {
            try await Task.sleep(nanoseconds: UInt64(delayInSeconds * 1_000_000_000))
        }

        // Simulate an error if one is set
        if let error = mockError {
            throw error
        }

        // Simulate a successful response
        if let responseData = mockResponse {
            let decoder = JSONDecoder()
            do {
                let decodedResponse = try decoder.decode(T.self, from: responseData)
                return decodedResponse
            } catch {
                throw NetworkError.invalidURL
            }
        }

        // If no mock response is set, throw no data error
        throw NetworkError.noData
    }
}
