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
    
    private var filteredAndSortedMovies: [Movie] {
            var filtered: [Movie]
            
            // Önce kategoriye göre filtrele
            if selectedCategory == "Tümü" {
                filtered = homeViewModel.movies
            } else {
                filtered = homeViewModel.movies.filter { $0.category == selectedCategory }
            }
            
            // Sonra arama metnine göre filtrele
            if !searchText.isEmpty {
                filtered = filtered.filter { movie in
                    movie.name?.localizedCaseInsensitiveContains(searchText) ?? false
                }
            }
            
            // En son, seçili seçeneğe göre sırala
            switch homeViewModel.selectedSortOption {
            case .name:
                filtered.sort { $0.name ?? "" < $1.name ?? "" }
            case .priceAsc:
                filtered.sort { $0.price ?? 0 < $1.price ?? 0 }
            case .priceDesc:
                filtered.sort { $0.price ?? 0 > $1.price ?? 0 }
            case .ratingDesc:
                filtered.sort { $0.rating ?? 0 > $1.rating ?? 0 }
            }
            
            return filtered
        }
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(homeViewModel.allCategories, id: \.self) { category in
                                    Button {
                                        
                                        selectedCategory = category
                                    } label: {
                                        Text(category)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                            
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
                    ForEach(filteredAndSortedMovies) { movie in
                        
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
                await homeViewModel.loadMovies()
            }
            .searchable(text: $searchText, prompt: "Film adı ara")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Menu{
                        Picker("Sırala", selection: $homeViewModel.selectedSortOption){
                            ForEach(SortOption.allCases){ option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
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
