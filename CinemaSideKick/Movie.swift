//
//  Movie.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 3/16/17.
//
//

import Foundation

class Movie {
    
    var title: String
    var poster: UIImage
    var synopsis: String
    var releaseDate: String
    var director: String
    var genres: String
    var actors: String
    var runtime: String
    var rating: String
    var key: String
    
    //initializer
    init(title: String, poster: UIImage, synopsis: String, releaseDate: String, director: String, genres: String, actors: String, runtime: String, rating: String, key: String) {
        
        self.title = title
        self.poster = poster
        self.synopsis = synopsis
        self.releaseDate = releaseDate
        self.director = director
        self.genres = genres
        self.actors = actors
        self.runtime = runtime
        self.rating = rating
        self.key = key
        
    }

    


}
