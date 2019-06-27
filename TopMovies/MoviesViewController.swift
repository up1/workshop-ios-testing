import UIKit
import AVKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!

    var movies = [Movie]()
    var moviesClient = MoviesClient()

    func refresh() {
        moviesClient.fetchMovies { [weak self] movies in
            self?.movies = movies
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        refresh()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Movie", for: indexPath) as? MovieCell {

            let movie = movies[indexPath.row]
            cell.title.text = movie.title
            cell.imageView.image = nil
            moviesClient.image(for: movie) { image in
                DispatchQueue.main.async {
                    if cell.title.text == movie.title {
                        cell.imageView.image = image
                    } else {
                        cell.imageView.image = nil
                    }
                }
            }

            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        guard let url = movie.preview else {
            print("Error: Couldn't find URL of preview to play for movie at \(indexPath)")
            return
        }

        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true, completion: {
            vc.player!.play()
        })
    }

    @IBAction func unwindToMoviesViewController(segue: UIStoryboardSegue) {
        refresh()
    }
}
