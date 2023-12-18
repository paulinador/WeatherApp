//
//  ViewModelFactory.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 07/12/2023.
//

import Foundation

protocol ViewModelFactoryProtocol {
    func makeCurrentWeatherViewModel() -> CurrentWeatherViewModel
    func makeFavoriteCitiesViewModel() -> FavoriteCitiesViewModel
}

class ViewModelFactory: ViewModelFactoryProtocol {
    private let weatherRepository: WeatherRepositoryProtocol
    private let favoriteCityRepository: FavoriteCityRepositoryProtocol
    
    init(weatherRepository: WeatherRepositoryProtocol, favoriteCityRepository: FavoriteCityRepositoryProtocol) {
        self.weatherRepository = weatherRepository
        self.favoriteCityRepository = favoriteCityRepository
    }
    
    func makeCurrentWeatherViewModel() -> CurrentWeatherViewModel {
        CurrentWeatherViewModel(downloader: weatherRepository, favoriteCityRepository: favoriteCityRepository)
        
    }
    
    func makeFavoriteCitiesViewModel() -> FavoriteCitiesViewModel {
        FavoriteCitiesViewModel(favoriteCityRepository: favoriteCityRepository)
    }
    
}
