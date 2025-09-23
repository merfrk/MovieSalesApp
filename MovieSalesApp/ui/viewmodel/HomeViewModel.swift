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
    
    init(repo: MoviesRepositoryProtocol = MoviesRepository()){
        self.repo = repo
    }
    
    var allCategories: [String] {
            
            let all = ["Tümü"]
            
            let categoriesWithDuplicates = movies.compactMap { $0.category }
            
            let uniqueCategories = Set(categoriesWithDuplicates)
            
            return all + Array(uniqueCategories).sorted()
        }
    
    func loadMovies() async{
        do {
            movies = try await self.repo.loadMovies()
        } catch  {
            movies = []
        }
    }
}
