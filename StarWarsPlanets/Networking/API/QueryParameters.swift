//
//  QueryParameters.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 23/1/25.
//
import Foundation

enum QueryType {
    case search(String)
    func asQueryItem() -> URLQueryItem {
        switch self {
        case .search(let value):
            return URLQueryItem(name: "search", value: value)
        }
    }
}
