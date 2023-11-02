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
    var newTaskVC: NewTaskViewController!
    
    override func setUp() {
        super.setUp()
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
    
    func setupNewTaskVC() {
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
        
        newTaskVC = sut.presentedViewController as? NewTaskViewController
    }
    
    func testAddNewTaskPresentsNewTaskVC() {
        setupNewTaskVC()
        XCTAssertNotNil(newTaskVC.addressTF)
    }
    
    func testCharesSameTaskManagerWithsNewTaskVC() {
        setupNewTaskVC()
        XCTAssertNotNil(sut.dataProvider.taskManager)
        XCTAssertTrue(newTaskVC.taskManager === sut.dataProvider.taskManager)
    }
    
    func testWhenViewAppearedtableViewReloaded() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView

        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
    }
    
    func testTappingCellSendsNotification() {
        let task = Task(title: "Foo")
        
        sut.dataProvider.taskManager?.add(task)
        
        expectation(forNotification: NSNotification.Name(rawValue: "didSelectRow notification"), object: nil) { notification -> Bool in
            guard let taskFromNotification = notification.userInfo?["task"] as? Task else {
                return false
            }
            
            return task == taskFromNotification
        }
        
        let tableView = sut.tableView
        tableView?.delegate?.tableView?(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        waitForExpectations(timeout: 5)
    }
    
    func testCellNotificationPushesVC() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = mockNavigationController
        
        sut.loadViewIfNeeded()
        let taskOne = Task(title: "Foo")
        let taskTwo = Task(title: "Bar")
        
        sut.dataProvider.taskManager?.add(taskOne)
        sut.dataProvider.taskManager?.add(taskTwo)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelectRow notification"), object: self, userInfo: ["task": taskOne])
        
        guard let detailVC = mockNavigationController.pushedViewController as? DetailViewController else {
            XCTFail()
            return
        }
         
        detailVC.loadViewIfNeeded()
        
        XCTAssertNotNil(detailVC.titleLabel)
        XCTAssertTrue(detailVC.task == taskOne)
    }
}

extension TaskListViewControllerTests {
    class MockTableView: UITableView {
        var isReloaded = false
        
        override func reloadData() {
            isReloaded = true
        }
    }
}

extension TaskListViewControllerTests {
    class MockNavigationController: UINavigationController {
        var pushedViewController: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: animated)
        }
    }
}
