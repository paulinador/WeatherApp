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
        List {
            Section {
                ForEach(viewModel.favoriteWeathers, id: \.self) { favorite in
                    makeItem(item: favorite)
                        .listRowBackground(Color(white: 0, opacity: 0.2))
                }
                .onDelete(perform: viewModel.removeFavoriteItem)
                .listRowSeparator(.hidden)
            } header: {
                makeHeader()
            }
        }

        .scrollContentBackground(.hidden)
        .background(Color(red: 0 / 255, green: 53 / 255, blue: 102 / 255))
        .task {
            await viewModel.loadCities()
        }
    }
    
    @ViewBuilder private func makeHeader() -> some View {
        Text("Favorite Cities")
            .font(.title)
            .fontWeight(.light)
            .foregroundColor(.white)
            .padding(.vertical, 5)
    }
    
    @ViewBuilder private func makeItem(item: FavoriteWeather) -> some View {
        ItemRowView(item: item)
    }
}

struct ItemRowView: View {
    @State private var isWeatherExpanded: Bool = false
    let item: FavoriteWeather
    
    var body: some View {
        VStack(spacing: 0) {
            FavoriteRow(weather: item)
            if isWeatherExpanded {
                FavoriteDetails(weather: item)
                    .transition(.opacity)
                    .padding()
            }
        }
        .background(RoundedRectangle(cornerRadius: 16)
            .fill(Color(white: 1, opacity: 1.0)))
        .animation(.linear(duration: 0.2))
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isWeatherExpanded.toggle()
            }
        }
    }
}
