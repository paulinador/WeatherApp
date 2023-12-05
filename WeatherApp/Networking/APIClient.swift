//
//  APIClient.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 09/11/2023.
//

import Foundation

protocol APIClient {
    func perform<T: APIRequest> (request: T) async throws -> T.ReturnType
}
