//
//  PersistenceStorageMock.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 20/1/25.
//

import Foundation
@testable import StarWarsPlanets

class PersistentStorageMock: PersistentStorageProtocol {
    var saveOrUpdatePlanetsCalled = false
    var saveOrUpdatePlanetsResult: Result<Void, Error>?

    func saveOrUpdatePlanets(_ planets: [Planet]) throws {
        saveOrUpdatePlanetsCalled = true

        // Simulate success or failure based on the result set in the mock
        if let result = saveOrUpdatePlanetsResult {
            switch result {
            case .success:
                return
            case .failure(let error):
                throw error
            }
        }
    }
}
