//
//  NewsEndPoint.swift
//  NewsApp
//
//  Created by d.c.venkatachalam on 05/08/22.
//

import Foundation

enum NewsEndPoint {
    case topfeeds(page: Int)
}

extension NewsEndPoint: Endpoint {
    var params: [String : String]? {
        switch self {
        case .topfeeds(let page):
            return [
                "q" : "CHESS",
                "lang": "en",
                "sort_by":"relevancy",
                "page": String(page),
                "media": "True",
                "page_size": "20"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .topfeeds:
            return "/v1/search_enterprise"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .topfeeds:
            return .get
        }
    }
    
    var header: [String: String]? {
        let accessToken = "59845cb570msh5fc727eb40864a9p17fa1bjsn66f1e2a33bc6"
        switch self {
        case .topfeeds:
            return [
                "X-RapidAPI-Key": "\(accessToken)",
                "Content-Type": "application/json;charset=utf-8",
                "X-RapidAPI-Host": "newscatcher.p.rapidapi.com"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .topfeeds:
            return nil
        }
    }
    
}
