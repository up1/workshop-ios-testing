//
//  TopMoviesUITests.swift
//  TopMoviesUITests
//
//  Created by Somkiat Puisungnoen on 11/3/2563 BE.
//

import Foundation
import XCTest
import SwiftLocalhost

class TopMoviesUITests: XCTestCase {

    var localhostServer: LocalhostServer!

    override func setUp() {
        continueAfterFailure = false
        self.localhostServer = LocalhostServer.initializeUsingRandomPortNumber()
        self.localhostServer.startListening()
    }

    override func tearDown() {
        self.localhostServer.stopListening()
    }

    func testSample() {
        self.localhostServer.route(method: .GET,
                                   path: "/us/rss/topmovies/limit=2/json",
                                   responseData: ResponseDataFactory.responseData(filename: "topmovies"))
        let app = XCUIApplication()
        app.launchEnvironment["url"] = "http://localhost:\(self.localhostServer.portNumber)/us/rss/topmovies/limit=2/json"
        app.launch()

        XCTAssert(isTopMovie(index: 0, movieName: "19172"))
        XCTAssert(isTopMovie(index: 1, movieName: "Bombshell2"))
    }

    func isTopMovie(index: Int, movieName: String) -> Bool {
        let result = XCUIApplication()
                .collectionViews
                .cells.element(boundBy: index)
                .staticTexts[movieName]
                .waitForExistence(timeout: 2)
        return result
    }
}
