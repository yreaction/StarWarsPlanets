//
//  PlanetStatView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 21/1/25.
//

import SwiftUI

struct PlanetStatsView: View {
    let value: String
    let title: String

    var body: some View {
        VStack {
            Text("\(value)")
                .font(.planetFont(size: 18))
                .foregroundStyle(.white)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
                .foregroundStyle(.white)

        }
    }
}

#Preview {
    PlanetStatsView(value: "9", title: "Gravity")
}
