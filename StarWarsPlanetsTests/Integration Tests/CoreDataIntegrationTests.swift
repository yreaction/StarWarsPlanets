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
        // GIVEN
        let planet = MockPlanetData.samplePlanet
        
        // WHEN
        coredataManager.saveOrUpdatePlanets([planet])

        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", planet.name)

        // THEN
        do {
            let results = try coredataManager.viewContext.fetch(fetchRequest)
            XCTAssertNotNil(results.first, "Planet was not persisted")
            XCTAssertEqual(results.first?.name, planet.name, "Planet name does not match")
            XCTAssertEqual(results.first?.population, planet.population, "Planet population does not match")
        } catch {
            XCTFail("Failed to save planet")
        }
    }

    func testUpdateExistingPlanet() {
        // GIVEN
        let testPopulation = "1000"
        let originalPlanet = Planet(name: "Madrid", diameter: "test", climate: "test", gravity: "test", terrain: "test", population: "tests")
        let updatedPlanet = Planet(name: "Madrid", diameter: "test", climate: "test", gravity: "test", terrain: "test", population: testPopulation)

        // WHEN
        coredataManager.saveOrUpdatePlanets([originalPlanet])
        coredataManager.saveOrUpdatePlanets([updatedPlanet])
        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", "Madrid")

        //THEN
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

