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
    
    func addMovieToUserWishlist(userId : String, movieId : String) {
        addMovieToList(userId: userId, movieId: movieId, listName: "wishList")
    }
    
    func addMovieToUserSeenList(userId : String, movieId : String) {
        addMovieToList(userId: userId, movieId: movieId, listName: "likeList")
        //firebase functions reccomend movies based on this list
    }
    
    private func addMovieToList(userId : String!, movieId : String!, listName : String) {
        if (userId != nil && movieId != nil) {
            ref = FIRDatabase.database().reference()
            ref.child("users").child(userId!).child(listName).child(String(movieId)).setValue(1)
        }
    }
    
    
    
    
}
