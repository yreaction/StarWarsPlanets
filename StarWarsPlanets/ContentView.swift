//
//  ContentView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import SwiftUI
import CoreData

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PlanetsViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.planets, id: \.self) { planet in
                    NavigationLink {
                    } label: {
                        Text(planet.name ?? "Unknown Planet")
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .navigationTitle("Star Wars Planets")
            .onAppear {
                Task {
                    await viewModel.fetchPlanets()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
