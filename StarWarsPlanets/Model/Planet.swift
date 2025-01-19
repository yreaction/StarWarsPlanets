//
//  PlanetRemoteModel.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//
import Foundation
struct PlanetsResponse: Codable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [Planet]
}

struct Planet: Codable {
    let name: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let population: String
}

