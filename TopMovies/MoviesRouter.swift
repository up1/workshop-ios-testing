import Foundation

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
