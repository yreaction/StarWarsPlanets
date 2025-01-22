//
//  PlanetMultipleStatsView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 22/1/25.
//
import SwiftUI

struct PlanetListStatsView: View {
    let values: [String]
    let cardColor: Color
    let title: String
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.planetFont(size: 15))
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                ForEach(values, id: \.self) { value in
                    PlanetDetailChip(value: value, color: cardColor)
                }
        }
        .padding()
        .background(.black.opacity(0.75))
        .cornerRadius(18)
        .shadow(radius: 5)
    }
}

#Preview {
    PlanetListStatsView(values: ["Desert", "Mountainous", "Extra", "more", "VaderRules"], cardColor: .yellow, title: "Terrain")
}
