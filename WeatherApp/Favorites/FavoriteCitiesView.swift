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
            ForEach(viewModel.favoriteCity, id: \.self) { favorite in
                HStack {
                    Text(favorite)
                }
            }
            .onDelete(perform: viewModel.removeFavoriteItem)
        }
        .onAppear {
            viewModel.loadCities()
        }
    }
}

//struct FavoriteCitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteCitiesView()
//    }
//}
