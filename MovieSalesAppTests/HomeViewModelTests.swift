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
        // ViewModel'i, gerçek repository yerine bu sahte repository ile başlatıyoruz.
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
}
