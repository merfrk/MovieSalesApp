//
//  HomeViewModel.swift
//  MovieSalesApp
//
//  Created by Omer on 20.09.2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    private let repo = MoviesRepository()
    @Published var movies = [Movie]()
    
    func loadMovies() async{
        do {
            movies = try await repo.loadMovies()
        } catch  {
            movies = []
        }
    }
    
}
