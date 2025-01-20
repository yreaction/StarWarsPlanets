//
//  PlanetsServiceTests.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 20/1/25.
//
import XCTest
@testable import StarWarsPlanets

class PlanetsServiceTests: XCTestCase {

    var planetsService: PlanetsService!
    var mockNetworkManager: NetworkManagerMock!
    var mockPersistentStorage: PersistentStorageMock!

    override func setUp() {
        super.setUp()
        mockNetworkManager = NetworkManagerMock()
        mockPersistentStorage = PersistentStorageMock()
        planetsService = PlanetsService(networkManager: mockNetworkManager, persistentStorage: mockPersistentStorage)
    }

    override func tearDown() {
        planetsService = nil
        mockNetworkManager = nil
        mockPersistentStorage = nil
        super.tearDown()
    }

    func testFetchPlanetsSuccess() async {
        // GIVEN
        let mockPlanets = [Planet(name: "Tatooine", diameter: "10465", climate: "arid", gravity: "1", terrain: "desert", population: "200000")]
        let mockResponse = PlanetsResponse(count: 1, next: nil, previous: nil, results: mockPlanets)

        let encoder = JSONEncoder()
        guard let mockResponseData = try? encoder.encode(mockResponse) else {
            XCTFail("Failed to encode mock response")
            return
        }

        // WHEN
        mockNetworkManager.mockResponse = mockResponseData
        mockNetworkManager.mockError = nil

        //THEN
        do {
            try await planetsService.fetchPlanets(from: nil)
            XCTAssertTrue(mockPersistentStorage.saveOrUpdatePlanetsCalled)
        } catch {
            XCTFail("Fetch failed with error: \(error)")
        }
    }

    func testFetchPlanetsFailure() async {
        // GIVEN
        mockNetworkManager.mockError = NSError(domain: "TestError", code: 0, userInfo: nil)

        // THEN
        do {
            try await planetsService.fetchPlanets(from: nil)
            XCTFail("Fetch should have failed")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
