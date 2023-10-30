//
//  NewTaskViewControllerTests.swift
//  ToDoTests
//
//  Created by Goodwasp on 25.10.2023.
//

import XCTest
import CoreLocation
@testable import ToDo

final class NewTaskViewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasTitleTextField() {
        XCTAssertTrue(sut.titleTF.isDescendant(of: sut.view))
    }
    
    func testHasLocationTextField() {
        XCTAssertTrue(sut.locationTF.isDescendant(of: sut.view))
    }
    
    func testHasDateTextField() {
        XCTAssertTrue(sut.dateTF.isDescendant(of: sut.view))
    }
    
    func testHasAddressTextField() {
        XCTAssertTrue(sut.addressTF.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionTextField() {
        XCTAssertTrue(sut.descriptionTF.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasCancelButton() {
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
    
    func testSaveButtonHasSaveMethod() {
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    func testGeocoderFetchesCorrectCoordinate() {
        let geocoderAnswer = expectation(description: "Geocoder answer")
        
        let addressString = "Уфа"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { placemarks, error in
            let placemark = placemarks?.first
            let location = placemark?.location
            guard
                let latitude = location?.coordinate.latitude,
                let longitude = location?.coordinate.longitude else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(latitude, 54.7373019)
            XCTAssertEqual(longitude, 55.9722162)
            geocoderAnswer.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testSaveDismissesNewTaskVC() {
        let mockNewTaskVC = MockNewTaskViewController()
        mockNewTaskVC.titleTF = UITextField()
        mockNewTaskVC.titleTF.text = "Foo"
        mockNewTaskVC.locationTF = UITextField()
        mockNewTaskVC.locationTF.text = "Bar"
        mockNewTaskVC.dateTF = UITextField()
        mockNewTaskVC.dateTF.text = "Tuesday, Jan 1, 2019"
        mockNewTaskVC.descriptionTF = UITextField()
        mockNewTaskVC.descriptionTF.text = "Baz"
        mockNewTaskVC.addressTF = UITextField()
        mockNewTaskVC.addressTF.text = "Уфа"
        
        mockNewTaskVC.save()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            XCTAssertTrue(mockNewTaskVC.isDismiss)
        }
    }
}

extension NewTaskViewControllerTests {
    class MockNewTaskViewController: NewTaskViewController {
        var isDismiss = false
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDismiss = true
        }
    }
}
