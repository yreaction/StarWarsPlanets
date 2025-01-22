//
//  NetworkManager.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//
import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case other(Error)
}
protocol NetworkManagerProtocol {
    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    func request<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path ?? "")
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(responseType, from: data)
            return decodedResponse
        } catch let error as DecodingError {
            throw NetworkError.decodingError(error)
        } catch {
            throw NetworkError.other(error)
        }
    }
}
