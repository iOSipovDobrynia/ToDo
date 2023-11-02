//
//  TaskTests.swift
//  ToDoTests
//
//  Created by Goodwasp on 17.10.2023.
//

import XCTest
@testable import ToDo

final class TaskTests: XCTestCase {

    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task)
    }

    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertEqual(task.description, "Bar")
    }
    
    func testTaskInitWithDate() {
        let task = Task(title: "Baz")
        
        XCTAssertNotNil(task.date)
    }
    
    func testTaskInitWithIsDoneEqualsFalse() {
        let task = Task(title: "Foo")
        
        XCTAssertEqual(task.isDone, false)
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        
        let task = Task(
            title: "Bar", 
            description: "Baz",
            location: location
        )
        
        XCTAssertEqual(location, task.location)
    }
    
    func testCanBeCreatedFromPlistDict() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Bar", description: "Foo", date: date, location: location)
        
        let locationDict: [String: Any] = ["name": "Baz"]
        let dict: [String: Any] = [
            "title" : "Bar",
            "description" : "Foo",
            "date" : date,
            "location" : locationDict
        ]
        
        let createdTask = Task(dict: dict)
        
        XCTAssertEqual(task, createdTask)
    }
    
    func testCanBeSerializedIntoDict() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Bar", description: "Foo", date: date, location: location)

        let generatedTask = Task(dict: task.dict)
        
        XCTAssertEqual(task, generatedTask)
    }
}
