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
    
    @Published var searchName = ""
    
    private let localDownloader: WeatherRepositoryProtocol
    private let favoriteCityRepository: FavoriteCityRepositoryProtocol
    
    init(downloader: WeatherRepositoryProtocol, favoriteCityRepository: FavoriteCityRepositoryProtocol) {
        self.favoriteCityRepository = favoriteCityRepository
        self.localDownloader = downloader
       
        Task {
            await fetchData()
        }
    }
    
    @MainActor
    func fetchData(cityName: String = "Krakow") async {
        
        do {
            let result = try await localDownloader.getCurrentWeather(cityName: cityName)
            name = result.name
            temp = result.main.temp
            feelsLike = result.main.feelsLike
            wind = result.wind.speed
            humidity = result.main.humidity
            weather = result.weather
            tempMin = result.main.tempMin
            tempMax = result.main.tempMax
            
            state = .success
        } catch {
            state = .error
        }
        
    }
    
    func addFavorites() {
        favoriteCityRepository.addFavoriteCity(cityName: name)

    }

    func isFavorite() -> Bool {
        favoriteCityRepository.isCityFavorite(cityName: name)
    }
    
    func onSearchTap() {
        Task {
            await fetchData(cityName: searchName)
        }
    }
}

