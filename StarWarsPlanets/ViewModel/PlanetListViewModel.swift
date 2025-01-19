import Foundation
import CoreData
import SwiftUI

@MainActor
class PlanetsViewModel: ObservableObject {
    @Published var planets: [PlanetEntity] = []
    @Published var isLoading: Bool = false

    private let planetsService: PlanetsServiceProtocol
    private var nextURL: URL?

    init(planetsService: PlanetsServiceProtocol = PlanetsService()) {
        self.planetsService = planetsService
    }

    func fetchPlanets() async {
        guard !isLoading else { return }
        isLoading = true

        do {
            try await planetsService.fetchPlanets(from: nextURL)
            loadPlanetsFromCoreData()
        } catch {
            print("Failed to fetch planets: \(error)")
        }

        isLoading = false
    }

    private func loadPlanetsFromCoreData() {
        let context = PersistenceController.shared.viewContext

        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \PlanetEntity.name, ascending: true)]

        do {
            let fetchedPlanets = try context.fetch(fetchRequest)
            self.planets = fetchedPlanets
        } catch {
            print("Failed to fetch planets from Core Data: \(error)")
        }
    }

    func loadMorePlanets() async {
        guard !isLoading, let nextURL = self.nextURL else { return }
        isLoading = true

        do {
            try await planetsService.fetchPlanets(from: nextURL)
            loadPlanetsFromCoreData()
        } catch {
            print("Failed to load more planets: \(error)")
        }

        isLoading = false
    }
}
