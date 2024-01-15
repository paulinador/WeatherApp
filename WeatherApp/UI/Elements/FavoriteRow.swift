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

            Text("\(weather.temp)")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.black)
        }
    }
}


