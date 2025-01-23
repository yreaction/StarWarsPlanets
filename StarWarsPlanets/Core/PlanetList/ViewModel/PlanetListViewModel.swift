import Foundation
import CoreData
import SwiftUI

@MainActor
class PlanetListViewModel: ObservableObject {
    @Published var planets: [PlanetEntity] = []
    @Published var isLoading: Bool = false
    @Published var hasNextPage: Bool = false
    @Published var errorMessage: String?

    private let planetsService: PlanetsServiceProtocol
    private var nextURL: URL?

    init(planetsService: PlanetsServiceProtocol = PlanetsService()) {
        self.planetsService = planetsService
    }

    func fetchPlanets() async {
        await performFetch(resetData: false)
    }

    func loadMorePlanets() async {
        guard hasNextPage else { return }
        await performFetch(resetData: false)
    }

    func refreshPlanets() async {
        await performFetch(resetData: true)
    }

    func isLastPlanet(planet: PlanetEntity) -> Bool {
        guard let lastPlanet = planets.last else { return false }
        return planet === lastPlanet
    }
}

private extension PlanetListViewModel {
    func performFetch(resetData: Bool) async {
        guard !isLoading else { return }
        isLoading = true

        if resetData {
            self.planets.removeAll()
            self.nextURL = nil
        }

        do {
            nextURL = try await planetsService.fetchPlanets(from: nextURL)
            hasNextPage = (nextURL != nil)
        } catch {
            handleError(error)
            hasNextPage = false
        }

        loadPlanetsFromCoreData()
        isLoading = false
    }

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

    func handleError(_ responseError: Error) {
        if let error = responseError as? NetworkError {
            switch error {
            case .invalidURL:
                print("ERROR: Invalid URL")
            case .decodingError(let error):
                print("ERROR: Decoding error: \(error.localizedDescription)")
            case .responseError(let statusCode):
                switch statusCode {
                case 404:
                    errorMessage = "Resource not found"
                default:
                    errorMessage = "Service error: \(statusCode)"
                }
            case .other(let error):
                errorMessage = "Unexpected Error:" + error.localizedDescription
            }
        }
    }
}
