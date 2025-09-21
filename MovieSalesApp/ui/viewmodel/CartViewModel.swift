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
    
    init(){
        Task{
            await loadCart()
        }
    }
    
    var totalPrice: Int {
        
        cartItems.reduce(0) { $0 + ($1.price * $1.orderAmount) }
    }
    
    func loadCart() async{
        do {
            cartItems = try await repo.getMovieCart()
        } catch  {
            print("An error occured while loading the cart \(error.localizedDescription)")
        }
    }
    
    func addMovieToCart(movie: Movie, amount: Int) async {
        
        
        if let existingCartItem = cartItems.first(where: { $0.name == movie.name }) {
            
            
            print("'\(movie.name!)' zaten sepette, miktar güncelleniyor...")
            do {
                
                let deleteSuccess = try await repo.deleteMovieFromCart(cartId: existingCartItem.cartId)
                
                guard deleteSuccess else {
                    print("Güncelleme için eski kayıt silinemedi.")
                    return
                }
                
                let newAmount = existingCartItem.orderAmount + amount
                let addSuccess = try await repo.addToCart(movie: movie, orderAmount: newAmount)
                
                if addSuccess {
                    print("'\(movie.name!)' filminin yeni miktarı: \(newAmount)")
                }
                
            } catch {
                print("Ürün miktarı güncellenirken bir hata oluştu: \(error.localizedDescription)")
            }
            
        } else {
            
            print("'\(movie.name!)' ilk kez sepete ekleniyor...")
            do {
                let success = try await repo.addToCart(movie: movie, orderAmount: amount)
                if !success {
                    print("Sunucu eklemeyi reddetti.")
                }
            } catch {
                print("Sepete ekleme sırasında hata: \(error.localizedDescription)")
            }
        }
        
        await loadCart()
        
    }
    
    func deleteFromCart(cartItem: CartItem) async{
        do {
            
            let success = try await repo.deleteMovieFromCart(cartId: cartItem.cartId)
            
            if success {
                
                cartItems.removeAll { $0.id == cartItem.id }
                
                print("ID'si \(cartItem.cartId) olan ürün sepetten silindi.")
            } else {
                print("Sunucu, silme işlemini reddetti.")
            }
        } catch {
            print("Silme işlemi sırasında bir hata oluştu: \(error.localizedDescription)")
        }
    }
    
}
