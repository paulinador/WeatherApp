//
//  FavoriteRow.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 08/01/2024.
//

import SwiftUI

struct FavoriteRow: View {
    let weather: FavoriteWeather
    
    var body: some View {
        HStack {
            Text(weather.name)
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.black)
            
            Spacer()
            
            AsyncImage(url: URL(string: weather.iconUrl))
                .frame(width: 50, height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(50)

            Text("\(weather.temp.roundDouble())ºC")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.black)
        }
    }
}


