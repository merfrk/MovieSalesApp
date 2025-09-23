//
//  HomeViewModel.swift
//  MovieSalesApp
//
//  Created by Omer on 20.09.2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    private let repo: MoviesRepositoryProtocol
    @Published var movies = [Movie]()
    @Published var selectedSortOption: SortOption = .name
    
    @Published var selectedCategory: String = "Tümü"
        @Published var searchText: String = ""

    
    init(repo: MoviesRepositoryProtocol = MoviesRepository()){
        self.repo = repo
    }
    
    var allCategories: [String] {
            
            let all = ["Tümü"]
            
            let categoriesWithDuplicates = movies.compactMap { $0.category }
            
            let uniqueCategories = Set(categoriesWithDuplicates)
            
            return all + Array(uniqueCategories).sorted()
        }
    
    var filteredAndSortedMovies: [Movie] {
            var filtered: [Movie]
            
            
            if selectedCategory == "Tümü" {
                filtered = movies
            } else {
                filtered = movies.filter { $0.category == selectedCategory }
            }
            
            
            if !searchText.isEmpty {
                filtered = filtered.filter { movie in
                    movie.name.localizedCaseInsensitiveContains(searchText)
                }
            }
            
            
            switch selectedSortOption {
            case .name:
                filtered.sort { $0.name < $1.name }
            case .priceAsc:
                filtered.sort { $0.price < $1.price }
            case .priceDesc:
                filtered.sort { $0.price > $1.price }
            case .ratingDesc:
                filtered.sort { $0.rating > $1.rating }
            }
            
            return filtered
        }
    
    func loadMovies() async{
        do {
            movies = try await self.repo.loadMovies()
        } catch  {
            movies = []
        }
    }
}
