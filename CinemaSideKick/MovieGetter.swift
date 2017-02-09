//
//  MovieGetter.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 2/8/17.
//
//

import Foundation


class MovieGetter {
   
   
   func getMovie(movieId: String) {
      let url = URL(string: "https://api.themoviedb.org/3/movie/11?api_key=91702af3d9c57566bf5167a404863b64")
      print("Start")
      
      let task = URLSession.shared.dataTask(with: url!) {data, response, err in
         guard err == nil else {
            print(err)
            return
         }
         guard let data = data else {
            print("Data is empty")
            return
         }
         
         let json = try! JSONSerialization.jsonObject(with: data, options: [])
         print(json)
      }
      task.resume()
      
   }
}
