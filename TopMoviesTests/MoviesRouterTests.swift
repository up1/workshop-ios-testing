import XCTest
@testable import TopMovies

class MoviesRouterTests: XCTestCase {

    func test_url_with_limit_50() {
        let router = MoviesRouter(limit: 50)
        let request = router.urlRequest()
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url!.absoluteString, "https://itunes.apple.com/us/rss/topmovies/limit=50/json")
    }

    func test_url_with_limit_100() {
        let router = MoviesRouter(limit: 100)
        let request = router.urlRequest()
        XCTAssertEqual(request.url!.absoluteString, "https://itunes.apple.com/us/rss/topmovies/limit=100/json")
    }

}
