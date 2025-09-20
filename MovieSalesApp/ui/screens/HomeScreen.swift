//
//  HomeScreen.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    let columns: [GridItem] = [
            GridItem(.adaptive(minimum: 160), spacing: 16)
        ]
    
    var body: some View {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.movies) { movie in
                            
                            NavigationLink(destination: Text("Detay Sayfası: \(movie.name)")) {
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
                    await viewModel.loadMovies()
                }
            }
        }
    }

    

#Preview {
    HomeScreen()
}
