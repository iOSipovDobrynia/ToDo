//
//  LocationTests.swift
//  ToDoTests
//
//  Created by Goodwasp on 17.10.2023.
//

import XCTest
import CoreLocation
@testable import ToDo

final class LocationTests: XCTestCase {
    func testInitSetsCoordinates() {
        let coordinates = CLLocation(latitude: 1, longitude: 2)
        
        let location = Location(name: "Foo", coordinates: coordinates.coordinate)
        
        XCTAssertEqual(coordinates.coordinate.longitude, location.coordinates?.longitude)
        XCTAssertEqual(coordinates.coordinate.latitude, location.coordinates?.latitude)
    }
    
    func testInitSetsName() {
        let location = Location(name: "Foo")
        
        XCTAssertEqual(location.name, "Foo")
    }
}
