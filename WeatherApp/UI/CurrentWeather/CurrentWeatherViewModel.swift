//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 09/11/2023.
//

import Foundation

class CurrentWeatherViewModel: ObservableObject {

    enum State {
        case loading
        case success
        case error
    }
    
    @Published var name = " "
    @Published var longitude = 0.0
    @Published var latitude = 0.0
    @Published var temp = 0.0
    @Published var feelsLike = 0.0
    @Published var tempMin = 0.0
    @Published var tempMax = 0.0
    @Published var wind = 0.0
    @Published var humidity = 0
    @Published var weather: [WeatherResponse] = []
    
    @Published var state: State = .loading
    
    private let localDownloader: WeatherRepositoryProtocol
    private let favoriteCityRepository: FavoriteCityRepositoryProtocol
    let cityName: String = "Warszawa"
    
    init(downloader: WeatherRepositoryProtocol, favoriteCityRepository: FavoriteCityRepositoryProtocol) {
        self.favoriteCityRepository = favoriteCityRepository
        self.localDownloader = downloader
       
    }
    
    @MainActor
    func fetchData() async {
        do {
            let result = try await localDownloader.getCurrentWeather()
            self.name = result.name
            self.temp = result.main.temp
            self.feelsLike = result.main.feelsLike
            self.wind = result.wind.speed
            self.humidity = result.main.humidity
            self.weather = result.weather
            self.tempMin = result.main.tempMin
            self.tempMax = result.main.tempMax
            
            state = .success
        } catch {
            state = .error
        }
        
    }
    
    func addFavorites() {
        favoriteCityRepository.addFavoriteCity(cityName: cityName)

    }

    func isFavorite() -> Bool {
        favoriteCityRepository.isCityFavorite(cityName: cityName)
    }
    
}

