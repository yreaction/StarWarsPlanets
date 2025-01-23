//
//  PlanetListItemViewModel.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 22/1/25.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class PlanetListItemViewModel: ObservableObject {
    @Published var planetName: String
    @Published var population: String
    @Published var climate: [String]
    private(set) var planet: PlanetEntity
    init(planet: PlanetEntity) {
        self.planet = planet
        self.planetName = planet.name ?? "Unknown Planet"
        self.population = planet.population?.formatAmountNumber() ?? "Unknown Population"
        self.climate = planet.climate?.splitAndTrimValues() ?? []
    }
}

