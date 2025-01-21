//
//  PlanetStatisticView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 21/1/25.
//
import SwiftUI

struct PlanetStatisticsPlanetView: View {
    let statistics: PlanetDetailViewModel.PlanetStatistics
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 5) {
                VStack(alignment: .leading) {
                    Text("Climate")
                        .font(.title3)
                        ForEach(statistics.climate, id: \.self) { climate in
                            Text(climate)
                                .font(.body)
                    }
                }
                .padding()

                Divider()

                VStack(alignment: .trailing) {
                    Text("Terrain")
                        .font(.title3)
                    ForEach(statistics.terrain, id: \.self) { terrain in
                        Text(terrain)
                            .font(.body)
                    }
                }
                .padding()
            }
            VStack(alignment: .leading) {
                Text("Diameter: \(statistics.diameter)")
                    .font(.title3)
                Text("Gravity: \(statistics.gravity)")
                    .font(.title3)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct PlanetStatisticsPlanetView_Previews: PreviewProvider {
    static var previews: some View {
        return PlanetStatisticsPlanetView(statistics: .init(terrain: ["Desert", "Ocean"], climate: ["Arid","Rain"], diameter: "10000", gravity: "9"))
    }
}
