# Workshop :: Automated testing for iOS app with Swift
* Unit testing
* UI testing
* Fastlane
* Swift Localhost

## Code for Testing in Settings page

SettingsTests.swift
```
class SettingsTests: XCTestCase {
    func settingsViewController() -> SettingsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        _ = vc.view
        return vc
    }
    
    // Your test cases
     
}

extension SettingsViewController {
    func enterText(_ text: String) {
        _ = textField(number, shouldChangeCharactersIn: NSRange(location: number.text!.count, length: 0), replacementString: text)
    }
}
```

SettingsWithUserDefaultsTests.swift
```
class SettingsWithUserDefaultsTests: SettingsTests {
    // Your test cases
}


class FakeUserDefaults: UserDefaults {
    var store = [String: Any?]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        store[key] = value
    }
    
    override func value(forKey key: String) -> Any? {
        if let value = store[key] {
            return value
        }
        return nil
    }
}
```

## Code for Testing in Top moview page

MoviesViewControllerTests.swift
```
class MoviesViewControllerTests: XCTestCase {
    
    func moviesViewController(
        client: MoviesClient = StubMoviesClient(movies: []))
        -> MoviesViewController {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Movies")
            as! MoviesViewController
        vc.moviesClient = client
        let _ = vc.view
        return vc

    }
    
    func createMovie(title: String = "TEST") -> Movie {
        return Movie(title: title)
    }
    
    // Your test cases
    
}


class StubMoviesClient: MoviesClient {
    var movies: [Movie]
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    override func fetchMovies(completion: (([Movie]) -> Void)?) {
        completion!(movies)
    }
}


```

## Code for test Movies Client

MoviesClientTests.swift
```
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
```

## UI Testing in Top Movies Page

TopMoviesUITests.swift
```
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
```

MoviesRouter.swift
```
struct MoviesRouter {
    var limit: Int

    init(limit: Int) {
        self.limit = limit
    }

    func urlRequest() -> URLRequest {
        if let fromTest = ProcessInfo.processInfo.environment["url"].self {
            let url = URL(string: fromTest)!
            return URLRequest(url: url)
        }
        
        let url = URL(string: "https://itunes.apple.com/us/rss/topmovies/limit=\(limit)/json")!
        return URLRequest(url: url)
    }
}
```

## Working with [SwiftLocalhost](https://github.com/depoon/SwiftLocalhost)
```
$git clone https://github.com/up1/workshop-ios-testing.git -b swiftlocalhost
$pod update
$open TopMovies.xcworkspace
```
