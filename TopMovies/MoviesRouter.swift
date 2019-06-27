import Foundation

struct MoviesRouter {
    var limit: Int

    init(limit: Int) {
        self.limit = limit
    }

    func urlRequest() -> URLRequest {
        let url = URL(string: "https://itunes.apple.com/us/rss/topmovies/limit=\(limit)/json")!
        return URLRequest(url: url)
    }
}
