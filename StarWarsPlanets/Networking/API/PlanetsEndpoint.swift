//
//  PlanetsEndpoint.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//
import Foundation

struct PlanetsEndpoint: Endpoint {
    let baseURL: URL
    var path: String
    let method: String = "GET"
    let headers: [String: String]? = [
        "Content-Type": "application/json",
        "Cache-Control": "no-cache",
        "Pragma": "no-cache"
    ]
    let queryItems: [URLQueryItem]?

    init(path: API.Path = .planets, queries: [QueryType] = []) {
        self.baseURL = API.baseURL
        self.path = path.rawValue
        self.queryItems = queries.map { $0.asQueryItem() }
    }

    init(nextPage: URL) {
        self.baseURL = nextPage
        self.path = ""
        self.queryItems = nil
    }

    func url() -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components?.url ?? baseURL
    }
}
