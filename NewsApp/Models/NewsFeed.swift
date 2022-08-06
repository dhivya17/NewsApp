//
//  NewsFeed.swift
//  NewsApp
//
//  Created by d.c.venkatachalam on 05/08/22.
//

import Foundation

struct NewsFeed: Codable {
    let page: Int
    let totalPages: Int
    let pageSize: Int
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case page
        case articles
        case totalPages = "total_pages"
        case pageSize = "page_size"
    }
}
