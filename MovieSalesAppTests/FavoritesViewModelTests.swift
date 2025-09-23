//
//  FavoritesViewModelTests.swift
//  MovieSalesAppTests
//
//  Created by Omer on 22.09.2025.
//

import XCTest

@testable import MovieSalesApp

@MainActor
final class FavoritesViewModelTests: XCTestCase {
    var viewModel: FavoritesViewModel!
        var userDefaults: UserDefaults!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.userDefaults = UserDefaults(suiteName: #file)
                
                viewModel = FavoritesViewModel(defaults: userDefaults)
    }
    
    override func tearDownWithError() throws {
        userDefaults.removePersistentDomain(forName: #file)
                userDefaults = nil
                viewModel = nil
        try super.tearDownWithError()
    }
    
    func testToggleFavorite_WhenAddingMovie_ShouldBeFavorite() {
        
               let movie = Movie.example
        
        viewModel.toggleFavorite(movie: movie)
        
        let isFavorite = viewModel.isFavorite(movie: movie)
        XCTAssertTrue(isFavorite, "Film favorilere eklendikten sonra favori olarak işaretlenmelidir.")
    }
    
    func testToggleFavorite_WhenRemovingMovie_ShouldNotBeFavorite() {
        
        let movie = Movie.example
        viewModel.toggleFavorite(movie: movie)
        
        
        viewModel.toggleFavorite(movie: movie)
        
        
        let isFavorite = viewModel.isFavorite(movie: movie)
        XCTAssertFalse(isFavorite, "Favorideki bir film tekrar toggle yapıldığında favori olmamalıdır.")
    }
    
}
