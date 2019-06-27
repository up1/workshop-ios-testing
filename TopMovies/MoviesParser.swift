import Foundation

class MoviesParser {
    func movies(from data: Data) -> [Movie] {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(MoviesResponse.self, from: data)
            let movies = response.feed.entries.map { Movie(from: $0) }
            return movies
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}
