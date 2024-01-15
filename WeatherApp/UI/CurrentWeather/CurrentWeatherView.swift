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
        NavigationView {
            ZStack {
                RadialGradient(stops:[
                    .init(color: Color(red: 0 / 255, green: 53 / 255, blue: 102 / 255), location: 0.2),
                    .init(color: Color(red: 0 / 255, green: 29 / 255, blue: 61 / 255), location: 0.2)], center: .top, startRadius: 150, endRadius: 800)
                .ignoresSafeArea()
                
                Spacer()
                
                VStack {
                    Text(viewModel.name)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text("\(Date().formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    VStack {
                        HStack(alignment: .center) {
                            VStack {
                                ForEach(viewModel.weather, id: \.self) { pictureCollection in
                                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(pictureCollection.icon).png")) { image in
                                        image
                                            .frame(width: 70, height: 70)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(50)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                
                                ForEach(viewModel.weather, id: \.self) { weather in
                                    Text(weather.description)
                                        .font(.caption)
                                        .fontWeight(.ultraLight)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.horizontal)
                            
                            VStack {
                                Text((viewModel.temp.roundDouble()) + "ºC")
                                    .font(.title2)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                    .padding(.top, 5)
                                
                                Text("Feels like: " + (viewModel.feelsLike.roundDouble()) + "ºC")
                                    .font(.caption)
                                    .fontWeight(.ultraLight)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.vertical, 20)
                        
                        VStack(alignment: .leading, spacing: 25) {
                            HStack {
                                WeatherRow(image: "thermometer", name: "Min temp", value: (viewModel.tempMin.roundDouble()) + "ºC")
                                
                                Spacer()
                                
                                WeatherRow(image: "thermometer", name: "Max temp", value: (viewModel.tempMax.roundDouble()) + "ºC")
                            }
                            
                            HStack {
                                WeatherRow(image: "wind", name: "Wind", value: (viewModel.wind.roundDouble()) + " m/s")
                                
                                Spacer()
                                
                                WeatherRow(image: "line.3.horizontal", name: "Humidity", value: "\(viewModel.humidity)%")
                            }
                        }
                        
                       
                        Button {
                            viewModel.addFavorites()
                        } label: {
                            if viewModel.isFavorite() {
                                Image(systemName: "heart.fill")
                            } else {
                                Image(systemName: "heart")
                            }
                        }
                        .buttonStyle(.bordered)
                        .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    Spacer()
                }
            }
            .preferredColorScheme(.light)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SearchView(viewModel: SearchViewModel())
                } label: {
                    Image(systemName: "magnifyingglass.circle")
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
