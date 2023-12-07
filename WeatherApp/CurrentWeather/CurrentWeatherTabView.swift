//
//  ContentView.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 06/11/2023.
//

import SwiftUI

struct CurrentWeatherTabView: View {
    @StateObject var viewModel: CurrentWeatherTabViewModel
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            CurrentWeatherView(viewModel: CurrentWeatherViewModel(downloader: WeatherRepository(apiClient: DefaultAPIClient()), favoriteCityRepository: FavoriteCityRepository()))
                .tabItem {
                    Image(systemName: "sun.max")
                    Text("Weather")
                }
                .tag(TabState.weather)
            
            FavoriteCitiesView(viewModel: FavoriteCitiesViewModel(favoriteCityRepository: FavoriteCityRepository()))
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
                .tag(TabState.favorite)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentWeatherTabView()
//    }
//}
