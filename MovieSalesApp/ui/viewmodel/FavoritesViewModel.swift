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
    let userDefaultsKey = "favoriteMoviesKey"
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard){
        self.defaults = defaults
        loadFavorites()
    }
    
    func isFavorite(movie: Movie) -> Bool {
            favoriteMovieIds.contains(movie.id)
        }
    func toggleFavorite(movie: Movie) {
            if isFavorite(movie: movie) {
                favoriteMovieIds.remove(movie.id)
                print("'\(movie.name)' favorilerden kaldırıldı.")
            } else {
                favoriteMovieIds.insert(movie.id)
                print("'\(movie.name)' favorilere eklendi.")
            }
            
            saveFavorites()
        }
    
    private func loadFavorites() {
            
            if let savedFavorites = defaults.array(forKey: userDefaultsKey) as? [Int] {
                
                self.favoriteMovieIds = Set(savedFavorites)
                print("\(savedFavorites.count) favori UserDefaults'tan yüklendi.")
            }
        }
    private func saveFavorites() {
            
            let favoritesArray = Array(self.favoriteMovieIds)
            defaults.set(favoritesArray, forKey: userDefaultsKey)
            print("\(favoritesArray.count) favori UserDefaults'a kaydedildi.")
        }
}
