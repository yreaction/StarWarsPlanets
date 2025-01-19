//
//  Persistence.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = PlanetEntity(context: viewContext)
            newItem.name = "Tatooine"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "StarWarsPlanets")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

//MARK: Planets - Save and Update
extension PersistenceController {
    func savePlanets(_ planets: [Planet]) {
        let context = PersistenceController.shared.viewContext
        context.perform {
            let names = planets.map { $0.name }
            let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name IN %@", names)

            var existingPlanetsByName = [String: PlanetEntity]()
            do {
                let existingPlanets = try context.fetch(fetchRequest)
                for planet in existingPlanets {
                    if let name = planet.name {
                        existingPlanetsByName[name] = planet
                    }
                }
            } catch let error as NSError {
                print("Error fetching existing planets: \(error), \(error.userInfo)")
            }

            for planet in planets {
                if let existingPlanet = existingPlanetsByName[planet.name] {
                    self.updatePlanet(existingPlanet, with: planet)
                } else {
                    self.createPlanet(planet, in: context)
                }
            }
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print("Failed to save context: \(error.localizedDescription)")
                }
            }
        }
    }
    private func updatePlanet(_ existingPlanet: PlanetEntity, with planet: Planet) {
        existingPlanet.diameter = planet.diameter
        existingPlanet.climate = planet.climate
        existingPlanet.gravity = planet.gravity
        existingPlanet.terrain = planet.terrain
        existingPlanet.population = planet.population
    }

    private func createPlanet(_ planet: Planet, in context: NSManagedObjectContext) {
        let newPlanet = PlanetEntity(context: context)
        newPlanet.name = planet.name
        newPlanet.diameter = planet.diameter
        newPlanet.climate = planet.climate
        newPlanet.gravity = planet.gravity
        newPlanet.terrain = planet.terrain
        newPlanet.population = planet.population
    }
}
