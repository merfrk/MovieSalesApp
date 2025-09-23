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
    
    
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(AppColors.background)
                    .ignoresSafeArea()
                
                VStack(spacing: 0){
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(homeViewModel.allCategories, id: \.self) { category in
                                Button {
                                    
                                    homeViewModel.selectedCategory = category
                                } label: {
                                    Text(category)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                    
                                        .background(homeViewModel.selectedCategory == category ? Color(AppColors.main) : Color.gray.opacity(0.2))
                                        .foregroundColor(homeViewModel.selectedCategory == category ? .white : Color(AppColors.text))
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(homeViewModel.filteredAndSortedMovies) { movie in
                                
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
                    .searchable(text: $homeViewModel.searchText, prompt: "Film adı ara")
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
    }
}



#Preview {
    HomeScreen()
        .environmentObject(FavoritesViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(HomeViewModel())
        .environmentObject(FavoritesViewModel())
}
