//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 09/11/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol APIRequest {
    associatedtype ReturnType: Codable
    var path: String { get }
    var queries: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
}

extension APIRequest {
    var method: HTTPMethod {
        .get
    }
}

