//
//  ContentView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PlanetEntity.name, ascending: true)],
        animation: .default)
    private var planets: FetchedResults<PlanetEntity>

    var body: some View {
        NavigationView {
            List {
                ForEach(planets) { planet in
                    NavigationLink {

                    } label: {
                        Text(planet.name ?? "planet")
                    }
                }
            }
        }
    }

}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
