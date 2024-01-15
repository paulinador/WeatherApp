//
//  FavoriteCitiesView.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 05/12/2023.
//

import SwiftUI

struct FavoriteCitiesView: View {
    @StateObject var viewModel: FavoriteCitiesViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    
                    ForEach(viewModel.favoriteWeathers, id: \.self) { favorite in
                        FavoriteRow(weather: favorite)
                    }
                    .onDelete(perform: viewModel.removeFavoriteItem)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Capsule()
                            .fill(Color(white: 1, opacity: 0.8))
                            .padding(.vertical, 5)
                    )
                } header: {
                    Text("Favorite Cities")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(red: 0 / 255, green: 53 / 255, blue: 102 / 255))
            .task {
                await viewModel.loadCities()
            }
        }
    }
}

//struct FavoriteCitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteCitiesView()
//    }
//}
