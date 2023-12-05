//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 09/11/2023.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func getCurrentWeather() async throws -> CurrentWeatherResponse
}

class WeatherRepository: WeatherRepositoryProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getCurrentWeather() async throws -> CurrentWeatherResponse {
        do {
            let currentWeather = try await apiClient.perform(request: CurrentWeatherRequest())
            return currentWeather
        } catch {
            throw error
        }
    }
}
