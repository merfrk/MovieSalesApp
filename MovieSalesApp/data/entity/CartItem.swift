//
//  CartItem.swift
//  MovieSalesApp
//
//  Created by Omer on 20.09.2025.
//

import Foundation
struct CartItem: Codable, Identifiable {
    
    let cartId: Int
    let name: String
    let image: String
    let price: Int
    let category: String
    let rating: Double
    let year: Int
    let director: String
    let description: String
    let orderAmount: Int
    let userName: String
    
    var id: Int { cartId }
}
