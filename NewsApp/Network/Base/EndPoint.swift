//
//  EndPoint.swift
//  NewsApp
//
//  Created by d.c.venkatachalam on 05/08/22.
//

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var params: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "newscatcher.p.rapidapi.com"
    }
}
