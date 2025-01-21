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
        VStack(alignment: .center) {
            PlanetSceneView()
                .frame(width: 150, height: 150)
                .edgesIgnoringSafeArea(.all)
            PlanetPopulationView(population: viewModel.populationDescription)
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
