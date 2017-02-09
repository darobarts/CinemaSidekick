//
//  MovieGetter.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 2/8/17.
//
//
import Foundation


class MovieGetter {
   
   
    func getMovie(movieId: String, completion: @escaping (NSDictionary)->()) {
      let url = URL(string: "https://api.themoviedb.org/" + movieId + "/movie/11?api_key=91702af3d9c57566bf5167a404863b64")
      print("Start")
      
      let task = URLSession.shared.dataTask(with: url!) {
        (data, response, err) in
         guard err == nil else {
            print(err ?? "No error found")
            return
         }
         guard let data = data else {
            print("Data is empty")
            return
         }
         
         let json = try! JSONSerialization.jsonObject(with: data, options: [])
        completion(json as! NSDictionary)
      }
      task.resume()
      
   }
    
    func getConfiguration(completion: @escaping (NSDictionary)->()) {
        let url = URL(string : "https://api.themoviedb.org/3/configuration?api_key=91702af3d9c57566bf5167a404863b64")
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, err) in
            guard err == nil else {
                print(err ?? "No error found")
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            completion(json as! NSDictionary)
        }
        task.resume()
    }
    
    func getPosterPath(dict : NSDictionary, poster_name : String) -> String {
        let dict2 = dict.value(forKey: "images") as! NSDictionary
        let baseUrl = dict2.value(forKey : "secure_base_url") as! String
        let sizeArray = dict2.value(forKey: "poster_sizes") as! NSArray
        let size = sizeArray.lastObject as! String
        return baseUrl + size + poster_name
    }
    
    func getPoster(posterPath : String, completion : @escaping (_ data : Data)->()) {
        let url = URL(string : posterPath)
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, err) in
            guard err == nil else {
                print(err ?? "No error found")
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            completion(data)
        }
        task.resume()
    }
}
