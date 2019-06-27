import XCTest
@testable import TopMovies

class MoviesParserTests: XCTestCase {
func test_movies_from_data() {
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "movies", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: path!))

    let parser = MoviesParser()
    let movies = parser.movies(from: data)
    XCTAssertEqual(movies.count, 5)
    XCTAssertEqual(movies.first!.title, "Jumanji: Welcome to the Jungle")
    XCTAssertEqual(movies.first!.image!.absoluteString, "https://is3-ssl.mzstatic.com/image/thumb/Video118/v4/93/f7/df/93f7dfb6-2772-6625-0c96-fc74a8ac98d8/pr_source.lsr/113x170bb-85.png")
}
}
