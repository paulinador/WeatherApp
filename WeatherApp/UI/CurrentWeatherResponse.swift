//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 23/11/2023.
//

import Foundation

struct CurrentWeatherResponse: Codable, Hashable {
    let coord: CoordinatesResponse
    let weather: [WeatherResponse]
    let main: MainResponse
    let wind: WindResponse
    let dt: Date
    let id: Int
    let name: String
}

struct CoordinatesResponse: Codable, Hashable {
    let lon: Double
    let lat: Double
}

struct WeatherResponse: Codable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainResponse: Codable, Hashable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
}

struct WindResponse: Codable, Hashable {
    let speed: Double
}
