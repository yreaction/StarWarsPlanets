//
//  ContentView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import SwiftUI
import CoreData

import SwiftUI

struct PlanetListView: View {
    @StateObject private var viewModel = PlanetsViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.planets, id: \.self) { planet in
                    NavigationLink {
                    } label: {
                        Text(planet.name ?? "Unknown Planet")
                            .task {
                                if planet == viewModel.planets.last, viewModel.hasNextPage {
                                    await viewModel.loadMorePlanets()
                                }
                            }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .navigationTitle("Star Wars Planets")
            .refreshable {
                Task {
                    await viewModel.refreshPlanets()
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchPlanets()
                }
            }
        }
    }
}

#Preview {
    PlanetListView()
}
