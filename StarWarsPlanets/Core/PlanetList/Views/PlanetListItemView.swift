//
//  PlanetListItemView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 22/1/25.
//
import SwiftUI

struct PlanetListItemView: View {
    @StateObject var viewModel: PlanetListItemViewModel

    public var body: some View {
        NavigationLink(destination: PlanetDetailView(viewModel: PlanetDetailViewModel(planet: viewModel.planet))) {
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.planetName)
                        .font(.planetFont(size: 25))
                        .foregroundColor(.primary)
                    PlanetPopulationView(population: viewModel.population)
                }
                HStack{
                    ForEach(viewModel.climate, id: \.self) { climate in
                        PlanetDetailChip(value: climate, color: .yellow)
                    }
                }
            }
            .padding(.leading, 8)
        }
    }
}

struct PlanetListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        let stubPlanet = PlanetEntity.createStub(in: previewContext)
        let viewModel = PlanetListItemViewModel(planet: stubPlanet)

        return PlanetListItemView(viewModel: viewModel)
    }
}
