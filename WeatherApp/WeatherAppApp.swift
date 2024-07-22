//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 06/11/2023.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    private let viewModelFactory: ViewModelFactoryProtocol = ViewModelFactory(weatherRepository: WeatherRepository(apiClient: DefaultAPIClient()), favoriteCityRepository: FavoriteCityRepository())
    
    var body: some Scene {
        WindowGroup {
            CurrentWeatherTabView(viewModel: CurrentWeatherTabViewModel(viewModelFactory: viewModelFactory))
        }
    }
}
