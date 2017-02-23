//
//  MovieGetter.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 2/8/17.
//
//
import Foundation
import FirebaseDatabase

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
    
    func getMovie(completion : @escaping (NSDictionary) ->()) {
        var ref : FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("movies").observeSingleEvent(of: .value, with : {
            (snapshot) in
            let movies = snapshot.value as? NSDictionary
            let allKeys = movies?.allKeys as? [String]
            let randomIndex = Int(arc4random_uniform(UInt32(movies!.count)))
            
            let movie = movies?.object(forKey: allKeys?[randomIndex] ?? "")
            completion(movie! as! NSDictionary)
        }) {(error) in
            print(error.localizedDescription)
        }
        
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
