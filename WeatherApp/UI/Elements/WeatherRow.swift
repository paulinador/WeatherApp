//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 07/12/2023.
//

import SwiftUI

struct WeatherRow: View {
    let image: String
    let name: String
    let value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: image)
                .font(.title2)
                .frame(width: 50, height: 50)
//                .background(Color(red: 255 / 255, green: 195 / 255, blue: 0 / 255))
                .background(Color(red: 255 / 255, green: 198 / 255, blue: 0 / 255))
                .cornerRadius(50)
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .font(.caption)
                Text(value)
                    .font(.callout).bold()
            }
            .foregroundColor(.white)
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(image: "sun.max", name: "Temp", value: "9")
    }
}
