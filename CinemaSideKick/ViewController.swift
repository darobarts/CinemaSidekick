//
//  ViewController.swift
//  CinemaSideKick
//
//  Created by Santi Angelo Pierini on 2/8/17.
//
//

import UIKit
import FirebaseAuth

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
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var ratingButtons: RatingControl!
    @IBOutlet weak var upperView: UIView!
    
    
    var movieId: String = ""
    
    var currMovie: Movie?
    var movieWishList = [Movie]()
    var movieSeenList = [Movie]()

    
    @IBAction func addToWishlist(_ sender: UIBarButtonItem) {
        let uploader = FirebaseUploader()
        let auth = FIRAuth.auth()
        let userId = auth?.currentUser?.uid
        
        if(movieWishList.contains(where: hasWishMovie) == false) {
            movieWishList.append(currMovie!)

        }
        
        uploader.addMovieToUserWishlist(userId: userId!, movieId: String(describing: movieId))
    }
    
    
    // add movie to pass-list pull movie from queue
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        let uploader = FirebaseUploader()
        let auth = FIRAuth.auth()
        let userId = auth?.currentUser?.uid
        
        
//        uploader.addMovieToUserWishlist(userId: userId!, movieId: String(describing: movieId))
        
        //add movie to pass-list
        uploader.addMovieToUserPassList(userId: userId!, movieId: String(describing: movieId))
        
        //pull movie from queue
        let movieGetter = MovieGetter()
        movieGetter.getQueue(completion : {(json : NSDictionary)->() in  self.setMovieInfo(dict: json)})
        
        //reset scroll box to the top after swiping
        RoundedScroller.setContentOffset(CGPoint(x: 0, y: -50), animated: true)
    }
    
    // add movie to hate-list pull movie from queue
    @IBAction func swipeLeftTesting(_ sender: UISwipeGestureRecognizer) {
        
        let uploader = FirebaseUploader()
        let auth = FIRAuth.auth()
        let userId = auth?.currentUser?.uid
        
        //add to hate-list
        uploader.addMovieToUserHateList(userId: userId!, movieId: String(describing: movieId))
        
        //pull from queue
        let movieGetter = MovieGetter()
        movieGetter.getQueue(completion : {(json : NSDictionary)->() in  self.setMovieInfo(dict: json)})
        
        //reset scroll box to the top after swiping
        RoundedScroller.setContentOffset(CGPoint(x: 0, y: -50), animated: true)
    }
    
    // add movie to liked-list, pull from queue
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        
        let uploader = FirebaseUploader()
        let auth = FIRAuth.auth()
        let userId = auth?.currentUser?.uid
        
        if(movieSeenList.contains(where: hasSeenMovie) == false) {
            movieSeenList.append(currMovie!)
            
        }
        
        //add to liked-list
        uploader.addMovieToUserSeenList(userId: userId!, movieId: String(describing: movieId))
        
        //pull from queue
        let movieGetter = MovieGetter()
        movieGetter.getQueue(completion : {(json : NSDictionary)->() in  self.setMovieInfo(dict: json)})
        
        //reset scroll box to the top after swiping
        RoundedScroller.setContentOffset(CGPoint(x: 0, y: -50), animated: true)
    }
    

    @IBAction func nextMovie(_ sender: UIButton) {
        let movieGetter = MovieGetter()
        movieGetter.getMovie(completion : {(json : NSDictionary)->() in  self.setMovieInfo(dict: json)})
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let movieGetter = MovieGetter()
        movieGetter.getMovie(completion : {(json : NSDictionary)->() in  self.setMovieInfo(dict: json)})
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black

        //reset scroll box to the top after swiping
        RoundedScroller.setContentOffset(CGPoint(x: 0, y: -50), animated: true)
//        upperView.layer.cornerRadius = 5
        upperView.layer.shadowColor = UIColor.darkGray.cgColor
        upperView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        upperView.layer.shadowOpacity = 1.0
        upperView.layer.shadowRadius = 2
        
        moviePoster.layer.shadowColor = UIColor.darkGray.cgColor
        moviePoster.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        moviePoster.layer.shadowOpacity = 1.0
        moviePoster.layer.shadowRadius = 10
    }

    func setMovieInfo(dict : NSDictionary) {
        print("Setting movie info")
        let movieGetter = MovieGetter()
        let id = dict.value(forKey: "id")
        if id != nil {
            self.movieId = id as! String
        }
        
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
                genreString += String(describing: genre) + ", "
            }
            self.genres.text = genreString.substring(to: genreString.index(genreString.endIndex, offsetBy: -2))
            //self.genres.text = genreString.trimmingCharacters(in: CharacterSet.punctuationCharacters)
            
            //set actors
            var actorString = ""
            for (actor, _) in dict.value(forKey: "actors") as! NSDictionary {
                actorString += String(describing: actor) + ", "
            }
            self.actors.text = actorString.substring(to: actorString.index(actorString.endIndex, offsetBy: -2))
            self.actors.text = actorString.trimmingCharacters(in: CharacterSet.punctuationCharacters)
            
            //set runTime
            self.runTime.text = String(dict.value(forKey: "runtime") as! Int) + " m"
            
            //set rating
            self.movieRating.text =  String(Int((dict.value(forKey: "rating") as! Double))) + "%"
            
            //set rating stars to correspond to rating initially
            self.ratingButtons.rating = Int((dict.value(forKey: "rating") as! Double))/20
            
            //get poster
            movieGetter.getPoster(posterPath: dict.value(forKey :"poster_path") as! String, completion: {(data : Data)->()
                in DispatchQueue.main.async {
                    self.moviePoster.image = UIImage(data : data)
                    
                    //set currentMovie object to send to wishlist possibly
                    self.currMovie = Movie.init(title: self.movieTitle.text!, poster: self.moviePoster.image!, synopsis: self.synopsis.text!, releaseDate: self.releaseDate.text!, director: self.director.text!, genres: self.genres.text!, actors: self.actors.text!, runtime: self.runTime.text!, rating: self.movieRating.text!, key: self.movieId)
                }
            })
    
            
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
    
    func hasWishMovie(check: Movie) -> Bool {
        
        for movie in movieWishList {
            if(movie.title == currMovie?.title) {
                return true
            }
        }
        
        return false
    }
    
    func hasSeenMovie(check: Movie) -> Bool {
        
        for movie in movieSeenList {
            if(movie.title == currMovie?.title) {
                return true
            }
        }
        
        return false
    }
    
    
    
    //MARK: Navigation
    
    //need to erase movie from wishlist array if it was removed on other page
    @IBAction func unwindToMain(segue : UIStoryboardSegue) {
        //set like/wishlist arrays to the ones sent from wishlist/likedlist view controller
        if let sourceViewController = segue.source as? WishListViewController {
            
            movieWishList = sourceViewController.wishMovieData!
            movieSeenList = sourceViewController.seenMovieData!
            
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        //if was this segue
        if segue.identifier == "wishSegue" {
            let navVC = segue.destination as? UINavigationController
            let destinationVC = navVC?.viewControllers.first as! WishListViewController
            
            destinationVC.wishMovieData = movieWishList
            destinationVC.seenMovieData = movieSeenList
            
        }
    }


}

