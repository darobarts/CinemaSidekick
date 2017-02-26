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
    @IBOutlet weak var RoundedScroller: RoundedScrollView!
    
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        
        //reset scroll box to the top after swiping
        RoundedScroller.setContentOffset(CGPoint(x: 1, y: 1), animated: true)
        
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
            
            //get and reformat the release date
            self.releaseDate.text = self.formatReleaseDate(date: dict.value(forKey: "release_date") as! String)
            //dict.value(forKey: "release_date") as! String?

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
    
    // make the release date this format: MonthName, DD, YYYY
    func formatReleaseDate(date: String) -> String {
        
        let sentence = date
        
        let year =  sentence[sentence.index(sentence.startIndex,
                                offsetBy: 0)...sentence.index(sentence.startIndex,
                                offsetBy: 3)]
        
        let month = sentence[sentence.index(sentence.startIndex,
                                           offsetBy: 5)...sentence.index(sentence.startIndex,
                                           offsetBy: 6)]
        
        let day = sentence[sentence.index(sentence.startIndex,
                                            offsetBy: 8)...sentence.index(sentence.startIndex,
                                            offsetBy: 9)]
        
        return translateMonth(num: month) + " " + day + ", " + year
        
    }
    
    //translate number date to string
    func translateMonth(num: String) -> String {
        if(num == "01"){return "January"}
        if(num == "02"){return "February"}
        if(num == "03"){return "March"}
        if(num == "04"){return "April"}
        if(num == "05"){return "May"}
        if(num == "06"){return "June"}
        if(num == "07"){return "July"}
        if(num == "08"){return "August"}
        if(num == "09"){return "September"}
        if(num == "10"){return "October"}
        if(num == "11"){return "November"}
        if(num == "12"){return "December"}
        
        return "##"
    }


}

