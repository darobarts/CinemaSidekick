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
        ref.child("users").setValue([user.id : userDict])

    }
    
    func addMovieToUserWishlist(userId : String, movieId : String) {
        addMovieToList(userId: userId, movieId: movieId, listName: "wishList")
    }
    
    func addMovieToUserSeenList(userId : String, movieId : String) {
        addMovieToList(userId: userId, movieId: movieId, listName: "seenList")
    }
    
    private func addMovieToList(userId : String!, movieId : String!, listName : String) {
        if (userId != nil && movieId != nil) {
            ref = FIRDatabase.database().reference()
            ref.child("users").child(userId!).child(listName).child(String(movieId)).setValue(1)
        }
    }
    
    
    
    
}
