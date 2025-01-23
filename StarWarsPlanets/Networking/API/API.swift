//
//  API.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 23/1/25.
//
import Foundation

enum API {
    static let baseURL = URL(string: "https://swapi.dev/api")!
    enum Path: String {
        case planets = "/planets"
    }

    static func endpoint(for path: Path, queries: [QueryType] = []) -> URL {
        let url = baseURL.appendingPathComponent(path.rawValue)
        let queryItems = queries.map { $0.asQueryItem() }
        guard !queryItems.isEmpty else {
            return url
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components?.url ?? url
    }
}
