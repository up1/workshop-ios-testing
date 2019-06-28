//
//  TopMoviesUITests.swift
//  TopMoviesUITests
//
//  Created by Somkiat Puisungnoen on 28/6/2562 BE.
//

import XCTest

class TopMoviesUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchEnvironment["url"] = "http://192.168.1.33:8882/us/rss/topmovies/limit=6/json"
        app.launch()
    }

    func test_show_6_items() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        XCTAssertEqual(6, collectionViewsQuery.cells.count)
    }

    func test_show_first_item() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let firstMovieName = collectionViewsQuery.cells.element(boundBy: 0).staticTexts["movieName"].label
        XCTAssertEqual("Dumbox", firstMovieName)
    }

}
