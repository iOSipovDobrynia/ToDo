//
//  TaskManagerTests.swift
//  ToDoTests
//
//  Created by Goodwasp on 19.10.2023.
//

import XCTest
@testable import ToDo

final class TaskManagerTests: XCTestCase {

    var sut: TaskManager!
    
    override func setUp() {
        super.setUp()
        
        sut = TaskManager()
    }

    override func tearDown() {
        sut.removeAll()
        sut = nil
        
        super.tearDown()
    }
    
    func testInitTaskManagerWithZeroTasks() {
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    func testInitTaskManagerWithZeroDoneTasks() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    func testAddTaskIncrementTaskCount() {
        let task = Task(title: "Foo")
        sut.add(task)
        
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    func testAddAtIndexIsAddedTask() {
        let task = Task(title: "Foo")
        sut.add(task)
        
        let returnedTask = sut.task(at: 0)
        
        XCTAssertEqual(task, returnedTask)
    }
    
    func testCheckTaskAtIndexChangesCount() {
        let task = Task(title: "Foo")
        sut.add(task)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTasksCount, 1)
    }
    
    func testCheckTaskRemoveFromTasks() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Baz")
        sut.add(firstTask)
        sut.add(secondTask)
        
        sut.checkTask(at: 0)
        
        let returnedTask = sut.task(at: 0)

        XCTAssertEqual(returnedTask, secondTask)
    }
    
    func testDoneTaskAtReturnsCheckedTask() {
        let task = Task(title: "Foo")
        sut.add(task)
        sut.checkTask(at: 0)
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(returnedTask, task)
    }
    
    func testRemoveAllResultShouldBeZero() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Baz")
        sut.add(firstTask)
        sut.add(secondTask)
        
        sut.checkTask(at: 0)
        
        sut.removeAll()
        
        XCTAssertTrue(sut.tasksCount == 0)
        XCTAssertTrue(sut.doneTasksCount == 0)
    }
    
    func testAddingSameTaskDoesNotIncrementCount() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Foo")
        sut.add(firstTask)
        sut.add(secondTask)
        
        XCTAssertTrue(sut.tasksCount == 1)
    }
    
    func testWhenTaskManagerRecreatedSavedTaskShouldbeEqual() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        
        sut.add(firstTask)
        sut.add(secondTask)
        
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        sut = nil
        
        sut = TaskManager()
        
        XCTAssertEqual(sut.tasksCount, 2)
        XCTAssertEqual(sut.task(at: 0), firstTask)
        XCTAssertEqual(sut.task(at: 1), secondTask)
    }
}
