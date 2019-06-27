import XCTest
@testable import TopMovies

class MoviesClientTests: XCTestCase {
    func test_fetch_calls_dataTask() {
        let mockSession = MockURLSession()
        let client = MoviesClient()
        client.session = mockSession
        client.fetchMovies()
        XCTAssertTrue(mockSession.calledDataTask)
        XCTAssertEqual(mockSession.dataTaskRequest!, client.router.urlRequest())
    }

    func test_fetch_calls_URLSessionDataTask_resume() {
        let mockSession = MockURLSession()
        let client = MoviesClient()
        client.session = mockSession
        client.fetchMovies()
        XCTAssertTrue(mockSession.mockDataTask!.calledResume)
    }

    func test_fetch_calls_completion() {
        let client = MoviesClient()
        let completionExpectation = expectation(description: "Fetch movies should call completion")
        client.fetchMovies { _ in
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }

    func test_fetch_calls_MoviesParser_movies() {
        let mockSession = MockURLSession()
        let mockParser = MockMoviesParser()
        let client = MoviesClient()
        client.session = mockSession
        client.parser = mockParser
        let completionExpectation = expectation(description: "Fetch movies should call MoviesParser")

        client.fetchMovies { _ in
            XCTAssertTrue(mockParser.calledMovies)
            completionExpectation.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func test_fetch_does_not_call_MoviesParser_movies_with_nil_data() {
        let mockParser = MockMoviesParser()
        let stubSession = StubURLSessionWithNilData()
        let client = MoviesClient()
        client.session = stubSession
        client.parser = mockParser
        let completionExpectation = expectation(description: "Fetch movies should call MoviesParser")

        client.fetchMovies { _ in
            XCTAssertFalse(mockParser.calledMovies)
            completionExpectation.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func test_image_calls_dataTask() {
        let mockSession = MockURLSession()
        let client = MoviesClient()
        let movie = Movie(title: "Test Movie", image: URL(string: "https://example.com/image.png")!)
        client.session = mockSession
        client.image(for: movie)
        XCTAssertTrue(mockSession.calledDataTask)
        XCTAssertEqual(mockSession.dataTaskRequest!.url!, movie.image)
    }

    func test_image_calls_completion() {
        let client = MoviesClient()
        let completionExpectation = expectation(description: "Fetch image should call completion")
        let movie = Movie(title: "Test Movie", image: URL(string: "https://example.com/image.png")!)
        client.image(for: movie) { _ in
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }

}

class MockURLSession: URLSession {
    var calledDataTask = false
    var dataTaskRequest: URLRequest?
    var mockDataTask: MockURLSessionDataTask?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        calledDataTask = true
        dataTaskRequest = request
        mockDataTask = MockURLSessionDataTask()
        mockDataTask!.completionHandler = completionHandler
        return mockDataTask!
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    var calledResume = false
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    override func resume() {
        calledResume = true
        completionHandler?(Data(), nil, nil)
    }
}

class MockMoviesParser: MoviesParser {
    var calledMovies = false

    override func movies(from data: Data) -> [Movie] {
        calledMovies = true
        return []
    }
}

class StubURLSessionWithNilData: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let stubDataTask = StubURLSessionDataTaskWithNilData()
        stubDataTask.completionHandler = completionHandler
        return stubDataTask
    }
}

class StubURLSessionDataTaskWithNilData: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    override func resume() {
        completionHandler?(nil, nil, nil)
    }
}
