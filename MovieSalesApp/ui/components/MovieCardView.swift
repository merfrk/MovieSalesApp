//
//  MovieCardView.swift
//  MovieSalesApp
//
//  Created by Omer on 20.09.2025.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    private let imageBaseUrl = "http://kasimadalan.pe.hu/movies/images/"
    @EnvironmentObject var cartViewModel: CartViewModel
        

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            AsyncImage(url: URL(string: "\(imageBaseUrl)\(movie.image!)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            } placeholder: {
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.3))
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .frame(maxWidth: .infinity)
            
            
            Text(movie.name!)
                .font(.headline) 
                .lineLimit(1)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", movie.rating!))
                Spacer()
                Text(movie.category!)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
            .font(.subheadline)
            
            
            HStack{
                Text("\(movie.price!) TL")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(AppColors.primary))
                Spacer()
                Button(){
                    Task{
                        await cartViewModel.addMovieToCart(movie: movie, amount: 1)
                    }
                } label:{
                    Label("", systemImage: "cart.badge.plus")
                        .tint(.black)
                }
            }
            .background(Color(.systemGray6))
            
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    MovieCardView(movie: .example)
        .environmentObject(CartViewModel())
}
