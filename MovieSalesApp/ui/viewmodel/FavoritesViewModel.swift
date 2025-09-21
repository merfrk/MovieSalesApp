//
//  FavoritesViewModel.swift
//  MovieSalesApp
//
//  Created by Omer on 21.09.2025.
//

import Foundation
import SwiftUI

@MainActor
class FavoritesViewModel: ObservableObject{
    @Published private var favoriteMovieIds: Set<Int> = []
    private let userDefaultsKey = "favoriteMoviesKey"
    
    init(){
        loadFavorites()
    }
    
    func isFavorite(movie: Movie) -> Bool {
            favoriteMovieIds.contains(movie.id!)
        }
    func toggleFavorite(movie: Movie) {
            if isFavorite(movie: movie) {
                favoriteMovieIds.remove(movie.id!)
                print("'\(movie.name!)' favorilerden kaldırıldı.")
            } else {
                favoriteMovieIds.insert(movie.id!)
                print("'\(movie.name!)' favorilere eklendi.")
            }
            
            saveFavorites()
        }
    
    private func loadFavorites() {
            let defaults = UserDefaults.standard
            if let savedFavorites = defaults.array(forKey: userDefaultsKey) as? [Int] {
                // Okuduğumuz diziyi, hızlı arama için Set yapısına dönüştürüyoruz.
                self.favoriteMovieIds = Set(savedFavorites)
                print("\(savedFavorites.count) favori UserDefaults'tan yüklendi.")
            }
        }
    private func saveFavorites() {
            let defaults = UserDefaults.standard
            let favoritesArray = Array(self.favoriteMovieIds)
            defaults.set(favoritesArray, forKey: userDefaultsKey)
            print("\(favoritesArray.count) favori UserDefaults'a kaydedildi.")
        }
}
