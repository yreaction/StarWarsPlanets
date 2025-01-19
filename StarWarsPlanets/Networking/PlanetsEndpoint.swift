//
//  PlanetsEndpoint.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//
import Foundation

struct PlanetsEndpoint: Endpoint {
    let baseURL: URL
    let path: String
    let method: String = "GET"
    let headers: [String: String]? = ["Content-Type": "application/json"]
    let body: Data? = nil

    init(baseURL: URL = URL(string: "https://swapi.dev/api")!, path: String = "/planets") {
        self.baseURL = baseURL
        self.path = path
    }

    init(nextURL: URL) {
        self.baseURL = nextURL.deletingLastPathComponent()
        self.path = nextURL.path
    }
}
