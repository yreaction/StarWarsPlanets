//
//  Persistence+Planet.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 20/1/25.
//
import CoreData

extension PersistenceController: PersistentStorageProtocol {
    func saveOrUpdatePlanets(_ planets: [Planet]) {
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
