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
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var actors: UILabel!
    
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        

        
        let movieGetter = MovieGetter()
        movieGetter.getMovie(completion : {(json : NSDictionary)->() in  self.setMovieInfo(dict: json)})
    }
    

    @IBAction func nextMovie(_ sender: UIButton) {
        let movieGetter = MovieGetter()
        movieGetter.getMovie(completion : {(json : NSDictionary)->() in  self.setMovieInfo(dict: json)})
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func setMovieInfo(dict : NSDictionary) {
        print("Setting movie info")
        let movieGetter = MovieGetter()

        //get poster
        movieGetter.getPoster(posterPath: dict.value(forKey :"poster_path") as! String, completion: {(data : Data)->()
                in DispatchQueue.main.async {
                    self.moviePoster.image = UIImage(data : data) }
                })
        
        DispatchQueue.main.async {
            self.movieTitle.text = dict.value(forKey: "title") as! String?
            self.synopsis.text = dict.value(forKey: "overview") as! String?
            self.releaseDate.text = dict.value(forKey: "release_date") as! String?

            //set director
            self.director.text = dict.value(forKey: "director") as! String?
            //set rating
            
            //set genre
            var genreString = ""
            for (genre, _) in dict.value(forKey: "genres") as! NSDictionary {
                genreString += String(describing: genre) + ","
            }
            self.genres.text = genreString.trimmingCharacters(in: CharacterSet.punctuationCharacters)
            
            //set actors
            var actorString = ""
            for (actor, _) in dict.value(forKey: "actors") as! NSDictionary {
                actorString += String(describing: actor) + ","
            }
            self.actors.text = actorString.trimmingCharacters(in: CharacterSet.punctuationCharacters)
            
            //set runTime
            self.runTime.text = String(dict.value(forKey: "runtime") as! Int) + " m"
        }


    }


}

