//
//  SearchView.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 18/12/2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    @State var searchQuery = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                       
                    } label: {
                        Text(name)
                    }
                }
            }
        }
        .searchable(text: $searchQuery)
    }
    
    var searchResults: [String] {
        if searchQuery.isEmpty {
            return viewModel.filteredCities
        } else {
            return viewModel.filteredCities.filter {$0.contains(searchQuery)}
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
