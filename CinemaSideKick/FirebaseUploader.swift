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
        ref = FIRDatabase.database().reference()
        ref.child("users").child(userId).setValue(1, forUndefinedKey: movieId)
    }
    
    func addMovieToUserSeenList(userId : String, movieId : String) {
        ref = FIRDatabase.database().reference()
        ref.child("users").child(userId).setValue(1, forUndefinedKey: movieId)
    }
    
    
    
    
}
