//
//  PlanetsEndpoint.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//
import Foundation

struct PlanetsEndpoint: Endpoint {
    static let baseURLString = "https://swapi.dev/api"
    let baseURL: URL
    var path: String?
    let method: String = "GET"
    let headers: [String: String]? = [
        "Content-Type": "application/json",
        "Cache-Control": "no-cache",
        "Pragma": "no-cache"
    ]
    let body: Data? = nil

    init(baseURL: URL = URL(string: PlanetsEndpoint.baseURLString)!, path: String = "/planets") {
        self.baseURL = baseURL
        self.path = path
    }
    
    init(nextPage: URL) {
        self.baseURL = nextPage
    }
}
