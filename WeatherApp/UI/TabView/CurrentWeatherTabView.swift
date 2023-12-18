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
            CurrentWeatherView(viewModel: viewModel.viewModelFactory.makeCurrentWeatherViewModel())
                .tabItem {
                    Image(systemName: "sun.max")
                    Text("Weather")
                }
                .tag(TabState.weather)
            
            FavoriteCitiesView(viewModel: viewModel.viewModelFactory.makeFavoriteCitiesViewModel())
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
