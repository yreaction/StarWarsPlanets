import Foundation
import CoreData
import SwiftUI

@MainActor
class PlanetListViewModel: ObservableObject {
    @Published var planets: [PlanetEntity] = []
    @Published var isLoading: Bool = false
    @Published var hasNextPage: Bool = false

    private let planetsService: PlanetsServiceProtocol
    private var nextURL: URL?

    init(planetsService: PlanetsServiceProtocol = PlanetsService()) {
        self.planetsService = planetsService
    }

    func fetchPlanets() async {
        guard !isLoading else { return }
        isLoading = true

        do {
            self.nextURL = try await planetsService.fetchPlanets(from: nextURL)
            self.hasNextPage = (self.nextURL != nil)
            loadPlanetsFromCoreData()

        } catch {
            print("Failed to fetch planets: \(error)")
            loadPlanetsFromCoreData()
            //TODO: Check if it's empty or error
            self.hasNextPage = false
        }

        isLoading = false
    }

    func loadMorePlanets() async {
        guard !isLoading, hasNextPage, let nextURL = self.nextURL else { return }
        isLoading = true

        do {
                self.nextURL = try await planetsService.fetchPlanets(from: nextURL)
                self.hasNextPage = (self.nextURL != nil)
            loadPlanetsFromCoreData()
        } catch {
            print("Failed to load more planets: \(error)")
            //TODO: Check if it's empty or error
            self.hasNextPage = false
        }

        isLoading = false
    }
    
    func isLastPlanet(planet: PlanetEntity) -> Bool {
        guard let lastPlanet = planets.last else {
            return false
        }
        return planet === lastPlanet
    }

    func refreshPlanets() async {
        self.planets.removeAll()
        self.nextURL = nil
        Task {
            await fetchPlanets()
        }
    }
}

private extension PlanetListViewModel {
    func loadPlanetsFromCoreData() {
        let context = PersistenceController.shared.viewContext

        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \PlanetEntity.timeStamp, ascending: true)]

        do {
            let fetchedPlanets = try context.fetch(fetchRequest)
            planets = fetchedPlanets

        } catch {
            print("Failed to fetch planets from Core Data: \(error)")
        }
    }
}
