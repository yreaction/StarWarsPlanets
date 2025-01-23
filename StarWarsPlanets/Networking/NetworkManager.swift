//
//  NetworkManager.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//
import Foundation

public enum NetworkError: Error {
    case invalidURL
    case decodingError(Error)
    case responseError(statusCode: Int)
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
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.other(NSError(domain: "Not valid HTTPResponse", code: 0, userInfo: nil))
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.responseError(statusCode: httpResponse.statusCode)
            }

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
