//
//  Location.swift
//  ToDo
//
//  Created by Goodwasp on 17.10.2023.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinates: CLLocationCoordinate2D?
    
    init(name: String, coordinates: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinates = coordinates
    }
}

// MARK: - Equatable
extension Location: Equatable {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        guard lhs.coordinates?.latitude == rhs.coordinates?.latitude && lhs.coordinates?.longitude == lhs.coordinates?.longitude && lhs.name == rhs.name else {return false}
        return true
    }
}
