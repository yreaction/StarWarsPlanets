//
//  PlanetsServiceMock.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 20/1/25.
//
import Foundation
@testable import StarWarsPlanets

class MockPlanetsService: PlanetsServiceProtocol {
    
    var fetchPlanetsResult: Result<Void, Error>?
    var fetchPlanetsCalled = false
    var lastFetchedURL: URL?

    func fetchPlanets(from url: URL?) async throws -> URL? {
        fetchPlanetsCalled = true
        lastFetchedURL = url
        if let result = fetchPlanetsResult {
            switch result {
            case .success:
                return nil 
            case .failure(let error):
                throw error
            }
        } else {
            throw NetworkError.noData
        }
    }
}
