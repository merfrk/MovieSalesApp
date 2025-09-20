//
//  MoviesRepository.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import Foundation

class MoviesRepository{
    private let baseUrl = "http://kasimadalan.pe.hu/movies/"
    private let userName = "omerartan"
    
    func loadMovies() async throws -> [Movie]{
        let apiUrl = "\(baseUrl)getAllMovies.php"
        
        guard let url = URL(string: apiUrl) else {
            throw URLError(.badURL)
        }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        return movieResponse.movies ?? []
    }
    
    func addToCart(movie: Movie, orderAmount: Int) async throws -> Bool {
            let endpoint = "insertMovie.php"
            guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters: [String: Any] = [
                "name": movie.name!,
                "image": movie.image!,
                "price": movie.price!,
                "category": movie.category!,
                "rating": movie.rating!,
                "year": movie.year!,
                "director": movie.director!,
                "description": movie.description!,
                "orderAmount": orderAmount,
                "userName": userName
            ]
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            

            
            
            let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
            
            
            if serverResponse.success == 1 {
                return true
            } else {
                
                print("Sunucu Hatası: \(serverResponse.message)")
                return false
            }
        }
    
    func getMovieCart() async throws -> [CartItem]{
        let endpoint = "getMovieCart.php"
                guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
                    throw URLError(.badURL)
                }
                
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                
               
                let bodyString = "userName=\(userName)"
                request.httpBody = bodyString.data(using: .utf8)
                
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                
                let response = try JSONDecoder().decode(CartResponse.self, from: data)
                
                
                return response.movieCart
    }
    
    func deleteMovieFromCart(cartId: Int, userName: String) async throws -> Bool {
            let endpoint = "deleteMovie.php"
            guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
                throw URLError(.badURL)
            }
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            
            let bodyString = "cartId=\(cartId)&userName=\(userName)"
            request.httpBody = bodyString.data(using: .utf8)
            
            // Sunucuya verinin formatını bildirmek için header ekliyoruz.
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            
            let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
            
            
            if serverResponse.success == 1 {
                return true
            } else {
                print("Sunucu Hatası (Silme): \(serverResponse.message)")
                return false 
            }
        }
}
