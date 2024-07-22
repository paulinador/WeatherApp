//
//  CurrentWeatherTabViewModel.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 05/12/2023.
//

import Foundation

enum TabState: Int, CaseIterable {
    case weather, favorite
}

final class CurrentWeatherTabViewModel: ObservableObject {
    let viewModelFactory: ViewModelFactoryProtocol
    
    init(viewModelFactory: ViewModelFactoryProtocol) {
        self.viewModelFactory = viewModelFactory
    }
    
    @Published var selectedTab: TabState = .weather
}
