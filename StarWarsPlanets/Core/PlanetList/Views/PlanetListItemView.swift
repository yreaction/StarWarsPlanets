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
                        .font(.planetFont(size: 30))
                        .foregroundColor(.primary)
                    Spacer()
                    PlanetStatsView(value: viewModel.population, title: "Population")
                        .padding(8)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }.padding(5)
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
