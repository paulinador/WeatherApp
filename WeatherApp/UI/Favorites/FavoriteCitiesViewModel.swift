//
//  FavoriteCitiesViewModel.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 05/12/2023.
//

import Foundation

struct FavoriteWeather: Identifiable, Hashable {
    var id: String {
        return name
    }
    
    let name: String
    let temp: Double
    let icon: String
    
    var iconUrl: String {
        "https://openweathermap.org/img/wn/\(icon).png"
    }
}

class FavoriteCitiesViewModel: ObservableObject {
    @Published var favoriteWeathers = [FavoriteWeather]()
    
    private let favoriteCityRepository: FavoriteCityRepositoryProtocol
    private let localDownloader: WeatherRepositoryProtocol
    
    init(favoriteCityRepository: FavoriteCityRepositoryProtocol, downloader: WeatherRepositoryProtocol) {
        self.favoriteCityRepository = favoriteCityRepository
        self.localDownloader = downloader
    }
    
    @MainActor
    func loadCities() async {
        let favoriteCities = favoriteCityRepository.getAllCities()
        var localFavoriteCities: [FavoriteWeather] = []
        
        for city in favoriteCities {
            do {
                let result = try await localDownloader.getCurrentWeather(cityName: city)
                let favoriteWeather = FavoriteWeather(name: result.name, temp: result.main.temp, icon: result.weather.first?.icon ?? "01d")
                localFavoriteCities.append(favoriteWeather)
            } catch {
                print(error)
            }
        }
        
        favoriteWeathers = localFavoriteCities
    }
    
    func removeFavoriteItem(at offsets: IndexSet) {
        let favoriteCities = favoriteCityRepository.getAllCities()
        
        offsets.forEach { index in
            let cityToDelete = favoriteCities[index]
            favoriteCityRepository.deleteCity(cityName: cityToDelete)
            favoriteWeathers.remove(atOffsets: offsets)
        }
    }
}
