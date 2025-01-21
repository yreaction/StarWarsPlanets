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
        self.statistics = PlanetStatistics(
            terrain: Self.splitAndTrimValues(planet.terrain, defaultValue: "Uknown Terrain"),
            climate: Self.splitAndTrimValues(planet.climate, defaultValue: "Uknown climate"),
            diameter: planet.diameter ?? "Unknown Diameter",
            gravity: planet.gravity ?? "Unknown Gravity"
        )
        self.populationDescription = Self.formatPopulation(from: planet.population, defaultValue: "Unknown Population")
    }

    static func formatTitle(from name: String?) -> String {
        return name?.isEmpty == false ? name! : "Unknown Planet"
    }

    static func formatPopulation(from population: String?, defaultValue: String) -> String {
        guard let population = population, !population.isEmpty else {
            return defaultValue
        }
        if let number = Double(population) {
            return number.formatted(.number.grouping(.automatic))
        } else {
            return defaultValue
        }
    }
    static func formatDescription(_ description: String?, default defaultValue: String) -> String {
        return description?.isEmpty == false ? description! : defaultValue
    }

    static func splitAndTrimValues(_ description: String?, defaultValue: String) -> [String] {
        guard let description = description, !description.isEmpty else {
            return [defaultValue]
        }
        return description
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces)}
    }
}
