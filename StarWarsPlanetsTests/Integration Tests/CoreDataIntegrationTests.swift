//
//  CoreDataIntegrationTests.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import XCTest
@testable import StarWarsPlanets
import CoreData


final class CoreDataIntegrationTests: XCTestCase {
    private var coredataManager: PersistenceController!
    private var mockPersistentContainer: NSPersistentContainer!

    override func setUpWithError() throws {
        coredataManager = PersistenceController()
    }

    func testSaveNewPlanet() {
        //G
        let planet = MockPlanetData.samplePlanet
        //W
        coredataManager.savePlanets([planet])
        //T
        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", planet.name)

        do {
            let results = try coredataManager.viewContext.fetch(fetchRequest) // Use coredataManager's viewContext
            XCTAssertNotNil(results.first, "Planet was not persisted") // Assert planet exists
            XCTAssertEqual(results.first?.name, planet.name, "Planet name does not match")
            XCTAssertEqual(results.first?.population, planet.population, "Planet population does not match")
        } catch {
            XCTFail("Failed to save planet")
        }
    }

    func testUpdateExistingPlanet() {
        //G
        let testPopulation = "1000"
        let originalPlanet = Planet(name: "Madrid", diameter: "test", climate: "test", gravity: "test", terrain: "test", population: "tests")
        let updatedPlanet = Planet(name: "Madrid", diameter: "test", climate: "test", gravity: "test", terrain: "test", population: testPopulation)

        //W
        // Create new planet
        coredataManager.savePlanets([originalPlanet])

        // Update planet
        coredataManager.savePlanets([updatedPlanet])

        //T
        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", "Madrid")

        do {
            let results = try coredataManager.viewContext.fetch(fetchRequest)
            XCTAssertNotNil(results.first, "Planet was not persisted")
            XCTAssertEqual(results.count, 1, "One planet entity with name 'Madrid'")
            XCTAssertEqual(results.first?.population, testPopulation, "Updated population does not match")
            XCTAssertEqual(results.first?.diameter, "test", "Diameter should remain the same after update")
            XCTAssertEqual(results.first?.climate, "test", "Climate should remain the same after update")
            XCTAssertEqual(results.first?.gravity, "test", "Gravity should remain the same after update")
            XCTAssertEqual(results.first?.terrain, "test", "Terrain should remain the same after update")

        } catch {
            XCTFail("Failed to fetch or update planet")
        }
    }
}

