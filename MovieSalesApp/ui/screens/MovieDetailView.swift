//
//  MovieDetailView.swift
//  MovieSalesApp
//
//  Created by Omer on 21.09.2025.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    private let imageBaseUrl = "http://kasimadalan.pe.hu/movies/images/"
    @State private var orderAmount: Int = 1
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                ZStack(alignment: .topTrailing){
                    AsyncImage(url: URL(string: "\(imageBaseUrl)\(movie.image!)")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 300)
                    }
                    
                    Button {
                        favoritesViewModel.toggleFavorite(movie: movie)
                    } label: {
                        Image(systemName: favoritesViewModel.isFavorite(movie: movie) ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(AppColors.detail)
                            .padding(8)
                            .background(.thinMaterial)
                            .clipShape(Circle())
                    }
                    .padding(8)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    // Film Adı
                    Text(movie.name!)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Kategori, Yıl ve Puan
                    HStack {
                        Text(movie.category!)
                            .font(.headline)
                        Spacer()
                        Label(String(format: "%.1f", movie.rating!), systemImage: "star.fill")
                            .foregroundColor(.yellow)
                        Text("(\(movie.year!.formatted(.number.grouping(.never))))")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(AppColors.text))
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    // Yönetmen
                    Text("Yönetmen: \(movie.director!)")
                        .font(.body)
                    
                    
                    
                    
                    HStack {
                        Text("Adet:")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button {
                            
                            if orderAmount > 1 {
                                orderAmount -= 1
                            }
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .font(.title)
                        }
                        
                        Text("\(orderAmount)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        Button {
                            orderAmount += 1
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                        }
                    }
                    .tint(Color(AppColors.main))
                    
                    
                    HStack {
                        Text("\((movie.price!) * orderAmount) TL")
                            .font(.title)
                            .fontWeight(.heavy)
                        
                        Spacer()
                        
                        Button {
                            
                            Task{
                                await cartViewModel.addMovieToCart(movie: movie, amount: orderAmount)
                            }
                        } label: {
                            Label("Sepete Ekle", systemImage: "cart.badge.plus")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(AppColors.main))
                                .cornerRadius(12)
                        }
                    }
                    
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(movie.name!)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationStack{
        MovieDetailView(movie: .example)
            .environmentObject(CartViewModel())
            .environmentObject(FavoritesViewModel())
    }
}
