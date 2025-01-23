//
//  PlanetDetailViewModel.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 20/1/25.
//
import Foundation

class PlanetDetailViewModel: ObservableObject {
    public struct PlanetStatistics {
        let terrain: [String]
        let climate: [String]
        let diameter: String
        let gravity: String
    }

    @Published private(set) var title: String
    @Published private(set) var statistics: PlanetStatistics
    @Published private(set) var populationDescription: String

    //MARK: Init
    init(planet: PlanetEntity) {
        self.title = Self.formatTitle(from: planet.name)
        self.statistics = Self.buildStatistics(from: planet)
        self.populationDescription = planet.population?.formatAmountNumber() ?? "Unknown Population"
    }

    static func buildStatistics(from planet: PlanetEntity) -> PlanetStatistics {
        return PlanetStatistics(
            terrain: planet.terrain?.splitAndTrimValues() ?? ["Unknown terrain"],
            climate: planet.climate?.splitAndTrimValues() ?? ["Unknown climate"],
            diameter: planet.diameter ?? "Unknown Diameter",
            gravity: planet.gravity ?? "Unknown Gravity"
        )
    }

    static func formatTitle(from name: String?) -> String {
        return name?.isEmpty == false ? name! : "Unknown Planet"
    }
}
