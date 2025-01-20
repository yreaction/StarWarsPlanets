//
//  PlanetMock.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import Foundation
@testable import StarWarsPlanets

struct MockPlanetData {
    static let samplePlanet: Planet = {
        return Planet(name: "test", diameter: "test", climate: "test", gravity: "test", terrain: "test", population: "test")
    }()
}
