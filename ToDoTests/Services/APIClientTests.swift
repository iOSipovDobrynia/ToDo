//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by Goodwasp on 26.10.2023.
//

import XCTest
@testable import ToDo

final class APIClientTests: XCTestCase {
    
    var mockURLSession: MockURLSession!
    var sut: APIClient!

    override func setUpWithError() throws {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        sut = APIClient()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        mockURLSession = nil
        sut = nil
    }

    func userLogin() {
        let completionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "name", password: "%qwerty", completionHandler: completionHandler)
    }
    
    func testLoginUsesCorrectHost() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.host, "todoapp.com")
    }
    
    func testLoginUsesCorrectPath() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }
    
    func testLoginUsesExpectedQueryParameters() {
        userLogin()
        
        guard let queryItems = mockURLSession.urlComponents?.queryItems else {
            XCTFail()
            return
        }
        
        let urlqueryItemName = URLQueryItem(name: "name", value: "name")
        let urlqueryItemPassword = URLQueryItem(name: "password", value: "%qwerty")
        
        XCTAssertTrue(queryItems.contains(urlqueryItemName))
        XCTAssertTrue(queryItems.contains(urlqueryItemPassword))
    }
    
    func testSuccessfulLoginCreatesToken() {
        let jsonDataStub = "{\"token\": \"tokenString\"}".data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        
        var caughtToken: String?
        let tokenExpectation = expectation(description: "Token")
        sut.login(withName: "login", password: "password") { token, _ in
            caughtToken = token
            
            XCTAssertEqual(caughtToken, "tokenString")
            tokenExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }

}

extension APIClientTests {

    class MockURLSession: URLSessionProtocol {
        var url: URL?
        private let mockDataTask: MockURLSessionDataTask
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            mockDataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, responseError: responseError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            mockDataTask.completionHandler = completionHandler
            return mockDataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(
                    self.data,
                    self.urlResponse,
                    self.responseError
                )
            }
        }
    }
}
