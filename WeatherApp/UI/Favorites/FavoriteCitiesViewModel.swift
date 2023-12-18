//
//  FavoriteCitiesViewModel.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 05/12/2023.
//

import Foundation

class FavoriteCitiesViewModel: ObservableObject {
    @Published var favoriteCity = [String]()
    private let favoriteCityRepository: FavoriteCityRepositoryProtocol
    
    init(favoriteCityRepository: FavoriteCityRepositoryProtocol) {
        self.favoriteCityRepository = favoriteCityRepository
    }
    
    func loadCities() {
        favoriteCity = favoriteCityRepository.getAllCities()
    }
    
    func removeFavoriteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let cityToDelete = favoriteCity[index]
            favoriteCityRepository.deleteCity(cityName: cityToDelete)
            favoriteCity.remove(atOffsets: offsets)
        }
    }
}
