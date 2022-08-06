//
//  NetworkError.swift
//  NewsApp
//
//  Created by d.c.venkatachalam on 05/08/22.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decodingError:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
