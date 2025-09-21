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
    let columns: [GridItem] = [
            GridItem(.adaptive(minimum: 160), spacing: 16)
        ]
    
    var body: some View {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(homeViewModel.movies) { movie in
                            
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
            }
        }
    }

    

#Preview {
    HomeScreen()
        .environmentObject(FavoritesViewModel())
                .environmentObject(CartViewModel())
                .environmentObject(HomeViewModel())
}
