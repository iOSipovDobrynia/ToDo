//
//  TaskListViewControllerTests.swift
//  ToDoTests
//
//  Created by Goodwasp on 19.10.2023.
//

import XCTest
@testable import ToDo

final class TaskListViewControllerTests: XCTestCase {

    var sut: TaskListViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        sut = vc as? TaskListViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        
    }

    func testTableViewNotNilWhenViewIsLoaded() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testDataProviderIsNotNilWhenViewIsLoaded() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceEqualsTableViewDelegate() {
        XCTAssertEqual(sut.tableView.dataSource as? DataProvider, sut.tableView.delegate as? DataProvider)
    }
    
    func testTaskListVCHasAddBarButtonWithSelfAstarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListViewController, sut)
    }
    
    func testAddNewTaskPresentsNewTaskVC() {
        XCTAssertNil(sut.presentedViewController)
        
        guard
            let addButton = sut.navigationItem.rightBarButtonItem,
            let action = addButton.action else {
            XCTFail()
            return
        }
        
//        UIApplication.shared.keyWindow?.rootViewController = sut
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut
        
        sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
        
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is NewTaskViewController)
        
        let newTaskVC = sut.presentedViewController as! NewTaskViewController
        XCTAssertNotNil(newTaskVC.addressTF)
    }
}
