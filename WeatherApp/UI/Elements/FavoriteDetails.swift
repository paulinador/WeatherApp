//
//  FavoriteDetails.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 12/02/2024.
//

import SwiftUI

struct FavoriteDetails: View {
    let weather: FavoriteWeather
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Feels like: \(weather.feelsLike.roundDouble())ºC")
                .font(.headline)
                .foregroundStyle(.secondary)
                .padding(20)
            
            HStack {
                WeatherRow(image: "wind", name: "Wind", value: (weather.speed.roundDouble()) + " m/s", color: .gray)
                
                Spacer()
                
                WeatherRow(image: "line.3.horizontal", name: "Humidity", value: "\(weather.humidity)%", color: .gray)

            }
            .padding(.bottom, 20)
            .padding(.trailing, 20)
        }
    }
}


