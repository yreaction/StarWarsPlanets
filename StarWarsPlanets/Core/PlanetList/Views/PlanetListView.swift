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
    @State private var searchIsActive = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.planets, id: \.self) { planet in
                    PlanetListItemView(
                        viewModel: PlanetListItemViewModel(planet: planet))
                    .task {
                        if viewModel.isLastPlanet(planet: planet) {
                            Task {
                                await viewModel.loadMorePlanets()
                            }
                        }
                    }
                }

                if viewModel.isLoading {
                    HStack(alignment: .center) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
            }
            .refreshable {
                Task {
                    await viewModel.refreshPlanets()
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search  planet")
            .alert(
                viewModel.errorMessage ?? "Service error",
                isPresented: Binding<Bool>(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                )
            ) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
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
