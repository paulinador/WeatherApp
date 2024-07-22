//
//  DefaultAPIClient.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 09/11/2023.
//

import Foundation

class DefaultAPIClient: APIClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func perform<T>(request: T) async throws -> T.ReturnType where T : APIRequest {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.path = request.path
        urlComponents?.queryItems = request.queries
        
        guard let url = urlComponents?.url else {
            throw APIError.invalidURL
        }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, _) = try await session.data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let response = try? decoder.decode(T.ReturnType.self, from: data) else {
                print("Error: could not decode JSON data")
                throw APIError.decodingError
            }
            
            return response
            
        } catch {
            throw APIError.missingData
        }
    }
    
    private var baseUrl = "https://api.openweathermap.org"
    
}

enum APIError: Error {
    case invalidURL
    case decodingError
    case missingData
}
