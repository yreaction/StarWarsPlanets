//
//  PlanetDetailChip.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 22/1/25.
//

import SwiftUI

struct PlanetDetailChip : View {
    let value: String
    let color: Color
    var body: some View {
        Text(value)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(4)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(color)

            }
    }
}

#Preview {
    PlanetDetailChip(value: "9", color: .yellow)
}
