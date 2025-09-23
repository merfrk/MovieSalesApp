//
//  MockMoviesRepository.swift
//  MovieSalesAppTests
//
//  Created by Omer on 23.09.2025.
//

import Foundation
@testable import MovieSalesApp

class MockMoviesRepository: MoviesRepositoryProtocol {
    
    
    var mockMovies: [Movie]?
    var shouldFail = false

    func loadMovies() async throws -> [Movie] {
        if shouldFail {
            throw URLError(.badServerResponse) 
        }
        
        if let movies = mockMovies {
            return movies
        }
        
        return []
    }
    
    
    func getMovieCart() async throws -> [CartItem] { [] }
    func addToCart(movie: Movie, orderAmount: Int) async throws -> Bool { true }
    func deleteMovieFromCart(cartId: Int) async throws -> Bool { true }
}
