//
//  MoviesRepositoryProtocol.swift
//  MovieSalesApp
//
//  Created by Omer on 23.09.2025.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func loadMovies() async throws -> [Movie]
    func getMovieCart() async throws -> [CartItem]
    func addToCart(movie: Movie, orderAmount: Int) async throws -> Bool
    func deleteMovieFromCart(cartId: Int) async throws -> Bool
}
