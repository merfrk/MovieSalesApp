//
//  FavoritesScreen.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import SwiftUI

struct FavoritesScreen: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    private var favoriteMovies: [Movie]{
        homeViewModel.movies.filter{ movie in
            favoritesViewModel.isFavorite(movie: movie)
        }
    }
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(AppColors.background)
                    .ignoresSafeArea()
                
                ScrollView{
                    VStack{
                        if favoriteMovies.isEmpty{
                            VStack {
                                Spacer()
                                Image(systemName: "heart.slash")
                                    .font(.largeTitle)
                                    .foregroundColor(.secondary)
                                Text("Henüz favori filminiz yok.")
                                    .bodyFont()
                                    .padding(.top)
                                Spacer()
                            }
                            .frame(height: 500)
                        } else{
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(favoriteMovies) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        MovieCardView(movie: movie)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 40)
                }
                .padding(.top, 16)
                
            }
            .navigationTitle("Favoriler")
        }
    }
}

#Preview {
    FavoritesScreen()
        .environmentObject(FavoritesViewModel())
        .environmentObject(HomeViewModel())
}
