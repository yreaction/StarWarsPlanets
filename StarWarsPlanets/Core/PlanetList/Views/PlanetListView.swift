//
//  ContentView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 19/1/25.
//

import SwiftUI
import CoreData

struct PlanetListView: View {
    @StateObject private var viewModel = PlanetListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.planets, id: \.self) { planet in
                    NavigationLink {
                        PlanetDetailView(viewModel: PlanetDetailViewModel(planet: planet))
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
            .navigationTitle("Star Wars Planets")
        }
    }
}

#Preview {
    PlanetListView()
}
