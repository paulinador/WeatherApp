//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 09/11/2023.
//

import SwiftUI

struct CurrentWeatherView: View {
    @StateObject var viewModel: CurrentWeatherViewModel
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success:
                makeSuccessStateView()
            case .error:
                makeErrorStateView()
            }
        }
        .navigationTitle("Weather Forecast")
        .task {
            await viewModel.fetchData()
        }
    }
    
    @ViewBuilder private func makeSuccessStateView() -> some View {
        VStack {
            Text(viewModel.name)
            
            ForEach(viewModel.weather, id: \.self) { weather in
                //                Text(weather.main)
                    Text(weather.description)
            }
            
            Text("Temperature: \(viewModel.temp)ºC")
            Text("Feels Like: \(viewModel.feelsLike)ºC")
            Text("Wind speed: \(viewModel.wind) km/h")
            Text("Pressure: \(viewModel.pressure) hPa")
            

            HStack {
                Button("Add to favorites") {
                    viewModel.addFavorites()
                }


                if viewModel.isFavorite() {
                    Image(systemName: "heart.fill")
                } else {
                    Image(systemName: "heart.slash")
                }
            }
        }
    }

    
    @ViewBuilder private func makeErrorStateView() -> some View {
        VStack {
            Text("ERROR")
                .font(.title)
                .padding()
            
            Button("Try again") {
                Task {
                    await viewModel.fetchData()
                }
            }
        }
    }
}
    
//struct CurrentWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentWeatherView()
//    }
//}
