//
//  StarWarsPlanetsApp.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import SwiftUI

@main
struct StarWarsPlanetsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PlanetListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
