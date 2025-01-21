//
//  PlanetPopulationView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 21/1/25.
//
import SwiftUI

struct PlanetPopulationView: View {
    let population: String
    var body: some View {
        HStack {
            Image(systemName: "person.3.fill")
                .foregroundStyle(.white)
            Text(population)
                .font(.title)
                .foregroundStyle(.white)
                .background(.black)
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .stroke(.black, lineWidth: 2)
        }
    }
}
