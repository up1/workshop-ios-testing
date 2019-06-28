import XCTest
@testable import TopMovies

class MoviesClientTests: XCTestCase {

    func test_fetch_calls_completion() {
        let client = MoviesClient()
        client.router = StubMoviesRouter(limit: 6)
        let completionExpectation = expectation(description: "Fetch movies should call completion")
        client.fetchMovies { movies in
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

}

class StubMoviesRouter: MoviesRouter {
    override func urlRequest() -> URLRequest {
        let url = URL(string: "http://192.168.1.33:8882/us/rss/topmovies/limit=6/json")!
        return URLRequest(url: url)
    }
}
