//
//  CartViewModel.swift
//  MovieSalesApp
//
//  Created by Omer on 20.09.2025.
//

import SwiftUI

@MainActor
class CartViewModel: ObservableObject{
    @Published var cartItems: [CartItem] = []
    private var repo = MoviesRepository()
    
    func loadCart() async{
        do {
            cartItems = try await repo.getMovieCart()
        } catch  {
            print("An error occured while loading the cart \(error.localizedDescription)")
        }
    }
}
