//
//  FavoriteCityRepository.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 05/12/2023.
//

import Foundation

protocol FavoriteCityRepositoryProtocol {
    func addFavoriteCity(cityName: String)
    func getAllCities() -> [String]
    func deleteCity(cityName: String)
    func isCityFavorite(cityName: String) -> Bool
}

class FavoriteCityRepository: FavoriteCityRepositoryProtocol {
    private let userDefaults: UserDefaults
    private var allCities: Set<CurrentWeatherResponse> = []
    private let key = "Favorite"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func addFavoriteCity(cityName: String) {
        var citiesSet = Set(getAllCities())
        citiesSet.insert(cityName)
        
        if let encoded = try? JSONEncoder().encode(citiesSet) {
            userDefaults.set(encoded, forKey: key)
        }
    }
    
    func getAllCities() -> [String] {
        if let data = userDefaults.data(forKey: key), let cities = try? JSONDecoder().decode([String].self, from: data) {
            return cities
        } else {
            return []
        }
    }
    
    func deleteCity(cityName: String) {
        var citiesSet = Set(getAllCities())
        citiesSet.remove(cityName)
        
        if let encoded = try? JSONEncoder().encode(citiesSet) {
            userDefaults.set(encoded, forKey: key)
            
        }
    }
    
    func isCityFavorite(cityName: String) -> Bool {
        return getAllCities().contains(cityName)
    }
    
    
}

