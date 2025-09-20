//
//  MovieCardView.swift
//  MovieSalesApp
//
//  Created by Omer on 20.09.2025.
//

// MovieCardView.swift
import SwiftUI

struct MovieCardView: View {
    let movie: Movie // Bu View'a bir film nesnesi vereceğiz
    private let imageBaseUrl = "http://kasimadalan.pe.hu/movies/images/"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Film Afişi
            AsyncImage(url: URL(string: "\(imageBaseUrl)\(movie.image!)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            } placeholder: {
                // Resim yüklenirken görünecek olan alan
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.3))
                    .aspectRatio(2/3, contentMode: .fit) // Afiş oranını koru
            }
            .frame(maxWidth: .infinity)
            
            // Film Adı
            Text(movie.name!)
                .font(.headline) // Daha belirgin bir font
                .lineLimit(1) // İsim uzunsa tek satırda kalsın
            
            // Puan ve Kategori
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
            
            // Fiyat
            Text("\(movie.price!) TL")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(AppColors.primary)) // Kendi renklerinizden biri
            
        }
        .padding(12)
        .background(Color(.systemBackground)) // Açık/Koyu moda uyumlu arka plan
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    MovieCardView(movie: .example)
}
