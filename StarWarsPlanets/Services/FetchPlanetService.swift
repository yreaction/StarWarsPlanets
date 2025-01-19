//
//  FetchPlanetService.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import Foundation

protocol PlanetsServiceProtocol {
    func fetchPlanets(from url: URL?) async throws
}

class PlanetsService: PlanetsServiceProtocol {
    private let networkManager: NetworkManager
    private let persistentStorage: PersistentStorageProtocol

    init(networkManager: NetworkManager = NetworkManager(),
         persistentStorage: PersistentStorageProtocol = PersistenceController.shared) {
        self.networkManager = networkManager
        self.persistentStorage = persistentStorage
    }
    
    func fetchPlanets(from url: URL?) async throws {
        let endpoint = url == nil
        ? PlanetsEndpoint()
        : PlanetsEndpoint(nextURL: url!)
        let response: PlanetsResponse = try await NetworkManager.request(endpoint: endpoint, responseType: PlanetsResponse.self)
        try persistentStorage.saveOrUpdatePlanets(response.results)

    }
}
