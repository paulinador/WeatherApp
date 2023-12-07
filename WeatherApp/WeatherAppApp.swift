//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 06/11/2023.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
//            CurrentWeatherView(viewModel: CurrentWeatherViewModel(downloader: WeatherRepository(apiClient: DefaultAPIClient())))
            CurrentWeatherTabView(viewModel: CurrentWeatherTabViewModel())
        }
    }
}
