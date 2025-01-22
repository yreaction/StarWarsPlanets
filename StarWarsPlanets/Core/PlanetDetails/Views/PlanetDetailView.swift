//
//  PlanetDetailView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 20/1/25.
//
import SwiftUI
struct PlanetDetailView: View {
    @StateObject var viewModel: PlanetDetailViewModel
    var body: some View {
        ScrollView {
            PlanetPopulationView(population: viewModel.populationDescription)
            .padding()
            VStack {
                ZStack(alignment: .center) {
                    PlanetSceneView()
                        .frame(width: 420, height: 420)
                        .edgesIgnoringSafeArea(.all)
                    PlanetStatisticsView(statistics: viewModel.statistics)
                }
                HStack(alignment: .top) {
                    PlanetListStatsView(values: viewModel.statistics.climate,
                                        cardColor: .yellow,
                                        title: "Climate")
                    PlanetListStatsView(values: viewModel.statistics.terrain,
                                        cardColor: .brown,
                                        title: "Terrain")
                }
            }
        }.navigationBarTitle(viewModel.title)
    }
}

struct PlanetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        let stubPlanet = PlanetEntity.createStub(in: previewContext)
        let viewModel = PlanetDetailViewModel(planet: stubPlanet)

        return PlanetDetailView(viewModel: viewModel)
    }
}
