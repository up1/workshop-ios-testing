import UIKit

class MoviesClient {
    var session = URLSession.shared
    var router = MoviesRouter(limit: 50)
    var parser = MoviesParser()
    var userDefaults = UserDefaults.standard

    func fetchMovies(completion: (([Movie]) -> Void)? = nil) {
        if let limit = userDefaults.value(forKey: UserDefaultsKeys.numberOfResults.rawValue) as? Int {
            router.limit = limit
        } else {
            router.limit = 50
        }

        let request = router.urlRequest()
        let task = session.dataTask(with: request) { [weak self] data, _, _ in
            guard let data = data,
                let movies = self?.parser.movies(from: data) else {
                    completion?([])
                    return
            }

            completion?(movies)
        }
        task.resume()
    }

    func image(for movie: Movie, completion: ((UIImage?) -> Void)? = nil) {
        guard let url = movie.image else {
            completion?(nil)
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let data = data,
                error == nil,
                let image = UIImage(data: data) else {
                    completion?(nil)
                    return
            }
            completion?(image)
        }
        task.resume()
    }

}
