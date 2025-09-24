//
//  HomeViewModelTests.swift
//  MovieSalesAppTests
//
//  Created by Omer on 23.09.2025.
//

import XCTest
@testable import MovieSalesApp

@MainActor
final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockRepository: MockMoviesRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockRepository = MockMoviesRepository()
        
        viewModel = HomeViewModel(repo: mockRepository)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
        try super.tearDownWithError()
    }
    
    
    func testLoadMovies_WhenSuccessful_ShouldUpdateMoviesProperty() async {
        
        let mockMovies = [Movie.example, Movie.example2]
        mockRepository.mockMovies = mockMovies
        
        
        await viewModel.loadMovies()
        
        
        XCTAssertEqual(viewModel.movies.count, 2)
        XCTAssertEqual(viewModel.movies.first?.name, Movie.example.name)
    }
    
    
    func testLoadMovies_WhenRepositoryThrowsError_ShouldSetMoviesToEmptyArray() async {
        
        mockRepository.shouldFail = true
        
        await viewModel.loadMovies()
        
        
        XCTAssertTrue(viewModel.movies.isEmpty, "Hata durumunda filmler dizisi boş olmalıdır.")
    }
    
    func testLoadMovies_IntegrationTest_WithRealNetwork() async throws {
        
        let viewModel = HomeViewModel()
        
        
        await viewModel.loadMovies()
        
        
        XCTAssertFalse(viewModel.movies.isEmpty, "Gerçek ağ isteği başarılı olduğunda filmler dizisi boş olmamalıdır.")
        
        
        XCTAssertFalse(viewModel.movies.first?.name.isEmpty ?? true, "İlk filmin adı boş olmamalıdır.")
    }
    
    func testFilterAndSortFlow_IntegrationTest() async throws{
        
        let viewModel = HomeViewModel()
        
        
        await viewModel.loadMovies()
        XCTAssertFalse(viewModel.movies.isEmpty, "Filmler sunucudan yüklenmelidir.")
        
        guard let categoryToTest = viewModel.allCategories.first(where: { $0 != "Tümü" }) else {
               throw XCTSkip("Testin devam etmesi için sunucudan test edilecek bir kategori bulunamadı.")
           }
        viewModel.selectedCategory = categoryToTest
        
        
        let filteredMovies = viewModel.filteredAndSortedMovies
            XCTAssertFalse(filteredMovies.isEmpty, "Kategori filtresi en az bir sonuç döndürmelidir.")
            XCTAssertTrue(filteredMovies.allSatisfy { $0.category == categoryToTest }, "Filtrelenen tüm filmler seçilen kategoride olmalıdır.")

            
        guard let movieToSearch = filteredMovies.first else {
               throw XCTSkip("Arama testi için filtrelenmiş listede film bulunamadı.")
           }
           let movieNameToSearch = movieToSearch.name
            
            
        viewModel.searchText = movieNameToSearch
            
            
            XCTAssertTrue(viewModel.filteredAndSortedMovies.allSatisfy { $0.name == movieNameToSearch }, "Arama sonucu sadece aranan filmi içermelidir.")

            viewModel.searchText = ""
            
            viewModel.selectedSortOption = .priceDesc
            let sortedMovies = viewModel.filteredAndSortedMovies
            
            if sortedMovies.count > 1 {
                let firstPrice = sortedMovies[0].price
                let secondPrice = sortedMovies[1].price
                XCTAssertGreaterThanOrEqual(firstPrice, secondPrice, "Filmler fiyata göre azalan şekilde sıralanmalıdır.")
            }

    }
}
