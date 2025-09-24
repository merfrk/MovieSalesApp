//
//  MovieFlowsUITests.swift
//  MovieSalesAppUITests
//
//  Created by Omer on 24.09.2025.
//

import XCTest

final class MovieFlowsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    
    func testAddToCartFlow() throws {
            
            let app = XCUIApplication()
            app.launch()
        
        

        let batmanCard = app.buttons["movieCard_Batman"]

            XCTAssertTrue(batmanCard.waitForExistence(timeout: 15), "Ana ekranda Batman film kartı bulunamadı.")
            
            batmanCard.tap()
            
            let addToCartButton = app.buttons["addToCart_button"]
            XCTAssertTrue(addToCartButton.exists, "Detay sayfasında Sepete Ekle butonu bulunamadı.")
            
            addToCartButton.tap()
            
            sleep(3)
            
            let cartTabButton = app.tabBars.buttons["Sepet"]
            XCTAssertTrue(cartTabButton.exists, "Tab Bar'da Sepet butonu bulunamadı.")
            cartTabButton.tap()
            
            let cartItemText = app.staticTexts["Batman"]
            XCTAssertTrue(cartItemText.exists, "Sepete eklenen Batman filmi, sepet ekranında görünmüyor.")
        }
}
