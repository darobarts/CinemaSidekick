//
//  MovieGetter.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 2/8/17.
//
//
import Foundation
import FirebaseDatabase
import FirebaseAuth


class MovieGetter {
    
    //TMDB movie getter function
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
    
    //firebase random movie getter funciton
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
    
    //remove movie from queue given it's key
    func removeFromQueue(valInQueue : String) {
        
        let auth = FIRAuth.auth()
        let userId = auth?.currentUser?.uid
        
        var ref : FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("users").child(userId!).child("queue").child(valInQueue).removeValue()
        
    }
    
    //test function to retrieve movies from the Queue of recommendations
    func getQueue(completion : @escaping (NSDictionary) ->()) {
        
//        let uploader = FirebaseUploader()
        let auth = FIRAuth.auth()
        let userId = auth?.currentUser?.uid
        
        var ref : FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        //print(ref.child("users").child(userId!).child("queue"))
        
        ref.child("users").child(userId!).child("queue").observeSingleEvent(of: .value, with : {
            (snapshot) in
            
            //get queue list
            let queue = snapshot.value as? NSDictionary
            
            print(queue?.count)
            //check if there are movies in the queue
            if((queue?.count) != nil) {
            
                print(queue)
                //convert into an array of strings
                let allQueueKeys = queue?.allKeys as? [String]
                //get first Key in array
                let firstInQueue = allQueueKeys?.first
                print("first in Queue: " + firstInQueue!)
                //remove movie from queue
                self.removeFromQueue(valInQueue: firstInQueue!)
            
                //go into 'Movie' table and find matching key of first in queue
                var ref2 : FIRDatabaseReference!
                ref2 = FIRDatabase.database().reference()
                ref2.child("movies").child(firstInQueue!).observeSingleEvent(of: .value, with : {
                    (snapshot) in
                
                    //print(snapshot)
                    //get the movie information
                    completion(snapshot.value as! NSDictionary)
                }) {(error) in
                    print(error.localizedDescription)
                }
            }
            else {
                //if there were no movies in the queue (yet or ever) pull a random movie from the database
                var refRand : FIRDatabaseReference!
                refRand = FIRDatabase.database().reference()
                refRand.child("movies").observeSingleEvent(of: .value, with : {
                    (snapshot) in
                    let movies = snapshot.value as? NSDictionary
                    let allKeys = movies?.allKeys as? [String]
                    let randomIndex = Int(arc4random_uniform(UInt32(movies!.count)))
                    print("Queue was empty. Finding random movie")
                    
                    let movie = movies?.object(forKey: allKeys?[randomIndex] ?? "")
                    completion(movie! as! NSDictionary)
                }) {(error) in
                    print(error.localizedDescription)
                }
                
            }


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
