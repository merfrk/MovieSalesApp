//
//  Movie.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import Foundation
struct Movie: Codable, Identifiable, Equatable{
    var id: Int
    var name: String
    var image: String
    var price: Int
    var category: String
    var rating: Double
    var year: Int
    var director: String
    var description: String
    
    static let example = Movie(id: 1, name: "Batman", image: "batman.png", price: 28, category: "Action", rating: 9, year: 2008, director: "Nolan", description: "Lorem ipsum")
    
    static let example2 =  Movie(id:2, name: "Hobbit", image: "hobbit.png", price: 15, category: "Fantastic", rating: 7.8, year: 2012, director: "Peter Jackson", description: "Lorem ipsum")
}
