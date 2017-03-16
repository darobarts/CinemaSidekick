//
//  FirebaseResourceManager.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 3/16/17.
//
//

import Foundation
import FirebaseDatabase

class FirebaseResourceManager {
    static func getUser(userId : String, onComplete: @escaping (User)->()) {
        
        var ref : FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("users/" + userId).observeSingleEvent(of: .value, with : {
            (snapshot) in
            let userDict = snapshot.value as? NSDictionary
            let userName = userDict?["name"] as! String
            let wishList = userDict?["wishList"] as! NSDictionary
            let seenList = userDict?["seenList"] as! NSDictionary
            
            onComplete(User(id: userId, name: userName, wishList: wishList, seenList: seenList))
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }
}
