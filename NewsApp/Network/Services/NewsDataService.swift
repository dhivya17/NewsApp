//
//  NewsDataService.swift
//  NewsApp
//
//  Created by d.c.venkatachalam on 05/08/22.
//

import Foundation

protocol NewsDataServiceProtocol {
    func getNewsFeed(page: Int) async -> Result<NewsFeed, NetworkError>
}

struct NewsDataService: HTTPClient, NewsDataServiceProtocol {
    func getNewsFeed(page: Int) async -> Result<NewsFeed, NetworkError> {
        return await sendRequest(endpoint: NewsEndPoint.topfeeds(page: page), responseModel: NewsFeed.self)
    }
}
