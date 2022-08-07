//
//  NewsFeedViewModelTests.swift
//  NewsAppTests
//
//  Created by d.c.venkatachalam on 07/08/22.
//

import XCTest
@testable import NewsApp

class NewsFeedViewModelTests: XCTestCase {
    let viewmodel = NewsFeedViewModel()
    
    
    func testFetchApiSuccessResponse() {
        let expectation = XCTestExpectation(description: "Vm return success")
        viewmodel.networkManager = NewsDataServiceMock()
        viewmodel.fetchNewsApi()
        
        viewmodel.newsFeed = { feeds in
            XCTAssertNotNil(feeds)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testFetchApiFailureResponse() {
        let expectation = XCTestExpectation(description: "Vm return failure")
        viewmodel.networkManager = NewsDataServiceFailureMock()
        viewmodel.fetchNewsApi()
        
        viewmodel.showActivityIndicator = { _ in
            expectation.fulfill()
        }
        
        viewmodel.newsFeed = { _ in
           XCTFail()
        }
        wait(for: [expectation], timeout: 3.0)
    }
}

final class NewsDataServiceFailureMock: Mockable, NewsDataServiceProtocol {
    func getNewsFeed(page: Int) async -> Result<NewsFeed, NetworkError> {
        return .failure(.decodingError)
    }
}
