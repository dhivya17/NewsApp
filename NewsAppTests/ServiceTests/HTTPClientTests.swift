//
//  HTTPClientTests.swift
//  NewsAppTests
//
//  Created by d.c.venkatachalam on 07/08/22.
//

import XCTest
@testable import NewsApp

class HTTPClientTests: XCTestCase {
    let mock = HTTPClientMock()
    
    func testHTTPClientHandlesUrlRequestInvalidError() async throws {
        let result = await mock.sendRequest(endpoint: MockEndPoint.invalidUrl, responseModel: NewsFeed.self)
        let expectation = XCTestExpectation(description: "Request url invalid")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error == .invalidURL)
            XCTAssertTrue(error.customMessage == NetworkError.invalidURL.customMessage)
            expectation.fulfill()
        default:
            break
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testHTTPClientHandlesUrlRequestUnauthorisedError() async throws {
        let result = await mock.sendRequest(endpoint: MockEndPoint.unauthorised, responseModel: NewsFeed.self)
        let expectation = XCTestExpectation(description: "Request url unauthorized")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error == .unauthorized)
            XCTAssertTrue(error.customMessage == NetworkError.unauthorized.customMessage)
            expectation.fulfill()
        default:
            break
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testHTTPClientHandlesInvalidStatusCodeResponseError() async throws {
        let result = await mock.sendRequest(endpoint: MockEndPoint.badStatuscode, responseModel: NewsFeed.self)
        let expectation = XCTestExpectation(description: "InvalidStatusCodeResponseError")
        switch result {
        case .failure(let error):
            XCTAssertTrue(error == .unexpectedStatusCode)
            XCTAssertTrue(error.customMessage == NetworkError.unexpectedStatusCode.customMessage)
            expectation.fulfill()
        default:
            break
        }
        wait(for: [expectation], timeout: 3.0)
    }
}

struct HTTPClientMock : HTTPClient {
}
