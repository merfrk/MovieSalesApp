//
//  CartViewModelIntegrationTests.swift
//  MovieSalesAppTests
//
//  Created by Omer on 23.09.2025.
//

import XCTest
@testable import MovieSalesApp

@MainActor
final class CartViewModelIntegrationTests: XCTestCase {

    var viewModel: CartViewModel!
    
    override func setUp() async throws {
        try await  super.setUp()
        let repo = MoviesRepository()
        do {
            let itemsToDelete = try await repo.getMovieCart()
            for item in itemsToDelete {
                        _ = try await repo.deleteMovieFromCart(cartId: item.cartId)
                    }
            print("✅ Test için sepet temizlendi. Kalan ürün: \(try await repo.getMovieCart().count)")
        } catch  {
            if error is DecodingError {
                       
                       
                       print("⚠️ Temizlik sırasında sepetin zaten boş olduğu anlaşıldı (DecodingError yakalandı). Teste devam ediliyor.")
                   } else {
                       
                       throw error
                   }
        }
        
        
        
        viewModel = CartViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
         try super.tearDownWithError()
    }

    func testAddAndThenDeleteMovieFromCart_IntegrationTest() async throws {
            
            let movieToAdd = Movie.example
            

            await viewModel.addMovieToCart(movie: movieToAdd, amount: 1)

           
            XCTAssertFalse(viewModel.cartItems.isEmpty, "Sepete film eklendikten sonra sepet boş olmamalıdır.")
            
            let addedItem = viewModel.cartItems.first { $0.name == movieToAdd.name }
            XCTAssertNotNil(addedItem, "'\(movieToAdd.name)' filmi sepette bulunmalıdır.")
            
            
            guard let itemToDelete = addedItem else {
                XCTFail("Silinecek öğe sepette bulunamadı, testin devamı anlamsız.")
                return
            }

           
            await viewModel.deleteFromCart(cartItem: itemToDelete)

            
            await viewModel.loadCart()
            
            let deletedItemExists = viewModel.cartItems.contains { $0.cartId == itemToDelete.cartId }
            XCTAssertFalse(deletedItemExists, "Film sepetten silindikten sonra listede olmamalıdır.")
        }
    
    func testAddExistingMovie_ShouldUpdateQuantity() async {
           
           let movie = Movie.example

           
           
           await viewModel.addMovieToCart(movie: movie, amount: 1)
           await viewModel.addMovieToCart(movie: movie, amount: 2)
           
           
           
           XCTAssertEqual(viewModel.cartItems.count, 1, "Sepette aynı filmden birden fazla satır olmamalıdır.")
           XCTAssertEqual(viewModel.cartItems.first?.orderAmount, 3, "Miktar doğru şekilde toplanmalıdır (1 + 2 = 3).")
       }
    func testTotalPrice_WithMultipleDifferentItems() async {
            
            let movieA = Movie.example
            let movieB = Movie.example2
            
            
            
            await viewModel.addMovieToCart(movie: movieA, amount: 2)
            await viewModel.addMovieToCart(movie: movieB, amount: 1)
            
        XCTAssertEqual(viewModel.cartItems.count, 2, "Sepete 2 farklı ürün eklenmiş olmalıdır.")
        let totalFromServer = viewModel.cartItems.reduce(0) { $0 + ($1.price * $1.orderAmount) }
           
        XCTAssertEqual(viewModel.totalPrice, totalFromServer, "ViewModel'in totalPrice özelliği, sunucudan gelen veriye göre doğru toplamı hesaplamalıdır.")

        }
    
    

}
