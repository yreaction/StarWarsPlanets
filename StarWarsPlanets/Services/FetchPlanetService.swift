//
//  FetchPlanetService.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import Foundation

protocol PlanetsServiceProtocol {
    func fetchPlanets(from url: URL?) async throws -> URL?
    func searchPlanets(query: String) async throws 
}

class PlanetsService: PlanetsServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    private let persistentStorage: PersistentStorageProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         persistentStorage: PersistentStorageProtocol = PersistenceController.shared) {
        self.networkManager = networkManager
        self.persistentStorage = persistentStorage
    }
    
    func fetchPlanets(from url: URL?) async throws -> URL? {
        let endpoint: PlanetsEndpoint
        if let url = url {
            endpoint = PlanetsEndpoint(nextPage: url)
        } else {
            endpoint = PlanetsEndpoint()
        }

        let response: PlanetsResponse = try await networkManager.request(endpoint: endpoint, responseType: PlanetsResponse.self)
        try persistentStorage.saveOrUpdatePlanets(response.results)
        return response.next
    }

    func searchPlanets(query: String) async throws  {
        let searchQuery = QueryType.search(query)
        let planetsSearchEndpoint = PlanetsEndpoint(queries: [searchQuery])
        let response: PlanetsResponse = try await networkManager.request(endpoint: planetsSearchEndpoint, responseType: PlanetsResponse.self)
        try persistentStorage.saveOrUpdatePlanets(response.results)
    }
}
