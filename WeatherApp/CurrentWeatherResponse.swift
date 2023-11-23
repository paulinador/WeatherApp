//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 23/11/2023.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    let coord: CoordinatesResponse
    let weather: [WeatherResponse]
    let main: MainResponse
    let wind: WindResponse
    let dt: Date
    let name: String
}

struct CoordinatesResponse: Codable {
    let lon: Double
    let lat: Double
}

struct WeatherResponse: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainResponse: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
}

struct WindResponse: Codable {
    let speed: Double
}
