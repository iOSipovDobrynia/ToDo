//
//  ToDoUITests.swift
//  ToDoUITests
//
//  Created by Goodwasp on 17.10.2023.
//

import XCTest

final class ToDoUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        XCTAssertTrue(app.isOnMainView)
        
        app.navigationBars["ToDo.TaskListView"].buttons["Add"].tap()
        XCTAssertFalse(app.isOnMainView)
        
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")
        
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Bar")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("Wednesday, Jan 2, 2019")
        
        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Ufa")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Baz")

        app.buttons["save"].tap()
        
        XCTAssertTrue(app.isOnMainView)
        XCTAssertTrue(app.tables.staticTexts.element.exists)

        XCTAssertTrue(app.tables.staticTexts["Foo"].exists)
        XCTAssertTrue(app.tables.staticTexts["Bar"].exists)
        XCTAssertTrue(app.tables.staticTexts["Wednesday, Jan 2, 2019"].exists)
    }
    
    func testWhenCellIsSwipedLeftDoneButtonAppear() {
        XCTAssertTrue(app.isOnMainView)
        
        app.navigationBars["ToDo.TaskListView"].buttons["Add"].tap()
        XCTAssertFalse(app.isOnMainView)
        
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")
        
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Bar")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("Wednesday, Jan 2, 2019")
        
        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Ufa")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Baz")

        app.buttons["save"].tap()
        
        XCTAssertTrue(app.isOnMainView)
        
        XCTAssertTrue(app.tables.staticTexts.element.exists)

        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Done"].tap()
        
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "date").label, "")
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIApplication {
    var isOnMainView: Bool {
        otherElements["mainView"].exists
    }
}
