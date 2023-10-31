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
    
    var dict: [String: Any] {
        var dict: [String: Any] = [:]
        dict["name"] = name
        if let coordinates = coordinates {
            dict["latitude"] = coordinates.latitude
            dict["longitude"] = coordinates.longitude
        }
        return dict
    }
    
    init(name: String, coordinates: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinates = coordinates
    }
    
    init?(dict: [String: Any]) {
        name = dict["name"] as! String
        
        if 
            let latitude = dict["latitude"] as? Double,
            let longitude = dict["longitude"] as? Double {
            coordinates = CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            )
        } else {
            coordinates = nil
        }
    }
}

// MARK: - Equatable
extension Location: Equatable {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        guard lhs.coordinates?.latitude == rhs.coordinates?.latitude && lhs.coordinates?.longitude == lhs.coordinates?.longitude && lhs.name == rhs.name else {return false}
        return true
    }
}
