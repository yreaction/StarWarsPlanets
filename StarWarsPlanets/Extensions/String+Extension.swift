//
//  Array+Extension.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 23/1/25.
//
extension String {
    func splitAndTrimValues() -> [String] {
        let result = self
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces)}
        return result
    }

    func formatAmountNumber() -> String {
        if let number = Double(self) {
            return number.formatted(.number.grouping(.automatic))
        } else {
            return self
        }
    }
}
