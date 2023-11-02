//
//  ToDoTests.swift
//  ToDoTests
//
//  Created by Goodwasp on 17.10.2023.
//

import XCTest
@testable import ToDo

final class ToDoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialViewControllerIsTaskListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationVC = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootVC = navigationVC.viewControllers.first as! TaskListViewController
        
        XCTAssertTrue(rootVC is TaskListViewController)
    }
}
