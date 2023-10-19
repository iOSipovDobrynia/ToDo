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
    let coordinates: CLLocation?
    
    init(name: String, coordinates: CLLocation? = nil) {
        self.name = name
        self.coordinates = coordinates
    }
}

extension Location: Equatable {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        guard lhs.coordinates?.coordinate.latitude == rhs.coordinates?.coordinate.latitude && lhs.coordinates?.coordinate.longitude == lhs.coordinates?.coordinate.longitude && lhs.name == rhs.name else {return false}
        return true
    }
}
