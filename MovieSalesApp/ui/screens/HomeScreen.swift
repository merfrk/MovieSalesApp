//
//  HomeScreen.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var searchText = ""
    let columns: [GridItem] = [
            GridItem(.adaptive(minimum: 160), spacing: 16)
        ]
    
    private var filteredMovies: [Movie] {
            if searchText.isEmpty {
                return homeViewModel.movies
            } else {
                
                return homeViewModel.movies.filter { movie in
                    movie.name?.localizedCaseInsensitiveContains(searchText) ?? false
                }
            }
        }
    
    var body: some View {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredMovies) { movie in
                            
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieCardView(movie: movie)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Filmler")
                .task {
                    // Ekran açıldığında filmleri yükle
                    await homeViewModel.loadMovies()
                }
                .searchable(text: $searchText, prompt: "Film adı ara")
            }
        }
    }

    

#Preview {
    HomeScreen()
        .environmentObject(FavoritesViewModel())
                .environmentObject(CartViewModel())
                .environmentObject(HomeViewModel())
}
