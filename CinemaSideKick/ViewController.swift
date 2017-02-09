//
//  ViewController.swift
//  CinemaSideKick
//
//  Created by Santi Angelo Pierini on 2/8/17.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    

    @IBAction func nextMovie(_ sender: UIButton) {
        movieTitle.text = "Default"
        let movieGetter = MovieGetter()
        movieGetter.getMovie(movieId: "3", completion : {(json : NSDictionary)->() in  self.setMovieInfo(dict: json)})
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func setMovieInfo(dict : NSDictionary) {
        print("Setting movie info")
        let movieGetter = MovieGetter()
        let posterPath = dict.value(forKey: "poster_path") as! String?
        movieGetter.getConfiguration(completion: {(json : NSDictionary)->()
            in movieGetter.getPoster(posterPath: movieGetter.getPosterPath(dict: json, poster_name: posterPath!) ,completion: {(data : Data)->()
                in DispatchQueue.main.async {
                    self.moviePoster.image = UIImage(data : data) }
                })})
        
        print(dict)
        DispatchQueue.main.async {
            self.movieTitle.text = dict.value(forKey: "title") as! String?
            self.synopsis.text = dict.value(forKey: "overview") as! String?
            self.releaseDate.text = dict.value(forKey: "release_date") as! String?
            //TODO: set all other information here
        }


    }


}

