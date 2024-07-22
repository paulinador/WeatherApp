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
        .searchable(text: $viewModel.searchName)
        .onSubmit(of: .search) {
            viewModel.onSearchTap()
        }
        .navigationTitle("Weather Forecast")
    }
            
    @ViewBuilder private func makeSuccessStateView() -> some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color(red: 21 / 255, green: 101 / 255, blue: 192 / 255),
                                        Color(red: 144 / 255, green: 202 / 255, blue: 249 / 255)
                                       ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack {
//                    Another solution:
//                    TextField("Enter city name", text: $viewModel.searchName) {
//                        Task {
//                            await viewModel.searchCity()
//                        }
//                    }
//                    .font(.title)
//                    .foregroundStyle(.black)
//                    .padding()
                    
                    
                    Text(viewModel.name)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    Text("\(Date().formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                    
                    VStack {
                        Text((viewModel.temp.roundDouble()) + "ºC")
                            .font(.title2)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                        
                        Text("Feels like: " + (viewModel.feelsLike.roundDouble()) + "ºC")
                            .font(.caption)
                            .fontWeight(.ultraLight)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack {
                        HStack(alignment: .center) {
                                    ForEach(viewModel.weather, id: \.self) { pictureCollection in
                                        VStack {
                                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(pictureCollection.icon).png")) { image in
                                                image
                                                    .frame(width: 70, height: 70)
                                                    .background(.ultraThinMaterial)
                                                    .cornerRadius(50)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            
                                            Text(pictureCollection.description)
                                                .font(.caption)
                                                .fontWeight(.light)
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .padding(20)
                        
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
                        .padding(.top, 15)
                        
                       
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
                        .padding(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    Spacer()
                }
                .padding(.bottom, 50)
                
                Spacer()
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
