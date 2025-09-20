//
//  Movie.swift
//  MovieSalesApp
//
//  Created by Omer on 19.09.2025.
//

import Foundation
class Movie: Codable, Identifiable{
    var id: Int?
    var name: String?
    var image: String?
    var price: Int?
    var category: String?
    var rating: Double?
    var year: Int?
    var director: String?
    var description: String?
    
    init(){
        
    }
    
    init(id: Int? = nil, name: String? = nil, image: String? = nil, price: Int? = nil, category: String? = nil, rating: Double? = nil, year: Int? = nil, director: String? = nil, description: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.category = category
        self.rating = rating
        self.year = year
        self.director = director
        self.description = description
    }
    
    static let example = Movie(id: 1, name: "Batman", image: "batman.png", price: 20, category: "Action", rating: 9, year: 2008, director: "Nolan", description: "Lorem ipsum")
}
