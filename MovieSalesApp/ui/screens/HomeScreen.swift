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
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    @State private var searchText = ""
    @State private var selectedCategory = "Tümü"

    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    private var filteredMovies: [Movie] {
            var categoryFiltered: [Movie]
            
            
            if selectedCategory == "Tümü" {
                categoryFiltered = homeViewModel.movies
            } else {
                categoryFiltered = homeViewModel.movies.filter { $0.category == selectedCategory }
            }
            
            
            if searchText.isEmpty {
                return categoryFiltered
            } else {
                return categoryFiltered.filter { movie in
                    movie.name?.localizedCaseInsensitiveContains(searchText) ?? false
                }
            }
        }
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(homeViewModel.allCategories, id: \.self) { category in
                                    Button {
                                        // Tıklandığında seçili kategoriyi güncelle
                                        selectedCategory = category
                                    } label: {
                                        Text(category)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                            // Seçili olan kategori farklı görünsün
                                            .background(selectedCategory == category ? Color(AppColors.main) : Color.gray.opacity(0.2))
                                            .foregroundColor(selectedCategory == category ? .white : Color(AppColors.text))
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
            .padding(.top, 8)
            
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
        .environmentObject(FavoritesViewModel())
}
