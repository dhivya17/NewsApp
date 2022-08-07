//
//  MockEndPoint.swift
//  NewsAppTests
//
//  Created by d.c.venkatachalam on 07/08/22.
//

import Foundation
import NewsApp

enum MockEndPoint {
    case invalidUrl
    case unauthorised
    case badStatuscode
}

extension MockEndPoint: Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "newscatcher.p.rapidapi.com"
    }
    
    var params: [String : String]? {
        switch self {
        case .invalidUrl, .unauthorised, .badStatuscode: return nil
        }
    }
    
    var path: String {
        switch self {
        case .invalidUrl:
            return "v1/search_enterprise?$"
        case .unauthorised, .badStatuscode:
            return "/v1/search_enterprise"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .invalidUrl, .unauthorised, .badStatuscode:
            return .get
        }
    }
    
    var header: [String: String]? {
        let accessToken = "59845cb570msh5fc727eb40864a9p17fa1bjsn66f1e2a33bc6"
        switch self {
        case .invalidUrl, .badStatuscode:
            return [
                "X-RapidAPI-Key": "\(accessToken)",
                "Content-Type": "application/json;charset=utf-8",
                "X-RapidAPI-Host": "newscatcher.p.rapidapi.com"
            ]
        case .unauthorised: return [:]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .invalidUrl, .unauthorised, .badStatuscode:
            return nil
        }
    }
    
}
