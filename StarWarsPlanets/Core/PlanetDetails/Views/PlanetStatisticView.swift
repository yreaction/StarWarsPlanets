//
//  PlanetStatisticView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 21/1/25.
//
import SwiftUI

struct PlanetStatisticsView: View {
    let statistics: PlanetDetailViewModel.PlanetStatistics
    var body: some View {
        HStack(spacing: 8) {
            PlanetStatsView(value: statistics.diameter, title: "Diameter")
            PlanetStatsView(value: statistics.gravity, title: "Gravity")
        }
        
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 5)

    }
}

struct PlanetStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        return PlanetStatisticsView(statistics: .init(terrain: ["Desert", "Ocean"], climate: ["Arid","Rain"], diameter: "10000", gravity: "9"))
    }
}
