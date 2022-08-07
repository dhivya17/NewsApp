//
//  NewsFeedTableViewCellTests.swift
//  NewsAppTests
//
//  Created by d.c.venkatachalam on 07/08/22.
//

import XCTest
@testable import NewsApp

class NewsFeedTableViewCellTests: XCTestCase {
    func testClassCanBeConsumedAsExpected() {
        let testObject = NewsTableViewCell()
        
        let testData = Article(summary: "summary", title: "title", media: "link")
        testObject.updateCell(data: testData)
        
        XCTAssertEqual(testObject.titleLabel.text, testData.title, "titleLabel text should be settable by the consuming class")
        XCTAssertEqual(testObject.descriptionLabel.text, testData.summary, "titleLabel text should be settable by the consuming class")
    }
}
