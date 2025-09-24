//
//  MoviesRepository.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import Foundation

class MoviesRepository: MoviesRepositoryProtocol{
    private let baseUrl = "http://kasimadalan.pe.hu/movies/"
    private let userName = "omerartan"
    
    func loadMovies() async throws -> [Movie]{
        let apiUrl = "\(baseUrl)getAllMovies.php"
        
        guard let url = URL(string: apiUrl) else {
            throw URLError(.badURL)
        }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        return movieResponse.movies
    }
    
    
    func addToCart(movie: Movie, orderAmount: Int) async throws -> Bool {
            let endpoint = "insertMovie.php"
            guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
          
            var components = URLComponents()
            components.queryItems = [
                URLQueryItem(name: "name", value: movie.name),
                URLQueryItem(name: "image", value: movie.image),
                URLQueryItem(name: "price", value: String(movie.price)),
                URLQueryItem(name: "category", value: movie.category),
                URLQueryItem(name: "rating", value: String(movie.rating)),
                URLQueryItem(name: "year", value: String(movie.year)),
                URLQueryItem(name: "director", value: movie.director),
                URLQueryItem(name: "description", value: movie.description),
                URLQueryItem(name: "orderAmount", value: String(orderAmount)),
                URLQueryItem(name: "userName", value: userName)
            ]
            
            
            request.httpBody = components.query?.data(using: .utf8)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
            
            if serverResponse.success == 1 {
                return true
            } else {
                print("Sunucu Hatası (Ekleme): \(serverResponse.message)")
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
        
        do {
                let response = try JSONDecoder().decode(CartResponse.self, from: data)
                return response.movieCart
            } catch {
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("GELEN HATALI JSON: \(jsonString)")
                }
                
                throw error
            }
                
            
    }
    
    func deleteMovieFromCart(cartId: Int) async throws -> Bool {
            let endpoint = "deleteMovie.php"
            guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
                throw URLError(.badURL)
            }
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            
            let bodyString = "cartId=\(cartId)&userName=\(userName)"
            request.httpBody = bodyString.data(using: .utf8)
            
            
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
