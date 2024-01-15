//
//  FavoriteRow.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 08/01/2024.
//

import SwiftUI

struct FavoriteRow: View {
    let city: String
    
    var body: some View {
        HStack {
            Text(city)
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.black)
            
            Spacer()
            
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/13d.png"))

            Text("-10ºC")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.black)
        }
    }
}

struct FavoriteRow_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRow(city: "Warszawa")
    }
}
