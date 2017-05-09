//
//  FirebaseUploader.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 3/1/17.
//
//

import Foundation
import FirebaseDatabase

class FirebaseUploader {
    
    var ref : FIRDatabaseReference!
    
    func addUser(user : User) {
        ref = FIRDatabase.database().reference()
        let userDict = user.getDictView()
        ref.child("users").child(user.id).setValue(userDict)

    }
    
    //add movie to wish-list if user pressed button
    func addMovieToUserWishlist(userId : String, movieId : String) {
        addMovieToList(userId: userId, movieId: movieId, listName: "wishList")
    }
    
    //add movie to like-list if user swiped right
    func addMovieToUserSeenList(userId : String, movieId : String) {
        addMovieToList(userId: userId, movieId: movieId, listName: "likeList")
        //firebase functions reccomend movies based on this list
    }
    
    // add a movie to hate-list if user swiped left
    func addMovieToUserHateList(userId : String, movieId : String) {
        addMovieToList(userId: userId, movieId: movieId, listName: "hateList")

    }
    
    //add movie to pass-list if user swiped up
    func addMovieToUserPassList(userId : String, movieId : String) {
        addMovieToList(userId: userId, movieId: movieId, listName: "passList")
        //firebase functions reccomend movies based on this list
    }
    
    private func addMovieToList(userId : String!, movieId : String!, listName : String) {
        if (userId != nil && movieId != nil) {
            ref = FIRDatabase.database().reference()
            ref.child("users").child(userId!).child(listName).child(String(movieId)).setValue(1)
        }
    }
    
    
    
    
}
