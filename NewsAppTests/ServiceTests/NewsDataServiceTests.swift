//
//  NewsDataServiceTests.swift
//  NewsAppTests
//
//  Created by d.c.venkatachalam on 07/08/22.
//

import XCTest
@testable import NewsApp

class NewsDataServiceTests: XCTestCase {
    func testNewsDataServiceMock() async {
        let serviceMock = NewsDataServiceMock()
        let result = await serviceMock.getNewsFeed(page: 1)

        switch result {
        case .success(let feed):
            XCTAssertEqual(feed.articles.first?.title, "Just a super cute video of Elon Musk's son")
        case .failure:
            XCTFail("The request should not fail")
        }
    }
}

final class NewsDataServiceMock: Mockable, NewsDataServiceProtocol {
    func getNewsFeed(page: Int) async -> Result<NewsFeed, NetworkError> {
        return .success(loadJSON(filename: "NewsFeedResponse", type: NewsFeed.self))
    }
}
