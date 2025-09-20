//
//  CartResponse.swift
//  MovieSalesApp
//
//  Created by Omer on 20.09.2025.
//

import Foundation
struct CartResponse: Codable{
    let movieCart: [CartItem]
    
    enum CodingKeys: String, CodingKey{
        case movieCart = "movie_cart"
    }
}
